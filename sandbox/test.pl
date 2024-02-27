% Define the friendship relation
friend(A, B) :- knows(A, B).
friend(A, B) :- knows(B, A). % Symmetric relation
friend(A, B) :- knows(A, C), friend(C, B). % Transitive relation
friend(A, B) :- knows(C, A), friend(C, B). % Transitive relation
friend(A, B) :- knows(A, C), friend(B, C). % Transitive relation
friend(A, B) :- knows(C, A), friend(B, C). % Transitive relation


% Some example knowledge base
knows(krzysztof, mikolaj).
knows(krzysztof, kuba).

% Query examples
% Is john a friend of mary?
% Query: ?- friend(john, mary).
% Output: true
%
% Is alice a friend of mary?
% Query: ?- friend(alice, mary).
% Output: false

% factorial of a number
factorial(0, 1).
factorial(N, F) :- N > 0, N1 is N - 1, factorial(N1, F1), F is N * F1.

% Query examples
% What is the factorial of 5?
% Query: ?- factorial(5, F).

fact(0, 1).
fact(N, R) :- N > 0, N1 is N - 1, fact(N1, R1), R is N * R1.

% show me how this will be executed for fact(5, R)
% Query: ?- fact(5, R). 
% 5 > 0, 5-1 = 4, fact(4, R1), R is 5 * R1
% 4 > 0, 4-1 = 3, fact(3, R1), R is 4 * R1
% 3 > 0, 3-1 = 2, fact(2, R1), R is 3 * R1
% 2 > 0, 2-1 = 1, fact(1, R1), R is 2 * R1
% 1 > 0, 1-1 = 0, fact(0, R1), R is 1 * R1
% 0 = 0, R is 1 * 1
% R = 120

% why cant i do fact(N - 1, R1) instead of N1 is N - 1, fact(N1, R1) ? A: because N - 1 is not a number, it is an expression