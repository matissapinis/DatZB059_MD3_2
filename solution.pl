% ./solution.pl
% Main predicate for translating list according to map:
aa([], _, []).
aa(List, Map, Result) :-
    % Get all translations for all elements preserving map order:
    collect_translations(List, Map, [], AllTranslations),
    % Remove duplicates while preserving order:
    remove_duplicates(AllTranslations, Intermediate),
    % Reverse the final result to get correct order:
    reverse(Intermediate, Result).

% Helper predicate to collect all translations in map order:
collect_translations(_, [], Acc, Acc).
collect_translations(List, [(Key,Value)|RestMap], Acc, Result) :-
    % If Key is in the input list, add Value to accumulator:
    (member(Key, List) ->
        collect_translations(List, RestMap, [Value|Acc], Result)
    ;
        collect_translations(List, RestMap, Acc, Result)
    ).

% Helper predicate to remove duplicates while preserving order:
remove_duplicates([], []).
remove_duplicates([H|T], Result) :-
    member(H, T),
    remove_duplicates(T, Result).
remove_duplicates([H|T], [H|Result]) :-
    \+ member(H, T),
    remove_duplicates(T, Result).