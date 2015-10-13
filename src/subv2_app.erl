-module(subv2_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_', [

			{"/", cowboy_static, {priv_file, websocket, "index.html"}},
			{"/websocket", subv2_ws_handler, []},
			{"/static/[...]", cowboy_static, {priv_dir, websocket, "static"}}
		]}
		]),
	{ok, _} = cowboy:start_http(http, 100, [{port, 8080}],
		[{env, [{dispatch, Dispatch}]}]),
    subv2_sup:start_link().

stop(_State) ->
    ok.
