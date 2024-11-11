% ./solution.pl
% Main predicate for translating list according to map:
aa([], _, []).
aa([H|T], Map, Result) :-
    % Get all possible translations for the head:
    findall(Trans, get_translations(H, Map, Trans), Translations),
    % Recursively process the tail:
    aa(T, Map, TailResult),
    % Combine translations with tail result and remove duplicates:
    append(Translations, TailResult, Combined),
    remove_duplicates(Combined, Result).

% Helper predicate to get translations from map:
get_translations(Elem, Map, Trans) :-
    member((Elem, Trans), Map).

% Helper predicate to remove duplicates while preserving order:
% Base case – empty list:
remove_duplicates([], []).
% If head is already in tail, skip it:
remove_duplicates([H|T], Result) :-
    member(H, T),
    remove_duplicates(T, Result).
% If head is not in tail, keep it:
remove_duplicates([H|T], [H|Result]) :-
    \+ member(H, T),
    remove_duplicates(T, Result).

% Helper predicate to check if a list has duplicates:
has_duplicates(List) :-
    append(_, [X|Rest], List),
    member(X, Rest).