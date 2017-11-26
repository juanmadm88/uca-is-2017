tests
testWhenAPotentiationCardIsThrownAfterPlayerFellInWormHoleSquareEffectIsDoubled
	| playerLuchoHistory squares board diceOneFace collectionOfDices collectionOfPlayers playerLuchoDeck cardToAffectPlayer playerLucho laps gameDeck game |
	playerLuchoHistory := OrderedCollection new.
	playerLuchoHistory add: (PlayerPosition at: 1 withLaps: 0).
	squares := (1 to: 16) collect: [ :n | SquareWithoutEffect onPosition: n ].
	board := Board definedSquares: squares.
	squares at: 10 put: (SquareWormHole onPosition: 10).
	diceOneFace := Dice faces: 1 obtainingValuesFrom: (FixedNumberSource providing: #(9)).
	collectionOfDices := OrderedCollection new.
	collectionOfDices add: diceOneFace.
	collectionOfPlayers := OrderedCollection new.
	playerLuchoDeck := OrderedCollection new.
	cardToAffectPlayer := CardPotentiation named: 'CardPotentiation1'.
	playerLuchoDeck
		add: cardToAffectPlayer;
		add: (CardOverloading named: 'CardOverloading1').
	playerLucho := Player named: 'Lucho' withCards: playerLuchoDeck andPositionHistory: playerLuchoHistory.
	laps := 1.
	collectionOfPlayers add: playerLucho.
	gameDeck := OrderedCollection new.
	gameDeck
		add: (CardOverloading named: 'CardOverloading2');
		add: (CardSpeed named: 'CardSpeed2').
	game := Game
		playedBy: collectionOfPlayers
		on: board
		throwing: collectionOfDices
		winningWhenCompleting: laps
		withACardDeck: gameDeck.
	self assert: playerLucho numberOfCardsInDeck equals: 2.
	playerLucho affect: playerLucho withAnInstantCard: cardToAffectPlayer into: game.
	self assert: playerLucho numberOfCardsInDeck equals: 1.
	self assert: playerLucho currentPosition equals: 1.
	game nextTurnFor: playerLucho.
	self assert: playerLucho currentPosition equals: 2