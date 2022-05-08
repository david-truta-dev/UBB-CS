
% property(l1l2...ln) =   - true, n == 1
%                         - property(l2...ln), abs(l1 - l2) <= 3
%                         - false, otherwise
% flow: (i)
property([_]).
property([H1, H2|T]) :-
  abs(H1 - H2) =< 3,
  property([H2|T]).

% insertEverywhere(l1l2...ln, e) =  - [e], n == 0
%                                   - e U l1l2...ln, n > 0
%                                   - l1 U insertEverywhere(l2...ln, e)
% flow: (i, i, i) (i, i, o)
insertEverywhere([], E, [E]).
insertEverywhere([H|T], E, [E,H|T]).
insertEverywhere([H|T], E, [H|R]) :-
  insertEverywhere(T, E, R).

% permutari(l1l2...ln) =  - [], n == 0
%                         - l1 U permutari(l2...ln), n > 0
%                         - insertEverywhere(l2...ln, l1)
% flow: (i, i) (i, o)
permutariRec([], []).
permutariRec([H|T], R) :-
  permutariRec(T, R1),
  insertEverywhere(R1, H, R).

% flow: (i, i) (i, o)
permutariWrapper(L, R) :-
  permutariRec(L, R),
  property(R).

% flow: (i, i) (i, o)
permutariMain(L, R) :-
  findall(X, permutariWrapper(L, X), R).
