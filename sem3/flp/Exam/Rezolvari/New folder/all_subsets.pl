% C. Write a PROLOG program that generates the list of all subsets with value of sum for each
% subset odd number and also odd numbers of odd values from each subset. Write the
% mathematical models and flow models for the predicates used. For example, for [2,3,4] ⇒
% [[2,3],[3,4],[2,3,4]] not necessarily in this order).


% flow: (i, i) (i, o)
sum([], 0).
sum([H|T], S) :-
  H mod 2 =:= 1,
  !,
  sum(T, S1),
  S is S1 + H.
sum([_|T], S) :-
  sum(T, S).

% flow: (i)
sumProperty(L) :-
  sum(L, S),
  S mod 2 =:= 1.

% flow: (i, i) (i, o)
noOfValues([], 0).
noOfValues([H|T], N + 1) :-
  H mod 2 =:= 1,
  !,
  noOfValues(T, N).
noOfValues([_|T], N) :-
  noOfValues(T, N).

% flow: (i)
noOfValuesProperty(L) :-
  noOfValues(L, N),
  N mod 2 =:= 1.

% property(L) =   - sumProperty(L) AND noOfValuesProperty(L)
property(L) :-
  sumProperty(L),
  noOfValuesProperty(L).


% subsetsRec(l1l2...ln) = - [], n == 0
%                         - l1 U subsetsRec(l2...ln)
%                         - subsetsRec(l2...ln)
% flow: (i, i) (i, o)
subsetsRec([], []).
subsetsRec([H|T], [H|R]) :-
  subsetsRec(T, R).
subsetsRec([_|T], R) :-
  subsetsRec(T, R).

% flow: (i, i) (i, o)
subsetsWrapper(L, R) :-
  subsetsRec(L, R),
  property(R).
