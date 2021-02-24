-module(pancakes).
-export([factory/1, store/2, take/2, start/1]).

factory(PancakeList) ->
    receive
        {From, {store, Pancake}} ->
            From ! {self(), ok},
            factory([Pancake|PancakeList]);
        {From, {take, Pancake}} ->
            case lists:member(Pancake, PancakeList) of
                true ->
                    From ! {self(), {ok, Pancake}},
                    factory(lists:delete(Pancake, PancakeList));
                false ->
                    From ! {self(), not_found},
                    factory(PancakeList)
            end;
        terminate ->
            ok
    end.

store(Pid, Pancake) ->
    Pid ! {self(), {store, Pancake}},
    receive
        {Pid, Msg} -> Msg
    end.

take(Pid, Pancake) ->
    Pid ! {self(), {take, Pancake}},
    receive
        {Pid, Msg} -> Msg
    end.

start(PancakeList) ->
    spawn(?MODULE, factory, [PancakeList]).

