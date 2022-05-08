% C. Write a PROLOG program that generates the list of all combinations of k elements with
% numbers from 1 to N, with the property that difference between two consecutive numbers from
% a combination has an even value. Write the mathematical models and flow models for the
% predicates used. For example, for the N=4, k=2 ⇒ [[1,3],[2,4]] (not necessarily in this order).


% property(l1l2...ln) =   - true, n == 1
%                         - property(l2...ln), abs(l1 - l2) <= 3
%                         - false, otherwise
% flow: (i)
property([_]).
property([H1, H2|T]) :-
  abs(H1 - H2) mod 2 =:= 0,
  property([H2|T]).


genList(N, N, [N]) :- !.
genList(N, A, [A|R]) :-
  A1 is A + 1,
  genList(N, A1, R).

genListForN(N, R) :-
  genList(N, 1, R).

% combinationsRec(l1l2...ln, K) =   - l1, if K == 1 && n >= 1
%                                   - combinationsRec(l2...ln, K), K >= 1
%                                   - l1 U comb(l2...ln, K - 1), K > 1
combinationsRec([E|_], 1, [E]).
combinationsRec([_|T], K, R) :-
  combinationsRec(T, K, R).
combinationsRec([H|T], K, [H|R]) :-
  K > 1,
  K1 is K - 1,
  combinationsRec(T, K1, R).

combinationsWrapper(N, K, R) :-
  genListForN(N, L),
  combinationsRec(L, K, R),
  property(R).
