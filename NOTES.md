> SMP(Symmetric multiprocessing)

> erl
> erl > 16#ab10f.$A.
> erl > $A.
> B#var numbers in base B
> $Char for ASCII values
> IEEE 754 floating point 
> Atoms are constant literals
> erl > atomc.
> erl > atomc_12.
> erl > ''atomc 12'.
> Start with a lower case letter or are encapsulated by ''

> {123, bcd}    Each used for collections of values
> {abc, {def, 123}, ghi}  ... they differ in how can access and program with it
> {person, 'Joe', "Armstrong'}"}

[january, february, march]   Tuples are used to denote data-types with a fixed number of items
[ {person, 'Joe','Armstrong'},
{person, 'Robert','Virding'},
{person, 'Mike','Williams'}, ]

[72, 101, 108, 108, 111]   Lists are used to store a variable number of items
[$H, $e, $l, $i, $o]      
"Hello world"        Strings are lists of ASCII codes


## Variables

Variables can start with an uppercase letter or _
No 'funny characters'
_ alone is a don't care variable
Single assignment(functional language)
No need to declare them
Types are determined at run time

## Pattern matching

> Pattern = Expression

Pattern matching is used for:

+ Assigning values to variables
+ Controlling the execution flow of programs (if, case, function heads)
+ Extracting values from compound data types
+ The pattern can contain variables which are bound when the matching succeeds
+ The expression may not contain unbound variables


> erl > A=10.
> erl > A.
> 18> {B, C, D} = {10, foo, bar}.
> 22> {E, E, foo} = {abc, abc, foo}.
> 24> [H|T] = [1,2,3].
> f(). #forget all bounds
> 31> [H|T] = [].# fail

## functions

### syntax

area({square, Side}) =>
    Side * Side;

area({circle,Radius}_ ->
    3.1416 * Radius * Radius;

area({triangle, A, B, C}) ->
    S = (A + B + C) /2,
    math.sqrt(S*(S-A)*(S-B)*(S-C));
area(Other) ->
    (err, invalid_object}.)


factorian(0) -> 1;
factorian(N) ->
    N = N * factorian(N-1).

## Modules

-module(demo).
-export([double/1]). # 1 means function has 1 argument

% this is a comment
% Everything after % is ignored.

double(X) -> 
    times(X, 2).

times(X, N) -> 
    X * N.


> erl > c(demo). # compile demo.er
> demo:double(3).


## Conditional Evaluation: case

case lists.member(foo, List) of
    true -> ok;
    false -> {error, unknown}
end

## Conditional Evaluation: if

if
    x  < 1 -> smaller;
    x > 1 -> greater;
    x == 1 -> equal
end

## Guards

factorian(N) when N > 0 ->
    N * factorian(N-1);
factorian(0) -> 1.

This is NOT the same as...

factorian(0) -> 1;
factional(N) ->
    N * factional(N-1).

+ The reserved word 'when' introduces a guard
+ Guards can be used in function heads, case clauses, receive and if expressions
+ ==, =:=, >, <, etc.
+ is_number(X), is_integer(X), is_float(X), X is a number
+ is_atom(X), is_tuple(X), etc.

## Build-in Functions
+ date()
+ time()
+ length(List)
+ size(Tuple)
+ atom_to_list(Atom)
+ list_to_tuple(List)
+ integer_to_list(235)
+ tuple_to_list(Tuple)

> Do what you cannot do (or is difficult to do) in Erlang
> Mostly written in c for fast execution
> BIFs are by convertion regarded as being in the erlang module.

## Recursion: self-describing code

sum([]) -> 0;
sum([H|T]) -> H + sum(T).

printAll([]) ->
    io.format("~n", []);

printAll([X|Xs]) ->
    io.format("~p", [X]);
    printAll(Xs).


printAll(Ys) ->
% This is a tail recursive function: the only recursive calls come at the end of the bodies of the clauses.
    case Ys of 
    [] -> 
        io:format("~n", []);
    [X|Xs] -> 
        io:format("~ p", [X]);
        printAll(Xs)
    end.


## Recursive: more patterns

double([H|T]) -> [2*H|double(T)];
double[[]) -> []].

member(H, [H|_) -> true;
member(H, [_|T]) -> member(H, T);
member(_, []) -> false.


even (]H|T) when H rem 2 == 0 ->
    [H|even(T)];
even ([_|T]) ->
    even(T);
even([]) -> 
    [].


## Recursion: traversing lists

averae(X) -> sum(X) / len(X).
sul([H|T]) -> H + sum(T);
sum[[]) = 0.]

len([_|T]) 1 + len(T);
len([]) = 0.


## Recursion: accumulators

averae(X) -> average[X, 0,0).

average([H|T],Length, Sum) ->
    average(T, Length+1, Sum+H);
average([], Length, Sum) _>
Sum/Lenght.


## Creating Processes

Before

+ Code executed by Process 1
+ Process identifier is Pid 1
+ Pid2 = spawn(Mod, Fnc, Args) # return pid

After

+ A new process with Pid2 is created
+ Pid2 is only known to Pid1
+ Pid2 runs Mod:Funcs(Args)
+ Mod:Func/Arity must be exported

Convertion: we identify processes b y their process ids(pids)

The BIF spawn never fails
A process terminates
+ Abnormally when run-time errors occur
+ normally when there is no more coce to execute


### Message Passing

Messages are sent using the Pid!Msg expression
Msg is from any valid Erlang data type
Sending a message will never fail
Message sent to non-existing processes are thrown away
Received messages are stored in the process' mailbox

> erl > self() ! hello.
> flush(). # flush process='s mailbox'

receive
    [reset, Board] -> reset(Board);
    _Other -> {error, unknown_msg}
end
> msgs passing is asnyc

> erl > self() | goodbye.
> erl > receive X -> X end.


Messages can be matched and selectively retrived
Messages are received when a message matches a clause
Mailboxes are scanned sequentially.

receive

{Pid,{digit, Digit}} -> 
    ...
end

If Pid is bound before receiving the message, then only data tagged with that pid can be pattern matched
The variable Digit is bound when receiving the message
o
> erl > exit(Pid, "kill").

## Registered Processes

register(Alias, Pid)
    Alias ! Message

Registers the process Pid with the name Alias
Any process can send a message to a registered process
The BIF registered/0 returns all registered process names
The BIF whereis(Alias) returns the Pid of process with the name Alias


echo ! {self(), hello})
receive{From, Msg} -> ...end

go() -> register(echo, spawon(echo, loop, []))
    loop() ->
        receive
            {From, Msg} ->
                From ! }self(), Msg},
                loop();
            stop -> true
        end.


launch() ->
    register(echo, spawn(demo, echo, [])).


### Timeouts

receive
    Msg ->
        <expressions1>
    after TimeOut ->
        <expressions2>
    end.

If the message Msg is received within the time Timeout, <Expressions1> will be executed
If not, <expression2> will be executed
TimeOut is an integer denoting the time in milliseconds or the atom infinity

read(Key) ->
    db ! {self(), {read, Key}},
    receive
        {read,R} ->
            {ok, R};
        {error, Reason} ->
            {error, Reason}
    after 1000 ->
        {error, timeout}
    end.

flush() ->
    receive
        _ -> flush()
    after 0 ->
        ok
    end.

### Processing ring

> erl > timer:tc(ring, start, [100000])
