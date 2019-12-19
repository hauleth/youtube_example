%%%-------------------------------------------------------------------
%% @doc youtube_example public API
%% @end
%%%-------------------------------------------------------------------

-module(youtube_example_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    youtube_example_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
