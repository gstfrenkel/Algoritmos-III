!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'jf 5/1/2022 20:12:52'!
assertThat: aRequest will: fail andExecute: aClosure

	[aRequest value. self fail.]
		on: fail 
		do: aClosure! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GF 4/30/2022 17:58:11'!
assertThatA: customerBook has: activeCustomers and: totalAndSuspendedCustomers
	
	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: totalAndSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: totalAndSuspendedCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GF 4/30/2022 16:09:56'!
assertThatExecuting: aClosure takesLessThan: time	
	
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (time).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GF 4/30/2022 16:10:22'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThatExecuting: [customerBook addCustomerNamed: 'John Lennon'.] takesLessThan: 50 * millisecond.
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GF 4/30/2022 16:10:55'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self assertThatExecuting: [customerBook addCustomerNamed: paulMcCartney. customerBook removeCustomerNamed: paulMcCartney.] takesLessThan: 100 * millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jf 5/1/2022 20:15:04'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertThat: [customerBook addCustomerNamed: ''.] will: Error andExecute: [ :anError |
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jf 5/1/2022 20:15:46'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
		
	self assertThat: [customerBook removeCustomerNamed: 'Paul McCartney'] will: NotFound andExecute: [:anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon)].
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GF 4/30/2022 17:58:23'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.	
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThatA: customerBook has: 0 and: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GF 4/30/2022 17:58:27'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
		
	self assertThatA: customerBook has: 0 and: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jf 5/1/2022 20:16:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThat: [customerBook suspendCustomerNamed: 'Ringo Starr'.] will: CantSuspend andExecute: [:anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon)]. 
	
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jf 5/1/2022 20:17:08'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
		
	self assertThat: [customerBook suspendCustomerNamed: johnLennon.] will: CantSuspend andExecute: [ :anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon)]
	

! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'jf 5/1/2022 20:20:38'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.
	! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'GF 4/30/2022 17:44:43'!
removeCustomerNamed: aName 

	^active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [NotFound signal]].
	
	
	
	
	
	
	"suspended remove: aName ifAbsent: self.

	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].

	^ NotFound signal."
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
