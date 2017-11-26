use of cards
assert: aPlayer canAffect: aCard with: aCancellationCard
	(cards select: [ :each | aCancellationCard isEqualTo: each ])
		isNotEmpty
		ifTrue:
			[ self assert: aPlayer has: aCard toBeAffectedBy: aCancellationCard ]
		ifFalse:
			[ GameFailed signal: 'La carta no se encuentra en la mano del jugador' ]