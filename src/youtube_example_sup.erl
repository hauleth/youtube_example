%%%-------------------------------------------------------------------
%% @doc youtube_example top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(youtube_example_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    case supervisor:start_link({local, ?SERVER}, ?MODULE, []) of
        % If successfully started supervisor and it's children then send ping to
        % one process to start loop.
        {ok, _} = Res ->
            ping ! {ping, pong},
            Res;
        Err -> Err
    end.

init([]) ->
    % Supervisor options, for more read the OTP documentation
    SupFlags = #{strategy => one_for_all,
                 intensity => 0,
                 period => 1},
    % Define two children that will send messages between them, one named ping
    % other named pong.
    ChildSpecs = [
                  #{id => ping, start => {ping_pong, start_link, [ping]}},
                  #{id => pong, start => {ping_pong, start_link, [pong]}}
                 ],
    {ok, {SupFlags, ChildSpecs}}.
