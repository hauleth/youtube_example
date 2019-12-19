% Simplest ping pong module
-module(ping_pong).

% This module implements gen_server behaviour (Erlang name for interfaces)
-behaviour(gen_server).

% Traditionally function to start and link process is named start_link, the
% slash number is used to declare arity (number of arguments) as for Erlang
% foo/1 and foo/2 are completely different functions.
-export([start_link/1]).

% Behaviour callbacks, aka interface implementation
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2]).

% Spawn new process that will run ?MODULE:init/1 function
start_link(Name) ->
    gen_server:start_link({local,Name}, ?MODULE, Name, []).

% Register process with name and then run loop/0
init(Name) -> {ok, Name}.

% Noop implementation of callback that we do not use
handle_call(_Msg, _Ref, State) ->
    {reply, ok, State}.

% Noop implementation of callback that we do not use
handle_cast(_Msg, State) ->
    {noreply, State}.

% Receive message that is not call nor cast
% As you can see, if process is named we can use that name instead of it's Pid
handle_info({ping, Pid}, Name) ->
    % Print information that we received message
    io:format("~p received ping from ~p~n", [Name, Pid]),
    % Sleep for one second
    timer:sleep(1000),
    % Send message to the sender
    Pid ! {ping, Name},
    {noreply, Name}.
