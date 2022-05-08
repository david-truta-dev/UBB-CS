# Assignment 12
## Requirements
Select a problem from the list below and solve it using the BACKTRACKING programming method, using both an **iterative** and a **recursive** implementation for the `backtracking` procedure.

## Problem Statements
1. A number of `n` coins are given, with values of a<sub>1</sub>, ..., a<sub>n</sub>  and a value `s`. Display all payment modalities for the sum `s`. If no payment modality exists print a message.
2. Consider a positive number `n`. Determine all its decompositions as sums of prime numbers.
3. The sequence a = a<sub>1</sub>, ..., a<sub>n</sub> with integer elements is given. Determine all strictly increasing subsequences of sequence `a` (conserve the order of elements in the original sequence).
4. A player at `PRONOSPORT` wants to choose score options for four games. The options may be `1`, `X`, `2`. Generate all possible alternatives, knowing that:
- The last score option may not be `X`
- There should be no more than two score options of `1`
5. The sequence a = a<sub>1</sub>, ..., a<sub>n</sub> with distinct integer numbers is given. Determine all subsets of elements having the sum divisible by a given `n`.
6. Generate all sequences of `n` parentheses that close correctly. Example: for `n=4` there are two solutions: `(())` and `()()`
7. Generate all subsequences of length `2n+1`, formed only by `0`, `-1` or `1`, such that a<sub>1</sub> = 0, ..., a<sub>2n+1</sub>= 0 and |a<sub>i+1</sub> - a<sub>i</sub>| = 1 or 2, for any 1 ≤ i ≤ 2n.
8. Consider `n` points in a plane, given by their coordinates. Determine all subsets with at least three elements formed by collinear points. If the problem has no solution, give a message.
9. The sequence a = a<sub>1</sub>, ..., a<sub>n</sub> with distinct integer elements is given. Determine all subsets of at least two elements with the property:
- The elements in the subset are in increasing order
- Any two consecutive elements in the subsequence have at least one common digit
10. A group of `n` (n<=10) persons, numbered from `1` to `n` are placed on a row of chairs, but between every two neighbor persons (e.g. persons 3 and 4, or persons 7 and 8) some conflicts appeared. Display all the possible modalities to replace the persons, such that between any two persons in conflict stay one or at most two other persons.
11. Two natural numbers `m` and `n` are given. Display in all possible modalities the numbers from `1` to `n`, such that between any two numbers on consecutive positions, the difference in absolute value is at least `m`. If there is no solution, display a message.
12. Consider the natural number `n` (n<=10) and the natural numbers a<sub>1</sub>, ..., a<sub>n</sub>. Determine all the possibilities to insert between all numbers a<sub>1</sub>, ..., a<sub>n</sub> the operators `+` and `–` such that by evaluating the expression the result is positive.
13. The sequence a<sub>1</sub>, ..., a<sub>n</sub> of distinct integer numbers is given. Display all subsets with a mountain aspect. A set has a mountain aspect if the elements increase up to a point and then they decrease. E.g. `10, 16, 27, 18, 14, 7`.
14. Generate all numbers of `n` digits with the property that no number has two identical neighboring subsequences. For example, for `n=6`, `121312` is correct, and `121313` and `132132` are not correct.
