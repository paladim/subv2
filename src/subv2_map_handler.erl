-module(subv2_map_handler).
-behaviour(gen_server).
-include("include/subv2.hrl").
-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link(Props) -> 
	Name = Props,
	gen_server:start_link({local, Name}, ?MODULE, Props, []).

init(Props) -> 
	{ok, State = Props}.

handle_call(Req, _From, State) -> 
	{reply, Req, State}.

handle_cast(Req, State) -> 
	{noreply, State}.

handle_info(Info, State) ->
	{noreply, State}.

terminate(_Reason, State) -> 
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.