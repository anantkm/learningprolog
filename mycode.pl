%Assignment 1 - Prolog Programming
%Name: Anant K. Mahale. 
%zID: 5277610

% Q1. Write a predicate sumsq_even(Numbers, Sum) that sums the squares of only the even numbers in a list of integers. 

%(Base Case) Return 0(Zero)when tail has no elements. 
sumsq_even([],0).

%if the current head is even then calculate Sqaure and Sum
sumsq_even([Head|Tail], Sum) :-
	0 is Head mod 2,
	sumsq_even(Tail, CurrentSum ),
	Sum is Head * Head + CurrentSum.	

%else it is Odd, skip it. 
sumsq_even([Head|Tail], Sum) :-
	1 is Head mod 2,
	sumsq_even(Tail, Sum).

%-----------------------------------------------------------------------------------------------
% Q2. Write a predicate same_name(Person1,Person2) that succeeds if it can be deduced from the facts in the database 
%that Person1 and Person2 will have the same family name. 

%2 people can have same family name if :

% 1. Male(Person-1) is Person2's Father.
same_name(P1, P2) :-
    parent(P1, P2),
    male(P1),
    P1 \= P2.

% 2. Male(Person-2) is  Person1's Father.
same_name(P1, P2) :-
    parent(P2, P1),
    male(P2),
    P1 \= P2.

% 3. Male(Person-1) is the father of Male(X), inturn father of Person2 
same_name(P1, P2) :-
    parent(P1, X),
    parent(X, P2),
    male(P1),
    male(X),
    P1 \= P2.

% 4. Male(Person-20 is the father of Male(X), inturn father of Person1
same_name(P1, P2) :-
    parent(P2, X),
    parent(X, P1),
    male(P2),
    male(X),
    P1 \= P2.

% 5. Last case. Person1 and Person2 have the same father
same_name(P1, P2) :-
    parent(Pr, P1),
    parent(Pr, P2),
    male(Pr),
    P1 \= P2.

%-----------------------------------------------------------------------------------------------
% Q3 Write a predicate log_table(NumberList, ResultList) that binds ResultList to the list of pairs consisting of a number and its log, for each number in NumberList.

%This is a Append function to append the Number and it's log value to the list. 
log_calc(Num, ResultList) :-
	Result is log(Num),
	ResultList = [Num, Result].

% when the list is empty. 		
log_table([], []).

%Recursive case :
log_table([Head|Tail], [List|ResultList]) :-
	log_calc(Head, List), %Pass the Head of Original Value and Head of resultList to the get the Log Value. 
	log_table(Tail, ResultList).
		
%-----------------------------------------------------------------------------------------------
%Q4. Any list of integers can (uniquely) be broken into "parity runs" where each run is a (maximal) sequence of consecutive even or odd numbers within the original list. For example, the list

%Function that checks if the given value is Even Integer.  
is_even(Num) :-
    integer(Num),
    0 is Num mod 2.

%Function that checks if the given value is Odd Integer.  
is_odd(Num) :-
    integer(Num),
    1 is Num mod 2.

% List with no Element returned as Empty List within List.
paruns([], [[]]).

% List with only one Element.
paruns([X], [[X]]).

% This is similar to lab exercise. 
%Here have taken 4 cases [Odd,Odd], [Even,Even], [Even,Odd], [Odd,Even].

%Case1. When there is 2 consecutive odd number 
paruns([Head|Tail], [NewHead2|NewList]) :-
    Tail = [TailHead|_],
    (is_odd(Head),is_odd(TailHead)),
    NewHead2 = [Head|NewHead1],
    paruns(Tail, [NewHead1|NewList]).

%Case2. When there is 2 consecutive even number 
paruns([Head|Tail], [NewHead2|NewList]) :-
    Tail = [TailHead|_],
    (is_even(Head),is_even(TailHead)),
    NewHead2 = [Head|NewHead1],
    paruns(Tail, [NewHead1|NewList]).

%Case 3. When first number is Even and Second is Odd. [Even,odd]
paruns([Head|Tail], [NewHead|NewList]) :-
    Tail = [TailHead|_],
    (is_even(Head),is_odd(TailHead)),
    NewHead = [Head],
    paruns(Tail, NewList).

%Case 4. When first number is Odd and Second is Even. [odd,Even]
paruns([Head|Tail], [NewHead|NewList]) :-
    Tail = [TailHead|_],
    (is_odd(Head),is_even(TailHead)),
    NewHead = [Head],
    paruns(Tail, NewList).


%-----------------------------------------------------------------------------------------------
% QUESTION 5:
% tree_eval(Value, Tree, Eval) :- Write a predicate tree_eval(Value, Tree, Eval)% that binds Eval to the result of evaluating the expression-tree Tree, with the% variable z set equal to the specified Value.

%"tree_eval(Value, Tree, Eval)"" Evaluates the expression-tree Tree, by setting z to the specified value. 

% 1. Base Case. Since the tree is Empty, the value is set to 0. 
tree_eval(_, empty, 0).

tree_eval(_, tree(empty), 0).

% 2. Solving z.
tree_eval(Value, tree(empty, Num, empty), Eval) :-
  Num = z,
  Eval is Value.

% 3. Solving the number (non z) 
tree_eval(_, tree(empty, Num, empty), Eval) :-
  Num \= z,
  Eval is Num.

%below operations can be done using one line.
%Expr =.. [Op,LEval,REval] but I have written seperate cases. 

% 4. Evaluation of + operator
tree_eval(Value, tree(L, +, R), Eval) :-
  tree_eval(Value, L, LEval),
  tree_eval(Value, R, REval),
  Eval is LEval + REval.
  
% 5. Evaluation of  - operator
tree_eval(Value, tree(L, -, R), Eval) :-
  tree_eval(Value, L, LEval),
  tree_eval(Value, R, REval),
  Eval is LEval - REval.
  
% 6. Evaluation of  * operator
tree_eval(Value, tree(L, *, R), Eval) :-
  tree_eval(Value, L, LEval),
  tree_eval(Value, R, REval),
  Eval is LEval * REval.
  
% 7. Evaluation of  / operator
tree_eval(Value, tree(L, /, R), Eval) :-
  tree_eval(Value, L, LEval),
  tree_eval(Value, R, REval),
  Eval is LEval / REval.
