cards tests
testWhenAReversalCardIsThrownAfterPlayerPlayerFellInMoonWalkEffectSquareThenTheRemainingPlayersMoveNPositionsFoward
	| playerLucho playerJuanma game dice board squares playerLuchoHistory playerJuanmaHistory playerJuanmaCards playerLuchoCards cardToAffectPlayer |
	playerLuchoHistory := OrderedCollection new.
	playerLuchoHistory add: (PlayerPosition at: 1 withLaps: 0 withNumberOfSquaresTravelled:0).
	playerJuanmaHistory := OrderedCollection new.
	playerJuanmaHistory add: (PlayerPosition at: 1 withLaps: 0 withNumberOfSquaresTravelled:0).
	playerJuanmaCards := OrderedCollection new.
	playerLuchoCards := OrderedCollection new.
	cardToAffectPlayer := ReversalCard  named: 'ReversalCard 1'.
	playerJuanmaCards add: self aCollectionOfGameCards removeFirst; add:(self aCollectionOfGameCards removeAt:4).
	playerLuchoCards add: (self aCollectionOfGameCards removeAt:3); add:cardToAffectPlayer.
	playerLucho := Player named: 'Lucho' withCards: playerLuchoCards andPositionHistory: playerLuchoHistory.
	playerJuanma := Player named: 'Juanma' withCards: playerJuanmaCards andPositionHistory: playerJuanmaHistory.
	squares := (1 to: 10) collect: [ :n | SquareWithoutEffect initialized ].
	squares at: 2 put: (MoonWalkSquare initializeWithEffect: -6).
	board := Board definedSquares: squares.
	dice := Dice faces: 3 obtainingValuesFrom: (FixedNumberSource providing: #(1 1 5)).
	game := Game
		playedBy: (OrderedCollection with: playerLucho with: playerJuanma)
		on: board
		throwing: (OrderedCollection with: dice)
		winningWhenCompleting: 1
		withACardDeck: self aCollectionOfGameCards.
	self assert: playerLucho positions last squareNumber equals: 1.
	self assert: playerJuanma positions last squareNumber equals: 1.
	game affect: playerLucho withAPermanentCard: cardToAffectPlayer of: playerLucho.
	game nextTurnFor: playerLucho.
	self assert: playerLucho positions last squareNumber equals: 2.
	game nextTurnFor: playerJuanma.
	self assert: playerJuanma positions last squareNumber equals: 8.
	
	