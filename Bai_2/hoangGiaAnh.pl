%male(Person)
male(princePhilip).
male(princeCharles).
male(princeAndrew).
male(princeWilliam).
male(princeHarry).
male(princeGeorge).
male(princeLouis).
male(archieHarrison).
male(markPhillips).
male(timothyLaurence).
male(princeEdward).
male(peterPhillips).
male(mikeTindall).
male(jamesSevern).


%female(Person)
female(queenElizabethII).
female(princessDiana).
female(camillaBowles).
female(sarahFerguson).
female(kateMiddleton).
female(meghanMarkle).
female(princessEugenie).
female(princessBeatrice).
female(princessCharlotte).
female(princessAnne).
female(sophieRhys-Jones).
female(autumnPhillips).
female(zaraTindall).
female(ladyLoulse).


%parent(Parent, Child)
parent(princePhilip, princeCharles).
parent(princePhilip, princeAndrew).
parent(princePhilip, princessAnne).
parent(princePhilip, princeEdward).
parent(queenElizabethII, princeCharles).
parent(queenElizabethII, princeAndrew).
parent(queenElizabethII, princessAnne).
parent(queenElizabethII, princeEdward).

parent(princeCharles, princeWilliam).
parent(princeCharles, princeHarry).
parent(princessDiana, princeWilliam).
parent(princessDiana, princeHarry).

parent(princeWilliam, princeGeorge).
parent(princeWilliam, princessCharlotte).
parent(princeWilliam, princeLouis).
parent(kateMiddleton, princeGeorge).
parent(kateMiddleton, princessCharlotte).
parent(kateMiddleton, princeLouis).

parent(princeHarry, archieHarrison).
parent(meghanMarkle, archieHarrison).

parent(princeAndrew, princessEugenie).
parent(princeAndrew, princessBeatrice).
parent(sarahFerguson, princessEugenie).
parent(sarahFerguson, princessBeatrice).

parent(markPhillips, peterPhillips).
parent(markPhillips, zaraTindall).

parent(princessAnne, peterPhillips).
parent(princessAnne, zaraTindall).

parent(princeEdward, ladyLoulse).
parent(princeEdward, jamesSevern).
parent(sophieRhys-Jones, ladyLoulse).
parent(sophieRhys-Jones, jamesSevern).


%married(Person, Person)
married(queenElizabethII, princePhilip).
married(princeCharles, camillaBowles).
married(kateMiddleton, princeWilliam).
married(princeHarry, meghanMarkle).
married(princeAndrew, sarahFerguson).
married(princessAnne, timothyLaurence).
married(peterPhillips, autumnPhillips).
married(zaraTindall, mikeTindall).
married(princeEdward, sophieRhys-Jones).

married(princePhilip, queenElizabethII).
married(camillaBowles, princeCharles).
married(princeWilliam, kateMiddleton).
married(meghanMarkle, princeHarry).
married(sarahFerguson, princeAndrew).
married(timothyLaurence, princessAnne).
married(autumnPhillips, peterPhillips).
married(mikeTindall, zaraTindall).
married(sophieRhys-Jones, princeEdward).


%divorced(Person, Person)
divorced(princessDiana, princeCharles).
divorced(markPhillips, princessAnne).

divorced(princeCharles, princessDiana).
divorced(princessAnne, markPhillips).




%husband(Person,Wife)
%wife(Person,Husband)
%father(Parent,Child)
%mother(Parent,Child) 
%child(Child,Parent) 
%son(Child,Parent) 
%daughter(Child,Parent)

husband(Person, Wife) :- married(Person, Wife), not(divorced(Person, Wife)), male(Person).
wife(Person, Husband) :- married(Person, Husband), not(divorced(Person, Husband)), female(Person).
father(Parent, Child) :- parent(Parent, Child), male(Parent).
mother(Parent, Child) :- parent(Parent, Child), female(Parent).
child(Child, Parent) :- parent(Parent, Child).
son(Child, Parent) :- child(Child,Parent), male(Child).
daughter(Child, Parent) :- child(Child, Parent), female(Child).



%grandparent(GP,GC) 
%grandmother(GM,GC) 
%grandfather(GF,GC) 
%grandchild(GC,GP)
%grandson(GS,GP) 
%granddaughter(GD,GP)

grandparent(GP, GC) :- parent(GP, X), parent(X, GC).
grandmother(GM, GC) :- parent(GM, X), parent(X, GC), female(GM).
grandfather(GF, GC) :- parent(GF, X), parent(X, GC), male(GF).
grandchild(GC, GP) :- grandParent(GP, GC).
grandson(GS, GP) :- grandChild(GS, GP), male(GS).
granddaughter(GD, GP) :- grandchild(GD, GP), female(GD).



%sibling(Person1,Person2) 
%brother(Person,Sibling)
%sister(Person,Sibling)
%aunt(Person,NieceNephew)
%uncle(Person,NieceNephew)
%niece(Person,AuntUncle)
%nephew(Person,AuntUncle)

sibling(Person1, Person2) :- parent(X, Person1), parent(X, Person2).
brother(Person, Sibling) :- sibling(Person, Sibling), male(Person).
sister(Person, Sibling) :- sibling(Person, Sibling), female(Person).
aunt(Person, NieceNephew) :- (sister(Person, X), parent(X, NieceNephew));(wife(Person,X), sibling(X,Y), parent(Y, NieceNephew)).
uncle(Person, NieceNephew) :- (brother(Person, X), parent(X, NieceNephew));(husband(Person,X), sibling(X,Y),parent(Y,NieceNephew)).
niece(Person, AuntUncle):-(daughter(Person,X),sibling(X,AuntUncle));(daughter(Person,X),sibling(X,Y),married(Y,AuntUncle)), not(divorced(Y, AuntUncle)).
nephew(Person, AuntUncle):-(son(Person,X),sibling(X,AuntUncle));(son(Person,X),sibling(X,Y),married(Y,AuntUncle)), not(divorced(Y, AuntUncle)).



numeral(0).
numeral(succ(X)) :- numeral(X).

child1(anne,bridget).
child1(bridget,caroline).
child1(caroline,donna).
child1(donna,emily).

descend(X,Y) :- child1(X,Y).

descend(X,Y) :- child1(X,Z),
                 descend(Z,Y).