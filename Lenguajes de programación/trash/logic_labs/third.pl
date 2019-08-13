% Prolog Lab 3
% By Victor Hugo Torres Rivera 

% //////////////////////////Quick Sort////////////////////////////////

% Order puts the elements biggetr than compare on the Right list
% and the smoler on the left one.
order([], _, [], []).

order([H|T], Compare, [H|Left], Right):-
  H < Compare,
  order(T, Compare, Left, Right).

order([H|T], Compare, Left, [H|Right]):-
  order(T, Compare, Left, Right).

% Quick sort make a recursive call with each of the list result of
% the order function.
quick_sort([], []).

quick_sort([OH|OT], Sorted):-
  order(OT, OH, Right, Left),
  quick_sort(Right, SortedRight),
  quick_sort(Left, SortedLeft),
  append(SortedRight, [OH], FirstHalf),
  append(FirstHalf, SortedLeft, Sorted).


% ///////////////Limited Depth First Search Algorithm/////////////////
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
% Path does a limited depth search/
% Examples:
% ?- path(catina, 4, Y).
% Y = [catina, messana, rhegium, capua, roma] .
% ?- path(catina, 7, Y).
% Y = [catina, messana, rhegium, capua, roma, genua, placentia, ariminum]

path(Origin, Limit, Path):-
  route(Origin, Limit, [Origin], Path).

route(_, 0, Route, Route).

route(Origin, Limit, Route, Path):-
  road(Origin, Stop),
  not(is_in(Stop, Route)),
  addend(Stop, Route, Helper),
  Count is Limit-1,
  route(Stop, Count, Helper, Path).



% //////////////////////////Extra Tools//////////////////////////////
% Append one list M next to list N.
append([], List, List).
append([NH|NT], M, [NH|NewList]):-
  append(NT, M, NewList).

% Proofs that an element is in a list.
is_in(N, [N|_]):- !.
is_in(N, [_|T]):-
  is_in(N, T).

% Append an element to the end of the list.
addend(X, [], [X]).
addend(X, [H|T], [H|NewList]):-
  addend(X, T, NewList).
