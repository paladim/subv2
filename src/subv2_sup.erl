-module(subv2_sup).
-behaviour(supervisor).
-include("include/subv2.hrl").
-export([start_link/0, init/1]).

-define(CHILD(I, Type, Name), {Name, {I, start_link, [Name]}, permanent, 5000, Type, [I]}).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    {ok, { {one_for_one, 5, 10}, 
    	[
    		?CHILD(subv2_map_handler, worker, 'subv2$0250$0250'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0250$0500'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0250$0750'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0250$1000'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0500$0250'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0500$0500'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0500$0750'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0500$1000'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0750$0250'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0750$0500'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0750$0750'),
    		?CHILD(subv2_map_handler, worker, 'subv2$0750$1000'),
    		?CHILD(subv2_map_handler, worker, 'subv2$1000$0250'),
    		?CHILD(subv2_map_handler, worker, 'subv2$1000$0500'),
    		?CHILD(subv2_map_handler, worker, 'subv2$1000$0750'),
    		?CHILD(subv2_map_handler, worker, 'subv2$1000$1000')
    	]
    } }.
