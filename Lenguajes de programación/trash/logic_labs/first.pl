% Lab 1 Prolog
% By Victor Hugo Torres Rivera
% A01701017
% Hobby base knowledge.
hobby(juan,kaggle).
hobby(luis,hack).
hobby(elena,tennis).
hobby(midori,videogame).
hobby(simon,sail).
hobby(simon,kaggle).
hobby(laura,hack).
hobby(hans,videogame).

% Funcrtion that returns true if X and Y share a hobby.
compatible(X, Y):-
  hobby(X, Z),
  hobby(Y, Z).

% Roads between cities.
road(genua, placentia).
road(genua, pisae).
road(genua, roma).
road(placentia, ariminum).
road(pisae, roma).
road(ariminum, roma).
road(ariminum, ancona).
road(ancona, roma).
road(ancona, castrum_truentinum).
road(castrum_truentinum, roma).
road(capua, roma).
road(brundisium, capua).
road(rhegium ,capua).
road(messana, rhegium).
road(lilibeum, messana).
road(catina, messana).
road(syracusae, catina).

% Recursive function to prove that it is posible to get to
% a city Y from X.
can_get_to(X, Y):-
  road(X, Y);
  road(X, Z),
  can_get_to(Z,Y).

% Recursuve funtion to count how many roads are bewteen two cities.
size(X, Y, Z):-
  road(X, Y),
  Z is 1;
  road(X, N),
  size(N, Y, S),
  Z is 1 + S.

% Returns Z as te min between A, B and C.
min(A, B, C, Z):-
  A < B, A < C,
  Z is A;
  B < A, B < C,
  Z is B;
  C < A, C < B,
  Z is C;
  A = B, A = C,
  Z is A;
  A = B, A < C,
  Z is A;
  A = C, A < B,
  Z is A;
  C = B, C < A,
  Z is C.

% Base Cases Of calculating GDC.
gdc(A, B, Z):-
  B = 0, A = 0,
  Z is 0;
  A = 0,
  B > 0,
  Z is B.

% Recursive call to calculate GDC in case A is bigger or equal to B.
gdc(A, B, Z):-
  A >= B,
  N is A - B,
  gdc(N, B, Z).

% Recursive call to calculate GDC in case B is bigger than B.
gdc(A, B, Z):-
  A < B,
  N is B - A,
  gdc(N, A, Z).
