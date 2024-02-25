% Einstein's Problem

/*
Source: Wikipedia

Description
The following version of the puzzle appeared in Life International in 1962:

There are five houses.
The Englishman lives in the red house.
The Spaniard owns the dog.
Coffee is drunk in the green house.
The Ukrainian drinks tea.
The green house is immediately to the right of the ivory house.
The Old Gold smoker owns snails.
Kools are smoked in the yellow house.
Milk is drunk in the middle house.
The Norwegian lives in the first house.
The man who smokes Chesterfields lives in the house next to the man with the fox.
Kools are smoked in the house next to the house where the horse is kept.
The Lucky Strike smoker drinks orange juice.
The Japanese smokes Parliaments.
The Norwegian lives next to the blue house.
Now, who drinks water? Who owns the zebra?

In the interest of clarity, it must be added that each of the five houses is 
painted a different color, and their inhabitants are of different national 
extractions, own different pets, drink different beverages and smoke different 
brands of American cigarets [sic]. One other thing: in statement 6, right 
means your right.

— Life International, December 17, 1962[5]

*/

right_of(X, Y) :- X is Y + 1.
left_of(X, Y) :- right_of(Y, X).

next_to(X, Y) :- right_of(X, Y).
next_to(X, Y) :- left_of(X, Y).

solve(Einstein, WaterDrinker, ZebraOwner) :-
    % There are five houses.
    Einstein = [
           house(1,      _Nationality1, _Color1, _Pet1,  _Drink1,      _Smoke1      ),
           house(2,      _Nationality2, _Color2, _Pet2,  _Drink2,      _Smoke2      ),
           house(3,      _Nationality3, _Color3, _Pet3,  _Drink3,      _Smoke3      ),
           house(4,      _Nationality4, _Color4, _Pet4,  _Drink4,      _Smoke4      ),
           house(5,      _Nationality5, _Color5, _Pet5,  _Drink5,      _Smoke5      )],

    % The Englishman lives in the red house.
    member(house(_,      englishman,    red,     _,      _,            _            ), Einstein),
    
    % The Spaniard owns the dog.
    member(house(_,      spaniard,      _,       dog,    _,            _            ), Einstein),

    % Coffee is drunk in the green house.
    member(house(_,      _,             green,   _,      coffee,       _            ), Einstein),

    % The Ukrainian drinks tea.
    member(house(_,      ukrainian,     _,       _,      tea,          _            ), Einstein),

    % The green house is immediately to the right of the ivory house.
    member(house(A,      _,             green,   _,      _,            _            ), Einstein),
    member(house(B,      _,             ivory,   _,      _,            _            ), Einstein),
    right_of(A, B),

    % The Old Gold smoker owns snails.
    member(house(_,      _,             _,       snails, _,            old_gold     ), Einstein),

    % Kools are smoked in the yellow house.
    member(house(_,      _,             yellow,  _,      _,            kools        ), Einstein),

    % Milk is drunk in the middle house.
    member(house(3,      _,             _,       _,      milk,         _            ), Einstein),

    % The Norwegian lives in the first house.
    member(house(1,      norwegian,     _,       _,      _,            _            ), Einstein),

    % The man who smokes Chesterfields lives in the house next to the man with the fox.
    member(house(C,      _,             _,       _,      _,            chesterfields), Einstein),
    member(house(D,      _,             _,       fox,    _,            _            ), Einstein),
    next_to(C, D),

    % Kools are smoked in the house next to the house where the horse is kept.
    member(house(E,      _,             _,       _,      _,            kools        ), Einstein),
    member(house(F,      _,             _,       horse,  _,            _            ), Einstein),
    next_to(E, F),

    % The Lucky Strike smoker drinks orange juice.
    member(house(_,      _,             _,       _,      orange_juice, lucky_strike ), Einstein),

    % The Japanese smokes Parliaments.
    member(house(_,      japanese,      _,       _,      _,            parliaments  ), Einstein),

    % The Norwegian lives next to the blue house.
    member(house(G,      norwegian,     _ ,      _ ,     _,            _            ), Einstein),
    member(house(H,      _,             blue,    _ ,     _,            _            ), Einstein),
    next_to(G, H),

    % Now, who drinks water? Who owns the zebra?
    member(house(_,      WaterDrinker,  _,       _,      water,        _            ), Einstein),
    member(house(_,      ZebraOwner,    _,       zebra,  _,            _            ), Einstein).


:- use_rendering(table, [header(house('Number', 'Owner', 'Color', 'Pet', 'Drink', 'Smoke'))]).