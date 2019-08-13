/*

Señor Dr. Profesor Rodolfo Martínez Guevara
A01700309

*/

/*Exercise 1*/

hobby(juan,kaggle).
hobby(luis,hack).
hobby(elena,tennis).
hobby(midori,videogame).
hobby(simon,sail).
hobby(simon,kaggle).
hobby(laura,hack).
hobby(hans,videogame).

/*Function to verify if two people are compatible if they share at
least one hobby*/
compatible(X,Y):-
  hobby(X,Z), /*Person 1/ Hobby*/
  hobby(Y,Z), /*Person 2/ Hobby*/
  diff(X,Y). /*Checks that x and y are different values */

/*Exercise 2*/
road(placentia,ariminum).
road(genua,pisae).
road(genua,roma).
road(genua,placentia).
road(pisae,roma).
road(ariminum,ancona).
road(ariminum,roma).
road(ancona,roma).
road(ancona,roma).
road(ancona,castrum_truentinum).
road(castrum_truentinum,roma).
road(roma,bruendisium).
road(messana,capua).
road(rhegium,messana).
road(catina,rhegium).
road(lilibeum,messana).
road(syracusae,catina).


can_get_to(Orgin,Destination):-
  road(Orgin,Destination).

can_get_to(Orgin,Destination):-
  road(Orgin,NewPlace),
	can_get_to(NewPlace,Destination).

size(X,Y,Z):-
  road(X,Y),
  Z is 1; /*Step is 1, returns 1*/
  road(X,N),
  size(N,Y,S), /*Recursively calls function until it matches the Destination*/
  Z is S+1. /*Counter*/

/*Exercise 3*/
min(A,B,C):-
	A<B, /*Compares values and returns match*/
	A<C,
	write(A).
min(A,B,C):-
	A<B,
	write(C).
min(_,B,C):-
	B<C,
	write(B).
min(_,_,C):-
	write(C).

/*Exercise 4*/
/*Implements algorithm to find gcd*/
gcd(0, X, X):-
  X > 0, !.

gcd(X, Y, Z):-
  X >= Y,
  X1 is X-Y, /*Substracts value until finding gcd*/
  gcd(X1,Y,Z).

gcd(X, Y, Z):-
  X < Y,
  X1 is Y-X,
  gcd(X1,X,Z).
