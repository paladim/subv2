-module(subv2_sup).
-behaviour(supervisor).
-include("include/subv2.hrl").
-export([start_link/0, init/1]).

-define(CHILD(I, Type, Name), {Name, {I, start_link, [Name]}, permanent, 5000, Type, [I]}).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    List = generate([], 0),
    {ok, 
        { 
            {one_for_one, 5, 10}, 
            [?CHILD(subv2_map_handler, worker, list_to_atom("subv2$" ++ integer_to_list(A) ++ "$" ++ integer_to_list(B))) || B <- List, A <- List] 
        } 
    }.

generate(List, X) -> 
    io:format("~p~n", [List]),
    case X > ?MAP_PIX of
        true -> List;
        false -> generate([X | List], X + ?BM_PIX)
     end.