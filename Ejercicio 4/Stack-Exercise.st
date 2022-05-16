!classDefinition: #OOStackLimitedTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackLimitedTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackLimitedTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:08:37'!
test01StackCanHoldTheMaxAmountOfElements

	| stack |
	
	stack := OOStackLimited withLimit: 3.
	
	stack push: 'hola'.
	stack push: 'como'.
	stack push: 'estas'.
	
	self assert: stack size = 3.


	
	! !

!OOStackLimitedTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:08:42'!
test02StackCanNotHoldMoreElementsThanTheMaxAmount

	| stack |
	
	stack := OOStackLimited withLimit: 3.
	
	stack push: 'hola'.
	stack push: 'como'.
	stack push: 'estas'.
	
	self
		should: [ stack push: '?' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStackLimited stackIsFullErrorDescription ]

	
	! !

!OOStackLimitedTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:08:45'!
test03AStackMaxSizeCanNotBeSmallerThanOne

	self
		should: [ OOStackLimited withLimit: 0 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStackLimited maxSizeIsSmallerThanOneErrorDescription ]
	! !

!OOStackLimitedTest methodsFor: 'test' stamp: 'GF 5/16/2022 12:55:33'!
test04AStackMaxSizeMustBeANumber

	self
		should: [ OOStackLimited withLimit: 'Hola' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStackLimited maxSizeIsNotANumberErrorDescription ]
	! !


!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:09'!
setUp

	stack := OOStack new.! !

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:13'!
test01StackShouldBeEmptyWhenCreated
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:16'!
test02PushAddElementsToTheStack

	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:20'!
test03PopRemovesElementsFromTheStack

	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:24'!
test04PopReturnsLastPushedObject

	| pushedObject |
	
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:29'!
test05StackBehavesLIFO

	| firstPushedObject secondPushedObject |
	
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:32'!
test06TopReturnsLastPushedObject

	| pushedObject |
	
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:36'!
test07TopDoesNotRemoveObjectFromStack

	| pushedObject |
	
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:39'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:43'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:01:45'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stack finderByPrefix expectedCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:04:37'!
setUp

	stack := OOStack new.
	finderByPrefix := SentenceFinderByPrefix new.
	expectedCollection := OrderedCollection new! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:03:24'!
test01CanNotFindStringInEmptyStack
	
	self
		should: [ finderByPrefix find: 'hol' in: stack]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:03:35'!
test02CanNotFindAnEmptyPrefix

	stack push: 'hola'.
	
	self
		should: [ finderByPrefix find: '' in: stack]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]
		
		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:03:47'!
test03CanNotFindAPrefixWithEmptySpace

	stack push: 'hola como estas? todo bien'.
	
	self
		should: [ finderByPrefix find: 'hola como estas?' in: stack]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:04:54'!
test04CanFindAnExistingPrefix

	expectedCollection add: 'hola'.
	
	stack push: 'hola'.
	stack push: 'como'.
	
	self assert: ((finderByPrefix find: 'hol' in: stack) = expectedCollection)
	
	
	

		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:05:04'!
test05FindingAPrefixManyTimesReturnsTheElementsInTheCorrectOrder

	expectedCollection add: 'hola'.
	expectedCollection add: 'holanda'.
	expectedCollection add: 'holgado'.
	
	stack push: 'hola'.
	stack push: 'como'.
	stack push: 'holanda'.
	stack push: 'baranda'.
	stack push: 'tapa de nalga'.
	stack push: 'holgado'.
	
	self assert: ((finderByPrefix find: 'hol' in: stack) = expectedCollection).	
	
	
	

		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GF 5/15/2022 19:05:15'!
test06FinderIsCaseSensitive

	stack push: 'hola'.
	stack push: 'como'.
	
	self assert: (finderByPrefix find: 'Hol' in: stack) = expectedCollection
	
	
	

		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GF 5/16/2022 12:51:02'!
test07FindingAPrefixDoesNotAlterTheStack

	stack push: 'hola'.
	stack push: 'como'.
	stack push: 'estas'.
	stack push: '?'.
	
	finderByPrefix find: 'co' in: stack.
	
	self assert: 	stack pop = '?'.
	self assert: 	stack pop = 'estas'.
	self assert: 	stack pop = 'como'.
	self assert: 	stack pop = 'hola'
		! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stackElements status'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'private' stamp: 'jc 5/15/2022 17:01:59'!
initialize

	stackElements := OrderedCollection new! !

!OOStack methodsFor: 'private' stamp: 'jc 5/15/2022 16:52:40'!
isFull

	^false! !

!OOStack methodsFor: 'private' stamp: 'GF 5/16/2022 12:42:50'!
popIfEmpty

	self error: self class stackEmptyErrorDescription! !

!OOStack methodsFor: 'private' stamp: 'jc 5/14/2022 23:57:20'!
popIfNotEmpty
	
	^self stackElements removeLast! !

!OOStack methodsFor: 'private' stamp: 'jc 5/15/2022 17:02:27'!
pushIfEmpty: aString

	^self stackElements add: aString! !

!OOStack methodsFor: 'private' stamp: 'jc 5/15/2022 17:02:31'!
pushIfNotEmpty: aString

	^self stackElements add: aString! !

!OOStack methodsFor: 'private' stamp: 'jc 5/14/2022 23:57:40'!
stackElements

	^stackElements! !

!OOStack methodsFor: 'private' stamp: 'jc 5/14/2022 23:58:47'!
status

	^StackStatus statusOf: self! !

!OOStack methodsFor: 'private' stamp: 'GF 5/16/2022 12:42:40'!
topIfEmpty

	self error: self class stackEmptyErrorDescription! !

!OOStack methodsFor: 'private' stamp: 'jc 5/14/2022 23:58:30'!
topIfNotEmpty

	^self stackElements last! !


!OOStack methodsFor: 'adding' stamp: 'GF 5/16/2022 12:54:13'!
push: aString 

	^self status push: aString on: self! !


!OOStack methodsFor: 'removing' stamp: 'GF 5/16/2022 12:38:45'!
pop
		
	^self status popFrom: self
	! !


!OOStack methodsFor: 'accessing' stamp: 'jc 5/15/2022 17:02:09'!
isEmpty

	^self size = 0! !

!OOStack methodsFor: 'accessing' stamp: 'jc 5/14/2022 23:56:21'!
size

	^self stackElements size! !

!OOStack methodsFor: 'accessing' stamp: 'jc 5/14/2022 23:58:20'!
top

	^self status findTopOf: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error description' stamp: 'jc 5/15/2022 17:04:30'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackLimited category: 'Stack-Exercise'!
OOStack subclass: #OOStackLimited
	instanceVariableNames: 'maxElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackLimited methodsFor: 'private' stamp: 'jc 5/15/2022 17:02:56'!
initializeWith: maxSize

	maxElements := maxSize! !

!OOStackLimited methodsFor: 'private' stamp: 'jc 5/15/2022 16:47:40'!
isFull

	^self size >= self maxElements! !

!OOStackLimited methodsFor: 'private' stamp: 'jc 5/15/2022 00:09:08'!
maxElements

	^maxElements! !

!OOStackLimited methodsFor: 'private' stamp: 'jc 5/15/2022 00:11:14'!
pushIfFull: aString

	self error: self class stackIsFullErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackLimited class' category: 'Stack-Exercise'!
OOStackLimited class
	instanceVariableNames: ''!

!OOStackLimited class methodsFor: 'initializing' stamp: 'GF 5/15/2022 18:54:32'!
withLimit: maxSize

	| limitedStack |
	
	self maxSizeIsNotANumber: maxSize.
	self maxSizeIsSmallerThanOneError: maxSize.

	limitedStack := OOStackLimited new.
	
	^limitedStack initializeWith: maxSize
	
	! !


!OOStackLimited class methodsFor: 'error description' stamp: 'GF 5/15/2022 18:54:53'!
maxSizeIsNotANumber: maxSize

	^maxSize isNumber not ifTrue: [ self error: self maxSizeIsNotANumberErrorDescription ]! !

!OOStackLimited class methodsFor: 'error description' stamp: 'GF 5/15/2022 18:54:43'!
maxSizeIsNotANumberErrorDescription
	
	^ 'Max size is not a number'! !

!OOStackLimited class methodsFor: 'error description' stamp: 'GF 5/15/2022 18:48:00'!
maxSizeIsSmallerThanOneError: maxSize

	^maxSize < 1 ifTrue: [ self error: self maxSizeIsSmallerThanOneErrorDescription ]! !

!OOStackLimited class methodsFor: 'error description' stamp: 'jc 5/15/2022 14:58:13'!
maxSizeIsSmallerThanOneErrorDescription
	
	^ 'Max size is smaller than one'! !

!OOStackLimited class methodsFor: 'error description' stamp: 'jc 5/15/2022 00:07:30'!
stackIsFullErrorDescription
	
	^ 'Stack is Full'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'searching' stamp: 'GF 5/16/2022 12:54:34'!
find: aPrefix in: aStack

	self emptyStackErrorIfStackIsEmpty: aStack.	
	self emptyPrefixErrorIfPrefixIsEmpty: aPrefix.
	
	^self findTheElementsOf: aStack thatBeginsWith: aPrefix
	

	
	
	
	! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'GF 5/16/2022 12:38:20'!
copy: aSourceStack into: aTargetStack

	aSourceStack size timesRepeat: [ self pop: aSourceStack andPushItsReturnedElementInto: aTargetStack ]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'jc 5/15/2022 17:03:19'!
copy: aSourceStack into: aTargetStack lookingForElementsThatBeginsWith: aPrefix

	| foundStrings |
	
	foundStrings := OrderedCollection new.
	
	aSourceStack size timesRepeat: [ 
		
		(aSourceStack top beginsWith: aPrefix) ifTrue: [ foundStrings add: aSourceStack top ].	
		
		self pop: aSourceStack andPushItsReturnedElementInto: aTargetStack
		
	].

	^foundStrings! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'jc 5/15/2022 17:03:30'!
emptyPrefixErrorIfPrefixIsEmpty: aPrefix

	^(aPrefix size = 0 or: (aPrefix includesSubString: ' ')) ifTrue: [ self error: self class prefixEmptyErrorDescription ]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'jc 5/15/2022 17:03:37'!
emptyStackErrorIfStackIsEmpty: aStack

	^ aStack isEmpty ifTrue: [ self error: aStack class stackEmptyErrorDescription ]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'GF 5/16/2022 12:54:34'!
findTheElementsOf: aStack thatBeginsWith: aPrefix

	| auxiliaryStack |
	
	auxiliaryStack := OOStack new.
	
	self copy: aStack into: auxiliaryStack.
	
	^self copy: auxiliaryStack into: aStack lookingForElementsThatBeginsWith: aPrefix! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'jc 5/15/2022 15:30:21'!
initialize

	stack := OOStack new! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'jc 5/15/2022 15:53:50'!
pop: aSourceStack andPushItsReturnedElementInto: aTargetStack

	aTargetStack push: aSourceStack pop! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'jf 5/13/2022 21:13:11'!
prefixEmptyErrorDescription
	
	^ 'Prefix is empty'! !


!classDefinition: #StackStatus category: 'Stack-Exercise'!
Object subclass: #StackStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackStatus methodsFor: 'private' stamp: 'jc 5/15/2022 00:02:25'!
findTopOf: aStack

	^aStack topIfNotEmpty! !

!StackStatus methodsFor: 'private' stamp: 'GF 5/16/2022 12:38:45'!
popFrom: aStack

	^aStack popIfNotEmpty ! !

!StackStatus methodsFor: 'private' stamp: 'GF 5/16/2022 12:54:12'!
push: aString on: aStack

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackStatus class' category: 'Stack-Exercise'!
StackStatus class
	instanceVariableNames: ''!

!StackStatus class methodsFor: 'initializing - private' stamp: 'jf 5/13/2022 20:35:59'!
statusOf: aStack

	| newStatus |

	newStatus := StackStatus subclasses detect: [ :eachSubclass | eachSubclass isTheStatusOf: aStack ].
		
	^newStatus new! !


!classDefinition: #EmptyStack category: 'Stack-Exercise'!
StackStatus subclass: #EmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStack methodsFor: 'private' stamp: 'GMF 5/12/2022 19:08:49'!
findTopOf: aStack

	^aStack topIfEmpty ! !

!EmptyStack methodsFor: 'private' stamp: 'GF 5/16/2022 12:38:45'!
popFrom: aStack

	^aStack popIfEmpty! !

!EmptyStack methodsFor: 'private' stamp: 'GF 5/16/2022 12:54:13'!
push: aString on: aStack

	^aStack pushIfEmpty: aString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyStack class' category: 'Stack-Exercise'!
EmptyStack class
	instanceVariableNames: ''!

!EmptyStack class methodsFor: 'private' stamp: 'jf 5/13/2022 20:24:55'!
isTheStatusOf: aStack

	^aStack isEmpty! !


!classDefinition: #FullStack category: 'Stack-Exercise'!
StackStatus subclass: #FullStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FullStack methodsFor: 'private' stamp: 'GF 5/16/2022 12:54:13'!
push: aString on: aStack

	aStack pushIfFull: aString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FullStack class' category: 'Stack-Exercise'!
FullStack class
	instanceVariableNames: ''!

!FullStack class methodsFor: 'private' stamp: 'jc 5/15/2022 00:09:59'!
isTheStatusOf: aStack

	^aStack isFull! !


!classDefinition: #NotEmptyNorFullStack category: 'Stack-Exercise'!
StackStatus subclass: #NotEmptyNorFullStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyNorFullStack methodsFor: 'private' stamp: 'GF 5/16/2022 12:54:13'!
push: aString on: aStack

	^aStack pushIfNotEmpty: aString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyNorFullStack class' category: 'Stack-Exercise'!
NotEmptyNorFullStack class
	instanceVariableNames: ''!

!NotEmptyNorFullStack class methodsFor: 'private' stamp: 'jc 5/15/2022 16:51:03'!
isTheStatusOf: aStack

	^aStack isEmpty not and: aStack isFull not! !
