!classDefinition: #MarsRoverTest category: 'AlgoIII - MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRoverFacingNorth marsRoverFacingWest marsRoverFacingSouth marsRoverFacingEast'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'jc 5/27/2022 14:40:31'!
test01OrderingMarsRoverToStayPutKeepsItPlace
	
	marsRoverFacingNorth move: ''.

	self assert: marsRoverFacingNorth position = (0@0)
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'jc 5/27/2022 14:40:31'!
test02OrderingMarsRoverFacingNorthToMoveForwardSendsItOneStepTowardsTheNorth

	marsRoverFacingNorth move: 'f'.

	self assert: marsRoverFacingNorth position = (0@1)
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'jc 5/27/2022 14:40:31'!
test03OrderingMarsRoverFacingNorthToMoveBackwardsSendsItTowardsTheSouth

	marsRoverFacingNorth move: 'b'.
	
	self assert: marsRoverFacingNorth position = (0@-1)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'GF 5/29/2022 23:21:13'!
test04OrderingMarsRoverFacingNorthToRotateLeftMakesItFaceWest

	marsRoverFacingNorth move: 'l'.
	
	self assert: marsRoverFacingNorth orientation = $W
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'jc 5/27/2022 14:48:37'!
test05OrderingMarsRoverFacingNorthToRotateRightMakesItFaceEast

	marsRoverFacingNorth move: 'r'.
	
	self assert: marsRoverFacingNorth orientation = $E
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'jc 5/27/2022 14:48:33'!
test06OrderingMarsRoverFacingWestToMoveForwardSendsItOneStepTowardsTheWest

	marsRoverFacingWest move: 'f'.
	
	self assert: marsRoverFacingWest position = (-1@0)
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'jc 5/27/2022 14:48:59'!
test07OrderingMarsRoverFacingWestToRotateLeftMakesItFaceSouth

	marsRoverFacingWest move: 'l'.
	
	self assert: marsRoverFacingWest orientation = $S
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'GF 5/31/2022 12:10:56'!
test08OrderingMarsRoverFacingWestToRotateRightMakesItFaceNorth

	marsRoverFacingWest move: 'r'.
	
	self assert: marsRoverFacingWest orientation = $N
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'GF 5/31/2022 12:11:07'!
test09OrderingMarsRoverFacingNorthToRotateRightAndMoveBackwardsSendsItOneStepTowardsTheWestAndMakesItFaceEast

	marsRoverFacingNorth move: 'rb'.
	
	self assert: marsRoverFacingNorth position = (-1@0).
	self assert: marsRoverFacingNorth orientation = $E
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'GF 5/31/2022 12:11:11'!
test10OrderingMarsRoverFacingWestToRotateLeftAndMoveForwardSendsItOneStepTowardsTheSouthAndMakesItFaceSouth

	marsRoverFacingWest move: 'lf'.
	
	self assert: marsRoverFacingWest position = (0@-1).
	self assert: marsRoverFacingWest orientation = $S
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'GF 5/31/2022 12:11:15'!
test11OrderingMarsRoverFacingNorthToRotateTwiceMakesItFaceSouth

	marsRoverFacingNorth move: 'rr'.
	
	self assert: marsRoverFacingNorth orientation = $S
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'GF 5/31/2022 12:11:20'!
test12OrderingMarsRoverFacingWestToMoveBackwardsTwiceSendsItTwoStepsTowardsTheEast

	marsRoverFacingWest move: 'bb'.
	
	self assert: marsRoverFacingWest position = (2@0).
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'GF 5/31/2022 12:11:25'!
test13OrderingMarsRoverFacingSouthToMoveBackwardsAndRotateLeftMakesItTakeAStepTowardsTheNorthAndFaceEast

	marsRoverFacingSouth move: 'bl'.
	
	self assert: marsRoverFacingSouth position = (0@1).
	self assert: marsRoverFacingSouth orientation = $E
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'GF 5/31/2022 12:11:28'!
test14OrderingMarsRoverFacingEastToMoveForwardAndRotateLeftMakesItTakeAStepTowardsTheEastAndFaceNorth

	marsRoverFacingEast move: 'fl'.
	
	self assert: marsRoverFacingEast position = (1@0).
	self assert: marsRoverFacingEast orientation = $N
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'GF 6/1/2022 22:45:34'!
test15OrderingAMarsRoverToMoveManyTimesLeavesItAtTheCorrectPositionAndLookingToTheCorrectCardinalDirection

	marsRoverFacingNorth move: 'lffrrblfrrrlblf'.
	    
	self assert: marsRoverFacingNorth position = (-2@2).
	self assert: marsRoverFacingNorth orientation = $E! !

!MarsRoverTest methodsFor: 'testing' stamp: 'GF 5/31/2022 12:12:31'!
test16SendingMarsRoverACorruptedOrderLeavesItAtTheLastPositionAndRaisesAnError

	self 
		should: [ marsRoverFacingNorth move: 'lffrrblfh' ]	
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText  = MarsRoverMovement corruptedOrderErrorDescription.
			self assert: marsRoverFacingNorth position = (-3@1).
			self assert: marsRoverFacingNorth orientation = $N 
		]! !


!MarsRoverTest methodsFor: 'initialization' stamp: 'GF 5/31/2022 12:08:58'!
setUp

	marsRoverFacingNorth _ MarsRover new initializeWithOrientation: $N.
	marsRoverFacingWest  _ MarsRover new initializeWithOrientation: $W.
	marsRoverFacingSouth _ MarsRover new initializeWithOrientation: $S.
	marsRoverFacingEast _ MarsRover new initializeWithOrientation: $E
	! !


!classDefinition: #MarsRover category: 'AlgoIII - MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'orientation position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'jc 5/27/2022 14:28:43'!
initializeWithOrientation: anOrientationForMarsRoverToFace 
	
	orientation _ anOrientationForMarsRoverToFace.
	position _ (0@0)! !


!MarsRover methodsFor: 'disposition' stamp: 'jc 5/27/2022 14:35:53'!
orientation

	^orientation! !

!MarsRover methodsFor: 'disposition' stamp: 'jc 5/27/2022 14:27:56'!
position

	^position! !


!MarsRover methodsFor: 'movement' stamp: 'GF 5/31/2022 12:18:55'!
move: aSetOfMovementsMarsRoverShouldPerform
	
	| aMovementToBePerformed |
	    
	aSetOfMovementsMarsRoverShouldPerform do: [ :eachMovement |
		        			
		aMovementToBePerformed _ MarsRoverMovement findKindOfMovementOf: eachMovement.
		aMovementToBePerformed isCarriedOutBy: self
		
		"En vez del mensaje polimórfico </isCarriedOutBy> teníamos cuatro </ifTrue> que chequeaban la clase de </aMovementToBePerformed> y actualizaban la posición u orientación en función de dicha clase. Consideramos que era mejor aumentar un poco la complejidad con un Double Dispatch que dejar los cuatro </ifTrue> sabiendo que teníamos la posibilidad de crear mensajes polimórficos con las clases ya creadas."
		
	].
	
	
	
! !


!MarsRover methodsFor: 'movement - private' stamp: 'GF 5/30/2022 21:10:21'!
performMovement: aMovementToBePerformed

	position _ aMovementToBePerformed isPerformedBy: self! !

!MarsRover methodsFor: 'movement - private' stamp: 'GF 5/30/2022 21:10:21'!
performRotation: aRotationToBePerformed

	orientation _ aRotationToBePerformed isPerformedBy: self! !


!classDefinition: #MarsRoverMovement category: 'AlgoIII - MarsRover'!
Object subclass: #MarsRoverMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!MarsRoverMovement methodsFor: 'movement - private' stamp: 'GF 6/1/2022 22:43:02'!
find: theNewCardinalDirectionThatAMarsRoverIsFacing for: aRotatingMarsRover
	
    	| orientation |
    
	orientation _ MarsRoverOrientation findKindOfCardinalDirectionOf: aRotatingMarsRover orientation.
	
	^(theNewCardinalDirectionThatAMarsRoverIsFacing value: orientation)! !

!MarsRoverMovement methodsFor: 'movement - private' stamp: 'GF 5/30/2022 21:08:41'!
isCarriedOutBy: aMarsRover

	self subclassResponsibility ! !

!MarsRoverMovement methodsFor: 'movement - private' stamp: 'GF 5/30/2022 21:10:21'!
isPerformedBy: aMarsRover

	self subclassResponsibility 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverMovement class' category: 'AlgoIII - MarsRover'!
MarsRoverMovement class
	instanceVariableNames: ''!

!MarsRoverMovement class methodsFor: 'error' stamp: 'jc 5/27/2022 15:21:50'!
corruptedOrderErrorDescription

	^'Order is corrupted'! !


!MarsRoverMovement class methodsFor: 'initialization - private' stamp: 'jc 5/27/2022 15:21:13'!
findKindOfMovementOf: aMovementToBePerformed
	
	| kindOfMovement | 
	
	kindOfMovement _ self subclasses detect: [ :eachSubclass | eachSubclass isAMovementTheSameKindAsTheClass: aMovementToBePerformed ] ifNone: [^self error: self corruptedOrderErrorDescription ].
	
	^kindOfMovement new
	! !


!classDefinition: #BackwardsMovement category: 'AlgoIII - MarsRover'!
MarsRoverMovement subclass: #BackwardsMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!BackwardsMovement methodsFor: 'movement - private' stamp: 'GF 5/30/2022 21:07:55'!
isCarriedOutBy: aMarsRover

	aMarsRover performMovement: self! !

!BackwardsMovement methodsFor: 'movement - private' stamp: 'GF 5/31/2022 12:23:37'!
isPerformedBy: aMarsRover

	| orientation |

	orientation _ MarsRoverOrientation findKindOfCardinalDirectionOf: aMarsRover orientation.
	
	^orientation findTheNewPositionAMarsRoverWouldBeFacingIfItMovesBackwardsBasedOnIts: (aMarsRover position x) and: (aMarsRover position y)
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardsMovement class' category: 'AlgoIII - MarsRover'!
BackwardsMovement class
	instanceVariableNames: ''!

!BackwardsMovement class methodsFor: 'comparing - private' stamp: 'jc 5/27/2022 18:31:46'!
isAMovementTheSameKindAsTheClass: aMovementToBePerfomed

	^aMovementToBePerfomed  = $b! !


!classDefinition: #ForwardMovement category: 'AlgoIII - MarsRover'!
MarsRoverMovement subclass: #ForwardMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!ForwardMovement methodsFor: 'movement - private' stamp: 'GF 5/30/2022 21:08:09'!
isCarriedOutBy: aMarsRover

	aMarsRover performMovement: self! !

!ForwardMovement methodsFor: 'movement - private' stamp: 'GF 5/31/2022 12:23:19'!
isPerformedBy: aMarsRover

	| orientation |
	
	orientation _ MarsRoverOrientation findKindOfCardinalDirectionOf: aMarsRover orientation.
	
	^orientation findTheNewPositionAMarsRoverWouldBeFacingIfItMovesForwardBasedOnIts: (aMarsRover position x) and: (aMarsRover position y)
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardMovement class' category: 'AlgoIII - MarsRover'!
ForwardMovement class
	instanceVariableNames: ''!

!ForwardMovement class methodsFor: 'comparing - private' stamp: 'jc 5/27/2022 18:31:51'!
isAMovementTheSameKindAsTheClass: aMovementToBePerfomed

	^aMovementToBePerfomed  = $f! !


!classDefinition: #LeftRotation category: 'AlgoIII - MarsRover'!
MarsRoverMovement subclass: #LeftRotation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!LeftRotation methodsFor: 'movement - private' stamp: 'GF 5/30/2022 21:08:21'!
isCarriedOutBy: aMarsRover

	aMarsRover performRotation: self! !

!LeftRotation methodsFor: 'movement - private' stamp: 'GF 5/30/2022 21:20:25'!
isPerformedBy: aMarsRover

	^self find: [ :anOrientation | anOrientation findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesLeft ] for: aMarsRover
    	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LeftRotation class' category: 'AlgoIII - MarsRover'!
LeftRotation class
	instanceVariableNames: ''!

!LeftRotation class methodsFor: 'comparing - private' stamp: 'jc 5/27/2022 18:31:57'!
isAMovementTheSameKindAsTheClass: aMovementToBePerfomed

	^aMovementToBePerfomed  = $l! !


!classDefinition: #RightRotation category: 'AlgoIII - MarsRover'!
MarsRoverMovement subclass: #RightRotation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!RightRotation methodsFor: 'movement - private' stamp: 'GF 5/30/2022 21:08:28'!
isCarriedOutBy: aMarsRover

	aMarsRover performRotation: self! !

!RightRotation methodsFor: 'movement - private' stamp: 'GF 5/30/2022 21:20:36'!
isPerformedBy: aMarsRover

	^self find: [ :anOrientation | anOrientation findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesRight ] for: aMarsRover! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RightRotation class' category: 'AlgoIII - MarsRover'!
RightRotation class
	instanceVariableNames: ''!

!RightRotation class methodsFor: 'comparing - private' stamp: 'jc 5/27/2022 18:32:01'!
isAMovementTheSameKindAsTheClass: aMovementToBePerfomed

	^aMovementToBePerfomed  = $r! !


!classDefinition: #MarsRoverOrientation category: 'AlgoIII - MarsRover'!
Object subclass: #MarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!MarsRoverOrientation methodsFor: 'orientation - private' stamp: 'GF 5/30/2022 21:20:25'!
findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesLeft
	
	self subclassResponsibility ! !

!MarsRoverOrientation methodsFor: 'orientation - private' stamp: 'GF 5/30/2022 21:20:36'!
findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesRight
	
	self subclassResponsibility ! !


!MarsRoverOrientation methodsFor: 'location - private' stamp: 'GF 5/31/2022 12:23:37'!
findTheNewPositionAMarsRoverWouldBeFacingIfItMovesBackwardsBasedOnIts: xCoordinateToBeUpdated and: yCoordinateToBeUpdated	

	self subclassResponsibility ! !

!MarsRoverOrientation methodsFor: 'location - private' stamp: 'GF 5/31/2022 12:23:18'!
findTheNewPositionAMarsRoverWouldBeFacingIfItMovesForwardBasedOnIts: xCoordinateToBeUpdated and: yCoordinateToBeUpdated

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientation class' category: 'AlgoIII - MarsRover'!
MarsRoverOrientation class
	instanceVariableNames: ''!

!MarsRoverOrientation class methodsFor: 'initialization - private' stamp: 'jc 5/27/2022 18:35:28'!
findKindOfCardinalDirectionOf: aCardinalDirectionAMarsRoverIsFacing

	| aCardinalDirection |

	aCardinalDirection _ self subclasses detect: [ :eachCardinalDirection | eachCardinalDirection isACardinalDirectionTheSameKindAsTheClass: aCardinalDirectionAMarsRoverIsFacing ].
	
	^aCardinalDirection new	! !


!classDefinition: #East category: 'AlgoIII - MarsRover'!
MarsRoverOrientation subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!East methodsFor: 'orientation - private' stamp: 'GF 5/30/2022 21:20:25'!
findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesLeft
	
	^$N! !

!East methodsFor: 'orientation - private' stamp: 'GF 5/30/2022 21:20:36'!
findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesRight
	
	^$S! !


!East methodsFor: 'location - private' stamp: 'GF 5/31/2022 12:23:37'!
findTheNewPositionAMarsRoverWouldBeFacingIfItMovesBackwardsBasedOnIts: xCoordinateToBeUpdated and: yCoordinateToBeUpdated

	^((xCoordinateToBeUpdated - 1) @ yCoordinateToBeUpdated)! !

!East methodsFor: 'location - private' stamp: 'GF 5/31/2022 12:23:18'!
findTheNewPositionAMarsRoverWouldBeFacingIfItMovesForwardBasedOnIts: xCoordinateToBeUpdated and: yCoordinateToBeUpdated

	^((xCoordinateToBeUpdated + 1) @ yCoordinateToBeUpdated)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'AlgoIII - MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'comparing - private' stamp: 'jc 5/27/2022 18:34:17'!
isACardinalDirectionTheSameKindAsTheClass: aCardinalDirectionToBeVerified

	^aCardinalDirectionToBeVerified = $E! !


!classDefinition: #North category: 'AlgoIII - MarsRover'!
MarsRoverOrientation subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!North methodsFor: 'orientation - private' stamp: 'GF 5/30/2022 21:20:25'!
findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesLeft

	^$W! !

!North methodsFor: 'orientation - private' stamp: 'GF 5/30/2022 21:20:36'!
findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesRight

	^$E! !


!North methodsFor: 'location - private' stamp: 'GF 5/31/2022 12:23:37'!
findTheNewPositionAMarsRoverWouldBeFacingIfItMovesBackwardsBasedOnIts: xCoordinateToBeUpdated and: yCoordinateToBeUpdated	

	^(xCoordinateToBeUpdated @ (yCoordinateToBeUpdated - 1))! !

!North methodsFor: 'location - private' stamp: 'GF 5/31/2022 12:23:19'!
findTheNewPositionAMarsRoverWouldBeFacingIfItMovesForwardBasedOnIts: xCoordinateToBeUpdated and: yCoordinateToBeUpdated	

	^(xCoordinateToBeUpdated @ (yCoordinateToBeUpdated + 1))! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'AlgoIII - MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'comparing - private' stamp: 'jc 5/27/2022 18:34:24'!
isACardinalDirectionTheSameKindAsTheClass: aCardinalDirectionToBeVerified

	^aCardinalDirectionToBeVerified = $N! !


!classDefinition: #South category: 'AlgoIII - MarsRover'!
MarsRoverOrientation subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!South methodsFor: 'location - private' stamp: 'GF 5/31/2022 12:23:37'!
findTheNewPositionAMarsRoverWouldBeFacingIfItMovesBackwardsBasedOnIts: xCoordinateToBeUpdated and: yCoordinateToBeUpdated	

	^(xCoordinateToBeUpdated @ (yCoordinateToBeUpdated + 1))! !

!South methodsFor: 'location - private' stamp: 'GF 5/31/2022 12:23:19'!
findTheNewPositionAMarsRoverWouldBeFacingIfItMovesForwardBasedOnIts: xCoordinateToBeUpdated and: yCoordinateToBeUpdated	

	^(xCoordinateToBeUpdated @ (yCoordinateToBeUpdated - 1))! !


!South methodsFor: 'orientation - private' stamp: 'GF 5/30/2022 21:20:25'!
findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesLeft

	^$E! !

!South methodsFor: 'orientation - private' stamp: 'GF 5/30/2022 21:20:36'!
findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesRight

	^$W! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'AlgoIII - MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'comparing - private' stamp: 'jc 5/27/2022 18:34:39'!
isACardinalDirectionTheSameKindAsTheClass: aCardinalDirectionToBeVerified

	^aCardinalDirectionToBeVerified = $S! !


!classDefinition: #West category: 'AlgoIII - MarsRover'!
MarsRoverOrientation subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII - MarsRover'!

!West methodsFor: 'location - private' stamp: 'GF 5/31/2022 12:23:37'!
findTheNewPositionAMarsRoverWouldBeFacingIfItMovesBackwardsBasedOnIts: xCoordinateToBeUpdated and: yCoordinateToBeUpdated	

	^((xCoordinateToBeUpdated + 1) @ yCoordinateToBeUpdated)! !

!West methodsFor: 'location - private' stamp: 'GF 5/31/2022 12:23:19'!
findTheNewPositionAMarsRoverWouldBeFacingIfItMovesForwardBasedOnIts: xCoordinateToBeUpdated and: yCoordinateToBeUpdated	

	^((xCoordinateToBeUpdated - 1) @ yCoordinateToBeUpdated)! !


!West methodsFor: 'orientation - private' stamp: 'GF 5/30/2022 21:20:25'!
findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesLeft

 	^$S! !

!West methodsFor: 'orientation - private' stamp: 'GF 5/30/2022 21:20:36'!
findTheNewCardinalDirectionAMarsRoverWouldBeFacingIfItRotatesRight

 	^$N! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'AlgoIII - MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'comparing - private' stamp: 'GF 5/29/2022 23:21:54'!
isACardinalDirectionTheSameKindAsTheClass: aCardinalDirectionToBeVerified

	^aCardinalDirectionToBeVerified = $W! !
