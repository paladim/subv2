-module(subv2).

-export([start/0, ensure_started/1]).

start() ->
	ensure_started(subv2).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {not_started, Dep}} ->
            case ensure_started(Dep) of
                ok ->
                    ensure_started(App);
                Error ->
                    Error
            end;
        {error, {already_started, App}} ->
            ok;
        {error, {Tag, Msg}} when is_list(Tag), is_list(Msg) ->
            io_lib:format("~s: ~s", [Tag, Msg]);
        {error, {bad_return, {{M, F, Args}, Return}}} ->
            A = string:join([io_lib:format("~p", [A])|| A <- Args], ", "),
            io_lib:format("~s failed to start due to a bad return value from call ~s:~s(~s):~n~p", [App, M, F, A, Return]);
        {error, Reason} ->
            io_lib:format("~p", [Reason])
    end.