% Basic song info
% Year First Released, Title, Year Recorded, Album
song_info(1982, action_this_day, 1981-82,hot_space).
song_info(1977, all_dead_all_dead,1977,news_of_the_world).
song_info(1991, all_gods_people,1989-90,innuendo).
song_info(1980, another_one_bites_the_dust,1980,the_game).
song_info(1980, arboria,1980,flash_gordon).
song_info(1982, back_chat,1981-82,hot_space).
song_info(1980, battle_theme,1980,flash_gordon).
song_info(1978, bicycle_race,1978,jazz).
song_info(1991, bijou,1989-90,innuendo).
song_info(1985, one_vision,1985,one_vision).
song_info(1982, body_language,1981-82,hot_space).
song_info(1975, bohemian_rhapsody,1975, a_night_at_the_opera).
song_info(1989, breakthru,1988-89,the_miracle).
song_info(1974, brighton_rock,1974,sheer_heart_attack).

% Author of the song
% Title, Author
author(action_this_day, [taylor]).
author(all_dead_all_dead, [may]).
author(all_gods_people, [mike_moran, queen, mercury]).
author(another_one_bites_the_dust, [deacon]).
author(back_chat, [deacon]).
author(arboria, [deacon]).
author(battle_theme, [may]).
author(bicycle_race, [mercury]).
author(bijou, [queen]).
author(one_vision, [queen]).
author(body_language, [mercury]).
author(bohemian_rhapsody, [mercury]).
author(breakthru, [queen, taylor, mercury]).
author(brighton_rock, [may]).

% Lead Vocalists
% Title, Vocalist
lead_vocals(action_this_day, [taylor, mercury]).
lead_vocals(all_dead_all_dead, [may, mercury]).
lead_vocals(all_gods_people, [mercury]).
lead_vocals(another_one_bites_the_dust, [mercury]).
lead_vocals(back_chat, [mercury]).
lead_vocals(bicycle_race, [mercury]).
lead_vocals(bijou, [mercury]).
lead_vocals(one_vision, [mercury, may, taylor]).
lead_vocals(body_language, [mercury]).
lead_vocals(bohemian_rhapsody, [mercury]).
lead_vocals(breakthru, [mercury]).
lead_vocals(brighton_rock, [may, mercury]).

% Helper to know if two elements are equal
equal(X,X).


% Return the songs that where first released in the same year
% Example
% ?- song_same_year(X, Y).
% Returns
% X = action_this_day,
% Y = back_chat .
song_same_year(X, Y):-
  song_info(Year, X, _, _),
  song_info(Year, Y, _, _),
  not(equal(X,Y)).

% Returns all songs froma given year
% Examle
% all_songs_from(1980, Name).
% Returns
% Name = another_one_bites_the_dust ;
% Name = arboria ;
% Name = battle_theme.
all_songs_from(Year, Name):-
  song_info(Year, Name, _, _).


% Returns songs from a given author
% Examle
% ?- who_author(mercury, Song).
% Returns
% Song = all_gods_people ;
% Song = bicycle_race ;
% Song = body_language ;
% Song = bohemian_rhapsody ;
% Song = breakthru ;
who_author(Author, Song):-
  author(Song, List),
  is_in(Author, List).


% Returns spongs that are leaded by a given Vocalist
% Examle
% ?- who_leads(may, Song).
% Returns
% Song = all_dead_all_dead ;
% Song = one_vision ;
% Song = brighton_rock.
who_leads(Leads, Song):-
  lead_vocals(Song, List),
  is_in(Leads, List).

% Helps to find an if an element is part of the list
is_in(N, [N|_]):- !.
is_in(N, [_|T]):-
  is_in(N, T).
