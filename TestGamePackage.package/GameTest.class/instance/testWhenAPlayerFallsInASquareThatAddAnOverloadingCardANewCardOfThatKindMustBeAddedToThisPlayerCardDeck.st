squares tests
testWhenAPlayerFallsInASquareThatAddAnOverloadingCardANewCardOfThatKindMustBeAddedToThisPlayerCardDeck
	| playerLucho game dice board squares playerLuchoDeck playerLuchoHistory |
	playerLuchoHistory := OrderedCollection new.
	playerLuchoHistory add: (PlayerPosition at: 1 withLaps: 0).
	playerLuchoDeck := OrderedCollection new.
	playerLuchoDeck
		add: self aCollectionOfGameCards removeFirst;
		add: (self aCollectionOfGameCards removeAt: 2).
	playerLucho := Player named: 'Lucho' withCards: playerLuchoDeck andPositionHistory: playerLuchoHistory.
	squares := (1 to: 3) collect: [ :n | SquareWithoutEffect onPosition: n ].
	squares at: 1 put: (SquareThatAddACard onPosition: 1 withACardToBeAdded: (self aCollectionOfGameCards removeAt: 7)).
	squares at: 3 put: (SquareThatAddACard onPosition: 3 withACardToBeAdded: (self aCollectionOfGameCards removeAt: 8)).
	board := Board definedSquares: squares.
	dice := Dice faces: 6 obtainingValuesFrom: (FixedNumberSource providing: #(1 2 3 4 5 6)).
	game := Game
		playedBy: (OrderedCollection with: playerLucho)
		on: board
		throwing: (OrderedCollection with: dice)
		winningWhenCompleting: 1
		withACardDeck: self aCollectionOfGameCards.
	self assert: playerLucho numberOfCardsInDeck equals: 2.
	game nextTurnFor: playerLucho.
	self assert: playerLucho numberOfCardsInDeck equals: 2.
	game nextTurnFor: playerLucho.
	self assert: playerLucho numberOfCardsInDeck equals: 3.
	game nextTurnFor: playerLucho.
	self assert: playerLucho numberOfCardsInDeck equals: 4