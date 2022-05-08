
% B. Given a heterogeneous list composed of numbers and nonempty numerical linear lists, write a
% SWI-Prolog program that builds a list with the minimum values from those sublists for which
% the sum of the
% elements is a prime number. The resulted list will contain elements in reverse order of the
% initial input
% list. For example, for the list [[4, 1, 18], 7, 2, -3, [6, 9, 11, 3], 4, [5, 9, 19]],
% the result will be [3, 1].


% flow: (i, i) (i, o)
sum([], 0).
sum([H|T], S) :-
  sum(T, S1),
  S is S1 + H.

% flow: (i, i) (i, o)
divides_by(N, I) :-
  N mod I =:= 0,
  !.
divides_by(N, I) :-
  N2 is N div 2,
  I =< N2,
  divides_by(N, I + 1).

% flow: (i)
is_prime(2).
is_prime(N) :-
  not(divides_by(N, 2)).

% flow: (i, i) (i, o)
getMin([H], H).
getMin([H|T], R) :-
  getMin(T, R1),
  H > R1,
  !,
  R is R1.
getMin([H|_], R) :-
  R is H.

getMinValues([], []).
getMinValues([H|T], [X|R]) :-
  is_list(H),
  sum(H, S),
  is_prime(S),
  !,
  getMin(H, X),
  getMinValues(T, R).
getMinValues([_|T], R) :-
  getMinValues(T, R).
