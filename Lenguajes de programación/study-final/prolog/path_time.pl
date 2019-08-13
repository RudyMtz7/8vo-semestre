% Exercise 1

/* Define a predicate “compatible(X,Y)”. We say that X and Y are compatible if
% they share at least 1 hobby. */

hobby(juan,kaggle).
hobby(luis,hack).
hobby(elena,tennis).
hobby(midori,videogame).
hobby(simon,sail).
hobby(simon,kaggle).
hobby(laura,hack).
hobby(hans,videogame).

compatible(X,Y):-
	hobby(X,Z),
	hobby(Y,Z),
	dif(X,Y).

% compatible(juan,Y).
% Y = simon.

% ---------------------------------------------------------------------------- %

% Exercise 2

/* Generate a KB of the paths that lead to Rome.
Every road is a one way road and the all lead to the capital, because
“all roads lead to Rome”. The directions in your predicates should be from
left (start) to right (end).

Define the rule can_get_to(Origin, Destination) which is true if there is a
path that starts in Origin and following the directionality of the roads can
get to Destination. */

road(placentia,ariminum, 3).
% road(placentia,genua).
% road(ariminum,ancona).
road(ariminum,roma, 4).
% road(ancona,castrum-truentinum).
% road(ancona,roma).
% road(castrum-truentinum,roma).
% road(brundisium,capua).
% road(rhegium,capua).
% road(catina,rhegium).
% road(syracusae,catina).
% road(lilibeum,messana).
% road(messana,capua).
% road(capua,roma).
% road(pisae,roma).
% road(genua,pisae).
% road(genua,placentia).
% road(genua,roma).

path_to(Origin, Destination, X):-
  road(Origin, Destination, X).

path_to(Origin, Destination, Acum):-
  road(Origin, Next, X),
  path_to(Next, Destination, Nacum),
  Acum is X + Nacum.
