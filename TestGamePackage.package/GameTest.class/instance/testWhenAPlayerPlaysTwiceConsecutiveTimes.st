tests
testWhenAPlayerPlaysTwiceConsecutiveTimes
	| squares board diceEightFaces diceSixFaces collectionOfDices collectionOfplayers playerScorpion playerRaiden laps game squareWithoutEffect |
	squareWithoutEffect := SquareWithoutEffect new.
	squares:= OrderedCollection new.
	8 timesRepeat: [ squares add: squareWithoutEffect ].
	board:= Board definedSquares: squares.
	diceEightFaces := Dice faces: 8 obtainingValuesFrom: (FixedNumberSource providing: #(1 2 3 4 5 6 7 8)).
	diceSixFaces := Dice faces: 6 obtainingValuesFrom: (FixedNumberSource providing: #(1 2 3 4 5 6)).
	collectionOfDices := OrderedCollection new.
	collectionOfDices
		add: diceSixFaces;
		add: diceEightFaces.
	collectionOfplayers := OrderedCollection new.
	playerScorpion := Player named: 'Scorpion'.
	playerRaiden := Player named: 'Raiden'.
	laps := 1.
	collectionOfplayers add: playerScorpion.
	collectionOfplayers add: playerRaiden.
	game := Game
		definedPlayers: collectionOfplayers
		definedBoard: board
		definedDices: collectionOfDices
		definedAmountOfLaps: laps.
	self assert: game indexOfExpectedPlayer equals: 1.
	game nextTurnFor: playerScorpion.
	self assert: game indexOfExpectedPlayer equals: 2.
	game nextTurnFor: playerScorpion.
	self assert: game indexOfExpectedPlayer equals: 2