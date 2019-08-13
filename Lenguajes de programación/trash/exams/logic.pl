% Logic Exam
% By Victor Hugo Torres Rivera
%                   A01701017

% ///////////////////////////Base Knowledge////////////////////////////////
% honorific refers to the correct honorific that should be used according
% to the relation between two individuals.

honorific(older_brother, child, chan).
honorific(child, older_brother, oniisan).
honorific(underclassman, upperclassman, senpai).
honorific(upperclassman, underclassman, kohai).
honorific(_, royalty, sama).
honorific(child, uncle, ojisan).
honorific(uncle, child, chan).
honorific(child, father, otosan).
honorific(father, child, chan).
honorific(X, X, san).


% /////////////////////////Correct honorific///////////////////////////////
% It returns in ReferSentece the correct way the person1, should address
% person2
% correct_honorific(List1, List2, List3)
% List1 -> [Person 1 Social Status| Person 1 Name]
% List2 -> [Person 2 Social Status| Person 2 Name]
% List3 -> [Person 2 Name | Correcr Honorific]
% Examples of use:
% ?- correct_honorific([father, sung], [royalty, queen], X).
% X = [queen, sama]
% ?- correct_honorific([father, yung], [child, gong], X).
% X = [gong, chan] 


% Base case for the moment the honorific is chosen.
correct_honorific([], [P2N|_], [P2N|_]).

% Initial case that gets the parameters to conclude which honorific should
% be used.
correct_honorific([P1H|_], [P2H|[P2N|_]], [P2N|ReferSentece]):-
  get_honorific(P1H, P2H, P2N, ReferSentece).

% Rule that helps correct honorific to determine which honorific must be
% used and calls the base case.
get_honorific(P1H, P2H, P2N, ReferSentece):-
  % As soon as it finds the correct honorific it stops looking for more.
  honorific(P1H, P2H, Honorific), !,
  addend(Honorific, ReferSentece, NewList),
  correct_honorific([], [P2N],   NewList).


% Tool to help adding an element to the end of a list.
addend(X, [], [X]).
addend(X, [X|T], [_|NewList]):-
  addend(X, T, NewList).
