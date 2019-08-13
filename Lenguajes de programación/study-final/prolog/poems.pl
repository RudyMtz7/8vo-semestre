feelings(beautiful,happy).
feelings(ugly,sad).
word(is, noun).

resultH('HappyPoem').
resultS('SadPoem').
resultN('NeutralPoem').

is_empty(List):- not(member(_,List)).

checkPoem(L,R):-
	check(L,R,0,0).

check(L,Result,Happy,Sad):-
	is_empty(L),
	Happy > Sad,
	resultH(Result).

check(L,Result,Happy,Sad):-
	is_empty(L),
	Happy < Sad,
	resultS(Result).

check(L,Result,Happy,Sad):-
	is_empty(L),
	Happy = Sad,
	resultN(Result).

check([H|T],Result,Happy,Sad):-
	feelings(H,happy),
	HappyNew is Happy + 1,
	check(T,Result,HappyNew,Sad).

check([H|T],Result,Happy,Sad):-
	feelings(H,sad),
	SadNew is Sad + 1,
	check(T,Result,Happy,SadNew).

check([H|T],Result,Happy,Sad):-
	word(H,noun),
	check(T,Result,Happy,Sad).
