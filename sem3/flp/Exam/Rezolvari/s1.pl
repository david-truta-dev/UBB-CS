
% -------- A -----------------------

%f([],-1).
%f([H|T],S):-f(T,S1), additional_predicate(S1,S,H).

%additional_predicate(S1,S,H):-S1<0, S is S1-H, !.
%additional_predicate(S1,S,_):-S is S1.

% -------- C -----------------------

property([_]).
property([H1,H2|T]):-
    abs(H1-H2) >= 3,
    property([H2|T]).

insertEverywhere([], E, [E]).
insertEverywhere([H], E, [E|H]).
insertEverywhere([H|T], E, [H|R]):-
    insertEverywhere(T,E,R).

%-----S2A-------------------


%f2(0, -1):-!.
%f2(I,Y):-J is I-1, f2(J,V), additional_predicate(I,J,V,Y).

%additional_predicate(_,J,V,Y):- V > 0, !, K is J, Y is K+V.
%additional_predicate(I,_,V,Y):- Y is V+I.

% ---------Razvi -------------

f(50, 1):-!.
f(I,Y):-J is I+1, f(J,S),S<1,!,K is I-2, Y is K.
f(I,Y):-J is I+1, f(J,Y).

add_pred(J,S,Y):- S<1,!,K is I-2, Y is K.
add_pred(J,S,Y):- S is Y.


