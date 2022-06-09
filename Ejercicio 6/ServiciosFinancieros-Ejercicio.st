!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio portfolioToBeRegistered firstAccountToBeRegistered secondAccountToBeRegistered'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'initializing' stamp: 'GF 6/8/2022 21:44:55'!
setUp

	portfolio _ Portfolio new.
	portfolioToBeRegistered _ Portfolio new.
	firstAccountToBeRegistered _ ReceptiveAccount new.
	secondAccountToBeRegistered _ ReceptiveAccount new.
	! !


!PortfolioTest methodsFor: '01 - 04 | balance tests' stamp: 'jc 6/7/2022 20:19:43'!
test01APortfolioWithNoAccountsHasABalanceOfZero

	self assert: (portfolio balance isEqualTo: 0 * peso)

	! !

!PortfolioTest methodsFor: '01 - 04 | balance tests' stamp: 'GF 6/8/2022 23:04:17'!
test02APortfolioWithOneAccountHasTheSameBalanceAsSaidAccount

	Deposit register: 10 * peso on: firstAccountToBeRegistered.
	
	portfolio addAccount: firstAccountToBeRegistered.

	self assert: (portfolio balance isEqualTo: 10 * peso)

	! !

!PortfolioTest methodsFor: '01 - 04 | balance tests' stamp: 'GF 6/8/2022 23:04:24'!
test03APortfolioWithTwoAccountsHasTheSameBalanceAsTheSumOfTheBalancesOfSaidAccounts

	Deposit register: 10 * peso on: firstAccountToBeRegistered.
	Deposit register: 90 * peso on: secondAccountToBeRegistered.
	
	portfolio addAccount: firstAccountToBeRegistered.
	portfolio addAccount: secondAccountToBeRegistered.

	self assert: (portfolio balance isEqualTo: 100 * peso)

	! !

!PortfolioTest methodsFor: '01 - 04 | balance tests' stamp: 'GF 6/8/2022 23:04:28'!
test04APortfolioWithAnAccountAndAPortfolioHasTheSameBalanceAsTheSumOfTheBalancesOfSaidAccountAndPortfolio

	Deposit register: 100 * peso on: firstAccountToBeRegistered.
	Deposit register: 90 * peso on: secondAccountToBeRegistered.
	
	portfolio addAccount: firstAccountToBeRegistered.
	portfolioToBeRegistered addAccount: secondAccountToBeRegistered.
	portfolio addAccount: portfolioToBeRegistered.

	self assert: (portfolio balance isEqualTo: 190 * peso)

	! !


!PortfolioTest methodsFor: '05 - 09 | registration tests' stamp: 'GF 6/8/2022 21:44:47'!
test05APortfolioWithNoAccountsHasNotRegisteredAnyTransactions

	self deny: (portfolio hasRegistered: (Deposit register: 100 * peso on: firstAccountToBeRegistered))
	! !

!PortfolioTest methodsFor: '05 - 09 | registration tests' stamp: 'GF 6/8/2022 23:04:42'!
test06APortfolioWithOneAccountHasRegisteredTheTransactionsMadeBySaidAccount

	| aDeposit |
	
	aDeposit _ Deposit register: 100 * peso on: firstAccountToBeRegistered.
	
	portfolio addAccount: firstAccountToBeRegistered.
	
	self assert: (portfolio hasRegistered: aDeposit)
	! !

!PortfolioTest methodsFor: '05 - 09 | registration tests' stamp: 'GF 6/8/2022 23:04:46'!
test07APortfolioWithOneAccountWithNoTransactionsMadeHasNotRegisteredAnyTransactions

	portfolio addAccount: firstAccountToBeRegistered.
	
	self deny: (portfolio hasRegistered: (Withdraw register: 10 * peso on: secondAccountToBeRegistered))
	! !

!PortfolioTest methodsFor: '05 - 09 | registration tests' stamp: 'GF 6/8/2022 23:04:49'!
test08APortfolioWithTwoAccountsHasRegisteredTheTransactionsMadeBySaidAccounts

	| aWithdraw |
	
	aWithdraw _ Withdraw register: 10 * peso on: secondAccountToBeRegistered.
	
	portfolio addAccount: firstAccountToBeRegistered.
	portfolio addAccount: secondAccountToBeRegistered.
	
	self assert: (portfolio hasRegistered: aWithdraw) 
	! !

!PortfolioTest methodsFor: '05 - 09 | registration tests' stamp: 'GF 6/8/2022 23:04:54'!
test09APortfolioWithAnAccountAndAPortfolioHasRegisteredTheSameTransactionsAsSaidAccountAndTransaction

	| aWithdraw |
	
	aWithdraw _ Withdraw register: 10 * peso on: secondAccountToBeRegistered.
	
	portfolio addAccount: firstAccountToBeRegistered.
	portfolioToBeRegistered addAccount: secondAccountToBeRegistered.
	portfolio addAccount: portfolioToBeRegistered.
	
	self assert: (portfolio hasRegistered: aWithdraw) 
	! !


!PortfolioTest methodsFor: '10 - 13 | transaction tests' stamp: 'GF 6/8/2022 15:26:02'!
test10APortfolioWithNoAccountsHasMadeNoTransactions

	self assert: (portfolio transactions	 isEqualTo: OrderedCollection new)! !

!PortfolioTest methodsFor: '10 - 13 | transaction tests' stamp: 'GF 6/8/2022 23:05:01'!
test11APortfolioWithOneAccountHasMadeTheSameTransactionsAsSaidAccount
	
	Deposit register: 100 * peso on: firstAccountToBeRegistered.
	
	portfolio addAccount: firstAccountToBeRegistered.
	
	self assert: (portfolio transactions	 isEqualTo: firstAccountToBeRegistered transactions)! !

!PortfolioTest methodsFor: '10 - 13 | transaction tests' stamp: 'GF 6/8/2022 23:05:04'!
test12APortfolioWithTwoAccountsHasMadeTheSameTransactionsAsSaidAccounts

	| transactions | 

	transactions _ OrderedCollection new.
	transactions add: (Deposit register: 100 * peso on: firstAccountToBeRegistered).
	transactions add: (Withdraw register: 120 * peso on: secondAccountToBeRegistered).
	
	portfolio addAccount: firstAccountToBeRegistered.
	portfolio addAccount: secondAccountToBeRegistered.	
	
	self assert: (portfolio transactions	 isEqualTo: transactions)! !

!PortfolioTest methodsFor: '10 - 13 | transaction tests' stamp: 'GF 6/8/2022 23:05:09'!
test13APortfolioWithAnAccountAndAPortfolioHasMadeTheSameTransactionsAsSaidAccountAndPortfolio

	| transactions | 

	transactions _ OrderedCollection new.
	transactions add: (Deposit register: 100 * peso on: firstAccountToBeRegistered).
	transactions add: (Withdraw register: 120 * peso on: secondAccountToBeRegistered).
	
	portfolio addAccount: firstAccountToBeRegistered.
	portfolioToBeRegistered addAccount: secondAccountToBeRegistered.	
	portfolio addAccount: portfolioToBeRegistered .
	
	self assert: (portfolio transactions	 isEqualTo: transactions)! !


!PortfolioTest methodsFor: '14 - 18 | extras' stamp: 'GF 6/8/2022 23:05:13'!
test14APortfolioCanNotRegisterItself

	self
		should: [ portfolio addAccount: portfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | anError messageText isEqualTo: Portfolio aPortfolioCanNotRegisterItselfErrorDescription ]! !

!PortfolioTest methodsFor: '14 - 18 | extras' stamp: 'GF 6/8/2022 23:05:17'!
test15APortfolioCanNotRegisterTheSameAccountTwice

	portfolio addAccount: firstAccountToBeRegistered.

	self
		should: [ portfolio addAccount: firstAccountToBeRegistered ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | anError messageText isEqualTo: Portfolio aPortfolioCanNotRegisterTheSameAccountTwiceErrorDescription ]! !

!PortfolioTest methodsFor: '14 - 18 | extras' stamp: 'GF 6/8/2022 23:05:21'!
test16APortfolioCanNotRegisterAnAccountManagedByOneOfItsPortfolios

	portfolioToBeRegistered addAccount: firstAccountToBeRegistered.
	portfolio addAccount: portfolioToBeRegistered.
	
	self
		should: [ portfolio addAccount: firstAccountToBeRegistered ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | anError messageText isEqualTo: Portfolio aPortfolioCanNotRegisterTheSameAccountTwiceErrorDescription ]! !

!PortfolioTest methodsFor: '14 - 18 | extras' stamp: 'GF 6/8/2022 23:05:25'!
test17APortfolioCanNotRegisterAnAccountManagedByItsParentPortfolio

	portfolio addAccount: portfolioToBeRegistered.
	portfolio addAccount: firstAccountToBeRegistered.
	
	self
		should: [ portfolioToBeRegistered addAccount: firstAccountToBeRegistered ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | anError messageText isEqualTo: Portfolio aPortfolioCanNotRegisterTheSameAccountTwiceErrorDescription ]! !

!PortfolioTest methodsFor: '14 - 18 | extras' stamp: 'GF 6/8/2022 23:05:28'!
test18APortfolioCanNotRegisterAPortfolioThatManagesTheSameAccountAsItself

	portfolioToBeRegistered addAccount: firstAccountToBeRegistered.
	portfolio addAccount: firstAccountToBeRegistered.
	
	self
		should: [ portfolio addAccount: portfolioToBeRegistered ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | anError messageText isEqualTo: Portfolio aPortfolioCanNotRegisterTheSameAccountTwiceErrorDescription ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'account sourceAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'initializing' stamp: 'GF 6/4/2022 17:50:58'!
setUp

	account _ ReceptiveAccount new.
	sourceAccount _ ReceptiveAccount new! !


!classDefinition: #DepositAndWithdrawTest category: 'ServiciosFinancieros-Ejercicio'!
ReceptiveAccountTest subclass: #DepositAndWithdrawTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DepositAndWithdrawTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:45:51'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: account balance
! !

!DepositAndWithdrawTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:45:58'!
test02DepositIncreasesBalanceOnTransactionValue 

	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance! !

!DepositAndWithdrawTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:46:05'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!DepositAndWithdrawTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:46:12'!
test04WithdrawValueMustBePositive 

	| withdrawValue |
	
	withdrawValue  _ 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!DepositAndWithdrawTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:46:19'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| deposit withdraw |
	
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!DepositAndWithdrawTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:46:25'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw |
	
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!DepositAndWithdrawTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:46:37'!
test07AccountKnowsItsTransactions 

	| deposit |
		
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit)! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
ReceptiveAccountTest subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:47:29'!
test01ReceivingATransferIncreasesBalanceOnDestinationAccount

	Transfer register: 100 * peso on: account from: sourceAccount.
	
	self assert: (account balance isEqualTo: 100 * peso)
! !

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:47:59'!
test02ReceivingABiggerTransferFurtherIncreasesBalanceOnDestinationAccount
	
	Transfer register: 250 * peso on: account from: sourceAccount.
	
	self assert: (account balance isEqualTo: 250 * peso)
! !

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:48:24'!
test03SendingATransferDecreasesBalanceOnSourceAccount
	
	Deposit register: 200 * peso on: sourceAccount.
	
	Transfer register: 70 * peso on: account from: sourceAccount.
	
	self assert: (sourceAccount balance isEqualTo: 130 * peso)
! !

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:48:37'!
test04SendingABiggerTransferFurtherDecreasesBalanceOnSourceAccount
	
	Deposit register: 250 * peso on: sourceAccount.
	
	Transfer register: 100 * peso on: account from: sourceAccount.
	
	self assert: (sourceAccount balance isEqualTo: 150 * peso)! !

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:48:57'!
test05ATransferValueMustBePositive

	| transferValue |
	
	transferValue  _ 100 * peso.
	
	self assert: ((Transfer register: transferValue on: account from: sourceAccount) effectOnBalanceIs: transferValue)! !

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:49:07'!
test06ATransferValueIsTheAmountOfMoneyThatWasTransfered

	| transferValue |
	
	transferValue  _ 150 * peso.
	
	self assert: ((Transfer register: transferValue on: account from: sourceAccount) effectOnBalanceIs: transferValue)! !

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:49:19'!
test07ATransferDepositCounterpartIsATransferWithdrawal

	| aTransfer |
	
	aTransfer _ Transfer register: 100 * peso on: account from: sourceAccount.
	
	 self assert: (aTransfer deposit counterpart isEqualTo: aTransfer withdrawal)! !

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:50:00'!
test08ATransferWithdrawalCounterpartIsATransferDeposit

	| aTransfer |
	
	aTransfer _ Transfer register: 100 * peso on: account from: sourceAccount.
	
	 self assert: (aTransfer withdrawal counterpart isEqualTo: aTransfer deposit)! !

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:51:34'!
test09ATransferDepositSourceTransferIsTheOneWithSaidDepositAsLeg

	| aTransfer |
	
	aTransfer _ Transfer register: 100 * peso on: account from: sourceAccount.
	
	 self assert: (aTransfer deposit sourceTransaction isEqualTo: aTransfer)! !

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:51:56'!
test10ATransferWithdrawSourceTransferIsTheOneWithSaidDepositAsLeg

	| aTransfer |
	
	aTransfer _ Transfer register: 100 * peso on: account from: sourceAccount.
	
	 self assert: (aTransfer withdrawal sourceTransaction isEqualTo: aTransfer)
	! !

!TransferTest methodsFor: 'tests' stamp: 'GF 6/8/2022 20:51:38'!
test11CanNotTransferNoMoney

	self should: [ Transfer register: 0 * peso on: account from: sourceAccount ]
	       raise: Error - MessageNotUnderstood 
	       withExceptionDo: [ :anError | self assert: Transfer canNotTransferNoMoneyErrorDescription equals: anError messageText ]
! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'GF 6/4/2022 16:43:23'!
value 

	^value! !


!AccountTransaction methodsFor: 'initializing' stamp: 'GF 6/4/2022 16:43:40'!
initializeFor: aValue

	value _ aValue ! !


!AccountTransaction methodsFor: 'value - private' stamp: 'jc 6/9/2022 14:28:56'!
transactionValue

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'GF 6/4/2022 17:41:46'!
for: aValue

	^self new initializeFor: aValue! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'GF 6/8/2022 20:12:22'!
register: aValue on: account

	| transaction |
	
	transaction _ self for: aValue.
	account register: transaction.
		
	^transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'value - private' stamp: 'GF 6/4/2022 18:20:19'!
transactionValue

	^self value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'value - private' stamp: 'GF 6/4/2022 18:20:19'!
transactionValue

	^self value negated! !


!classDefinition: #BankAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #BankAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!BankAccount methodsFor: 'main protocol' stamp: 'GF 6/8/2022 15:30:45'!
balance

	self subclassResponsibility ! !

!BankAccount methodsFor: 'main protocol' stamp: 'GF 6/8/2022 15:31:20'!
hasRegistered: aTransactionThatMayHaveBeenMade

	self subclassResponsibility ! !

!BankAccount methodsFor: 'main protocol' stamp: 'GF 6/8/2022 15:32:02'!
transactions

	self subclassResponsibility ! !


!BankAccount methodsFor: 'adding - private' stamp: 'GF 6/8/2022 20:21:42'!
isAddedTo: aRegisteringPortfolio

	self subclassResponsibility ! !


!BankAccount methodsFor: 'initializing' stamp: 'GF 6/8/2022 15:31:30'!
initialize

	self subclassResponsibility ! !


!BankAccount methodsFor: 'accessing - private' stamp: 'GF 6/8/2022 20:35:32'!
includes: anAccountThatMayHaveBeenRegistered

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
BankAccount subclass: #Portfolio
	instanceVariableNames: 'accounts parentAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initializing' stamp: 'GF 6/8/2022 22:12:24'!
initialize 

	accounts _ OrderedCollection new.
	parentAccount _ OrderedCollection new
	! !


!Portfolio methodsFor: 'main protocol' stamp: 'GF 6/8/2022 23:05:48'!
addAccount: anAccountToBeRegistered

	(self isEqualTo: anAccountToBeRegistered) ifTrue: [ ^self error: self class aPortfolioCanNotRegisterItselfErrorDescription ].

	self verifyRegistrationOf: anAccountToBeRegistered.
	
	anAccountToBeRegistered isAddedTo: self
	
	! !

!Portfolio methodsFor: 'main protocol' stamp: 'GF 6/8/2022 20:40:33'!
balance
	
	^accounts sum: [ :eachAccount | eachAccount balance ] ifEmpty: [ ^0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'GF 6/8/2022 19:45:29'!
hasRegistered: aTransactionThatMayHaveBeenMade 
	
	^accounts anySatisfy: [ :eachAccount | eachAccount hasRegistered: aTransactionThatMayHaveBeenMade ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'GF 6/8/2022 20:40:58'!
transactions

	| transactionsMadeByPortfolio |
	
	transactionsMadeByPortfolio _ OrderedCollection new.
	
	accounts do: [ :eachAccount | transactionsMadeByPortfolio addAll: eachAccount transactions ].
	
	^transactionsMadeByPortfolio
	! !


!Portfolio methodsFor: 'accessing - private' stamp: 'GF 6/8/2022 20:02:35'!
includes: anAccountThatMayHaveBeenRegistered

	^accounts anySatisfy: [ :eachAccount | (eachAccount includes: anAccountThatMayHaveBeenRegistered) or: [ anAccountThatMayHaveBeenRegistered includes: eachAccount ] ]! !

!Portfolio methodsFor: 'accessing - private' stamp: 'GF 6/8/2022 23:08:28'!
verifyRegistrationOf: anAccountToBeRegistered
			
	parentAccount do: [ :eachAccount | eachAccount verifyRegistrationOf: anAccountToBeRegistered ].
	
	(self includes: anAccountToBeRegistered) ifTrue: [ ^self error: self class aPortfolioCanNotRegisterTheSameAccountTwiceErrorDescription ].! !


!Portfolio methodsFor: 'adding - private' stamp: 'GF 6/8/2022 20:22:19'!
add: anAccountToBeRegistered

	accounts add: anAccountToBeRegistered! !

!Portfolio methodsFor: 'adding - private' stamp: 'GF 6/8/2022 22:15:36'!
addParent: aRegisteringPortfolio

	parentAccount add: aRegisteringPortfolio! !

!Portfolio methodsFor: 'adding - private' stamp: 'GF 6/8/2022 22:15:47'!
isAddedTo: aRegisteringPortfolio

	self addParent: aRegisteringPortfolio.	
	
	aRegisteringPortfolio add: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'GF 6/8/2022 18:08:50'!
aPortfolioCanNotRegisterItselfErrorDescription

	^ 'A portfolio can not register itself'! !

!Portfolio class methodsFor: 'error' stamp: 'GF 6/8/2022 18:13:36'!
aPortfolioCanNotRegisterTheSameAccountTwiceErrorDescription

	^ 'A portfolio can not register the same account twice'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
BankAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initializing' stamp: 'GF 6/8/2022 20:54:02'!
initialize

	transactions _ OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'GF 6/4/2022 18:20:20'!
balance

	^transactions sum: [ :aTransaction | aTransaction transactionValue ] ifEmpty: [ 0 ]
	
	! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'GF 6/8/2022 15:10:06'!
hasRegistered: aTransactionThatMayHaveBeenMade

	^transactions includes: aTransactionThatMayHaveBeenMade 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'GF 6/4/2022 17:05:17'!
transactions 

	^transactions copy! !


!ReceptiveAccount methodsFor: 'accessing - private' stamp: 'GF 6/8/2022 20:35:20'!
includes: anAccountThatMayHaveBeenRegistered

	^self isEqualTo: anAccountThatMayHaveBeenRegistered! !


!ReceptiveAccount methodsFor: 'adding - private' stamp: 'GF 6/8/2022 20:21:08'!
isAddedTo: aRegisteringPortfolio

	aRegisteringPortfolio add: self! !

!ReceptiveAccount methodsFor: 'adding - private' stamp: 'GF 6/8/2022 20:34:12'!
register: aTransactionToBeRegistered

	transactions add: aTransactionToBeRegistered 
! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawalLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'legs' stamp: 'GMF 6/6/2022 21:29:01'!
deposit
	
	^depositLeg ! !

!Transfer methodsFor: 'legs' stamp: 'GMF 6/6/2022 21:32:38'!
withdrawal
	
	^withdrawalLeg ! !


!Transfer methodsFor: 'comparing' stamp: 'GMF 6/6/2022 20:11:17'!
effectOnBalanceIs: anAmountOfMoneyToBeValidated 
	
	^self value isEqualTo: anAmountOfMoneyToBeValidated ! !


!Transfer methodsFor: 'initializing' stamp: 'GMF 6/6/2022 21:26:38'!
initializeWith: anAmountOfMoney andSetDepositLeg: aTransferDeposit andWithdrawLeg: aTransferWithdraw

	value _ anAmountOfMoney.
	depositLeg _ aTransferDeposit.
	withdrawalLeg _ aTransferWithdraw! !


!Transfer methodsFor: 'value' stamp: 'jc 6/5/2022 22:17:59'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error' stamp: 'jc 6/5/2022 21:55:47'!
canNotTransferNoMoneyErrorDescription

	^' Can not transfer no money '! !

!Transfer class methodsFor: 'error' stamp: 'GF 6/8/2022 23:44:45'!
verifyAnAmountOfMoneyIsNotZero: anAmountOfMoneyToVerify

	(anAmountOfMoneyToVerify value isEqualTo: 0) ifTrue: [ ^self error: self canNotTransferNoMoneyErrorDescription ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'GF 6/8/2022 23:45:00'!
register: anAmountOfMoney on: aDestinationAccount from: aSourceAccount
	
	| aTransfer aTransferDeposit aTransferWithdraw |
	
	self verifyAnAmountOfMoneyIsNotZero: anAmountOfMoney.
	
	aTransferDeposit _ TransferDeposit registerATransferTransactionOn: aDestinationAccount.
	aTransferWithdraw _ TransferWithdraw registerATransferTransactionOn: aSourceAccount.
	
	aTransfer _ self new initializeWith: anAmountOfMoney andSetDepositLeg: aTransferDeposit andWithdrawLeg: aTransferWithdraw.
	
	aTransferDeposit setSourceTransfer: aTransfer andCounterpart: aTransferWithdraw.
	aTransferWithdraw setSourceTransfer: aTransfer andCounterpart: aTransferDeposit.
	
	^aTransfer! !


!classDefinition: #TransferTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferTransaction
	instanceVariableNames: 'sourceTransfer counterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTransaction methodsFor: 'value' stamp: 'GMF 6/6/2022 21:01:15'!
transactionValue

	self subclassResponsibility ! !


!TransferTransaction methodsFor: 'accessing' stamp: 'GMF 6/6/2022 21:29:31'!
counterpart

	^counterpart! !

!TransferTransaction methodsFor: 'accessing' stamp: 'GMF 6/6/2022 21:08:12'!
sourceTransaction

	^sourceTransfer ! !


!TransferTransaction methodsFor: 'initializing' stamp: 'GMF 6/6/2022 21:32:07'!
setSourceTransfer: aSourceTransfer andCounterpart: aTransferTransactionOppositeToSelf

	sourceTransfer _ aSourceTransfer.
	counterpart _ aTransferTransactionOppositeToSelf! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'GF 6/8/2022 20:14:11'!
registerATransferTransactionOn: anAccount

	| aTransferTransaction |
	
	aTransferTransaction _ self new.
	anAccount register: aTransferTransaction.
		
	^aTransferTransaction
	! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'value' stamp: 'GMF 6/6/2022 21:00:45'!
transactionValue

	^self sourceTransaction value! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'value' stamp: 'GMF 6/6/2022 21:01:05'!
transactionValue

	^self sourceTransaction value negated! !
