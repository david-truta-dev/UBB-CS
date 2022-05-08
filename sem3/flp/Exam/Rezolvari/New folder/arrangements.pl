% C. Write a PROLOG program that generates the list of all arrangements of k elements with the
% value of sum of all elements from each arrangement equal with a given S, from a list of integers.
% Write the mathematical models and flow models for the predicates used. For example, for the list
% [6, 5, 3, 4], k=2 and S=9⇒ [[6,3], [3,6], [5,4], [4,5]] (not necessarily in this order).



% flow: (i, i) (i, o)
sum([], 0).
sum([H|T], S) :-
  sum(T, S1),
  S is S1 + H.


% insertEverywhere(l1l2...ln, e) =  - [e], n == 0
%                                   - e U l1l2...ln, n > 0
%                                   - l1 U insertEverywhere(l2...ln, e)
% flow: (i, i, i) (i, i, o)
insertEverywhere([], E, [E]).
insertEverywhere([H|T], E, [E,H|T]).
insertEverywhere([H|T], E, [H|R]) :-
  insertEverywhere(T, E, R).

% arrangementsRec(l1l2...ln, K) = - l1, k == 1
%                                 - arrangementsRec(l2...ln, K), K >= 1
%                                 - insertEverywhere(arrangementsRec(l2...ln, K - 1), l1), K > 1
% flow: (i, i, i) (i, i, o)
arrangementsRec([E|_], 1, [E]).
arrangementsRec([_|T], K, R) :-
  arrangementsRec(T, K, R).
arrangementsRec([H|T], K, R1) :-
  K > 1,
  K1 is K - 1,
  arrangementsRec(T, K1, R),
  insertEverywhere(R, H, R1).

% flow: (i, i, i, i) (i, i, i, o)
arrangementsWrapper(L, K, S, R) :-
  arrangementsRec(L, K, R),
  sum(R, S).
