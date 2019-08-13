%Rodolfo Martínez Guevara
%Exercise 1
any_positive([H|T]):-
  H > 0, !; %Checks if number is positve, returns true
  any_positive(T). %Moves to next number if it is not.
%Test: any_positive ([-1,-2,3,-4]). -> true
%Test: any_positive([0,0,0,0]). -> false

%Exercise 2
% Base case. First list is empty.
substitute(_, _, [], []).

% Substitute if M and the head are the same.
substitute(M, N, [M|T], [N|NT]):- !,
  substitute(M, N, T, NT).

% Continue if M and the head are different.
substitute(M, N, [H|T], [H|NT]):-
  substitute(M, N, T, NT).

%Exercise 3
eliminate_duplicates([],[]).

eliminate_duplicates([H | T],List):-
     member(H, T),
     eliminate_duplicates(T, List).

eliminate_duplicates([H | T], [H|T1]):-
      \+member(H, T),
      eliminate_duplicates(T, T1).

%Exercise 4

intersect([], _, []).

% Prevents that the new list gets equal elements by ignoring any
% value in the first list that is repeated.
intersect([H_One|T_One], ListTwo, NewList):-
  is_in(H_One, T_One), !,
  intersect(T_One, ListTwo, NewList).

% If the head of the first list is equal to any value of the second
% list, it gets appended to the new list.
intersect([H_One|T_One], ListTwo, [H_One|NewList]):-
  is_in(H_One, ListTwo), !,
  intersect(T_One, ListTwo, NewList).

% If the head of the first one isn't on the second one it gets
% ignored.
intersect([_|T_One], ListTwo, NewList):-
  intersect(T_One, ListTwo, NewList).


%Exercise 5
% Base case for the moment the original list is empty
invert([], []).

% First call the recursive fuction until it reaches the end of the
% list and then it appends the head to the new list
invert([H|T], ReversedList):-
  invert(T,NewList),
  addend(H, NewList, ReversedList).

%Exercise 6
% Base case
less_than(_,[],[]).

% If the head of the list is smaller than N it gets appended to the new
% list.
less_than(N, [H|T], [H|NewList]):-
  H < N,
  less_than(N, T, NewList).

% Else it will be ignored.
less_than(N, [_|T], NewList):-
  less_than(N, T, NewList).

%Exercise 7
% Base case. Fist list is empty.
more_than(_, [], []).

% Append to new list if the Head is bigger or equal than N.
more_than(N, [H|T], [H|NL]):-
  H >= N, !,
  more_than(N, T, NL).

% Ignore the element if the head of the first list is greater than N.
more_than(N, [_|T], NL):-
  more_than(N, T, NL).

%Exercise 8
rotate(List, 0,List).

rotate([OH|OT], N, Rotated):-
  N > 0,
  B is N-1,
  append(OT, [OH], NewList),
  rotate(NewList, B, Rotated).

rotate(Original, N, Rotated):-
    N < 0,
    B is -N,
    rotate(Rotated, B, Original).

%ROMA
% Base Knowledge
road(genua, placentia).
road(placentia, genua).
road(genua, pisae).
road(pisae, genua).
road(genua, roma).
road(roma, genua).
road(placentia, ariminum).
road(ariminum, placentia).
road(pisae, roma).
road(roma, pisae).
road(ariminum, roma).
road(roma, ariminum).
road(ariminum, ancona).
road(ancona, ariminum).
road(ancona, roma).
road(roma, ancona).
road(ancona, castrum_truentinum).
road(castrum_truentinum, ancona).
road(castrum_truentinum, roma).
road(roma, castrum_truentinum).
road(capua, roma).
road(roma, capua).
road(brundisium, capua).
road(capua, brundisium).
road(rhegium ,capua).
road(capua, rhegium).
road(messana, rhegium).
road(rhegium, messana).
road(lilibeum, messana).
road(messana, lilibeum).
road(catina, messana).
road(messana, catina).
road(syracusae, catina).
road(catina, syracusae).

% Returns Path as the list of cities that you have to pass before
% the destiny.
path(Origin, Destiny, Path):-
  route(Origin, Destiny, [Origin], Path).

% Base case for the routes to take to get to a destiny
route(Origin, Destiny, Route, Route):-
  road(Origin, Destiny).

% Recursive function to follow a route until getting the destiny.
route(Origin, Destiny, Route, Path):-
  road(Origin, Stop),
  not(is_in(Stop, Route)),
  addend(Stop, Route, Helper),
  route(Stop, Destiny, Helper, Path).

%Aux functions
% Returns true if element is in a list
is_in(N, [N|_]):- !.
is_in(N, [_|T]):-
  is_in(N, T).

% Append an element
addend(X, [], [X]).
addend(X, [H|T], [H|NewList]):-
  addend(X, T, NewList).

% Append list M to list N.
append([], List, List).
append([NH|NT], M, [NH|NewList]):-
  append(NT, M, NewList).
