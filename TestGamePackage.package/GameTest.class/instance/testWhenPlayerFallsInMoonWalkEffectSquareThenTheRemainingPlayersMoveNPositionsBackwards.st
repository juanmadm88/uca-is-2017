tests
testWhenPlayerFallsInMoonWalkEffectSquareThenTheRemainingPlayersMoveNPositionsBackwards
	| player1 player2 game dice board moonwalkSquare squareNonEffect squares |
	player1 := Player named: 'Lucho'.
	player2 :=Player named: 'Juanma'.
	squareNonEffect := SquareWithoutEffect  new.
	moonwalkSquare  := SquareMoonWalk new.
	squares := OrderedCollection new
		add: squareNonEffect;
		add: squareNonEffect;
		add: squareNonEffect;
		add: squareNonEffect;
		add: squareNonEffect;
		add: squareNonEffect;
		add: moonwalkSquare;
		add: squareNonEffect;
		add: squareNonEffect;
		add: squareNonEffect;
		yourself.
	board := Board definedSquares: squares.
	dice := Dice faces: 2 obtainingValuesFrom: (FixedNumberSource providing: #(1 6 6)).
	game := Game
		playedBy: (OrderedCollection with: player1 with:player2)
		on: board
		throwing: (OrderedCollection with: dice)
		winningWhenCompleting: 1.
	self assert: player1 position equals: 0.
	self assert: player2 position equals: 0.
	game nextTurnFor: player1.
	self assert: player1 position equals: 1.
	game nextTurnFor: player2.
	self assert: player2 position equals: 6.
	game nextTurnFor: player1.
	self assert: player1 position equals: 7.
	self assert: player2 position equals: 0.