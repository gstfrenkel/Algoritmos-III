!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 11/29/2021 18:55:37'!
test12PortfolioCanNotIncludeItself

	| simplePortfolio |
	
	simplePortfolio := Portfolio new.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 0 equals: simplePortfolio accountsSize. ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #ReportTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'expectedReport account portfolio accountSummary netTransfer tree secondPortfolio detailedTree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportTest methodsFor: 'initialization' stamp: 'jc 6/16/2022 16:25:39'!
setUp
	
	accountSummary _ AccountSummary new.
	netTransfer _ NetTransfer new.
	expectedReport _ OrderedCollection new.
	account _ ReceptiveAccount named: 'Account of Dorrego'.
	portfolio _ Portfolio named: 'Portfolio of San Martin'.
	secondPortfolio _ Portfolio named: 'Portfolio of Ceratti'.
	tree _ PortfolioTree new.
	detailedTree _ PortfolioDetailedTree new	
	! !


!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Solucion'!
ReportTest subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:49'!
test01TheReportOfAnEmptyReceptiveAccountHasRegisteredABalanceOfZero

	expectedReport add: 'Balance = 0 pesos'.

	self assert: ((accountSummary reportOf: account) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:49'!
test02TheReportOfAReceptiveWithADepositHasRegisteredSaidTransaction

	Deposit register: 100 * peso on: account.
	expectedReport add: 'Deposit for 100 pesos'.
	expectedReport add: 'Balance = 100 pesos'.

	self assert: ((accountSummary reportOf: account) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:48'!
test03TheReportOfAReceptiveAccountWithABiggerDepositHasRegisteredSaidTransaction

	Deposit register: 150 * peso on: account.
	expectedReport add: 'Deposit for 150 pesos'.
	expectedReport add: 'Balance = 150 pesos'.

	self assert: ((accountSummary reportOf: account) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:49'!
test04TheReportOfAReceptiveAccountWithADepositAndWithdrawHasRegisteredSaidTransactinos

	Deposit register: 200 * peso on: account.
	Withdraw register: 20 * peso on: account.
	expectedReport add: 'Deposit for 200 pesos'.
	expectedReport add: 'Withdraw for 20 pesos'.
	expectedReport add: 'Balance = 180 pesos'.

	self assert: ((accountSummary reportOf: account) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:48'!
test05TheReportOfAReceptiveAccountWithATransferDepositHasRegisteredSaidTransaction

	Transfer amount: 200 * peso from: ReceptiveAccount new to: account.
	expectedReport add: 'Transfer deposit for 200 pesos'.
	expectedReport add: 'Balance = 200 pesos'.

	self assert: ((accountSummary reportOf: account) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:48'!
test06TheReportOfAReceptiveAccountWithADepositAndTransferWithdrawHasRegisteredSaidTransactions

	Deposit register: 800 * peso on: account.
	Transfer amount: 200 * peso from: account to: ReceptiveAccount new.
	expectedReport add: 'Deposit for 800 pesos'.
	expectedReport add: 'Transfer withdraw for 200 pesos'.
	expectedReport add: 'Balance = 600 pesos'.

	self assert: ((accountSummary reportOf: account) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:48'!
test07MakingTheReportOfAReceptiveAccountTwiceRegistersItsTransactionOnce

	Deposit register: 800 * peso on: account.
	
	expectedReport add: 'Deposit for 800 pesos'.
	expectedReport add: 'Balance = 800 pesos'.
	
	accountSummary reportOf: account.

	self assert: ((accountSummary reportOf: account) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:49'!
test08TheReportOfAnEmptyPortfolioHasRegisteredABalanceOfZero

	expectedReport add: 'Balance = 0 pesos'.

	self assert: ((accountSummary reportOf: portfolio) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:48'!
test09TheReportOfAPortfolioWithADepositHasRegisteredSaidTransaction

	Deposit register: 100 * peso on: account.
	portfolio add: account.
	expectedReport add: 'Deposit for 100 pesos'.
	expectedReport add: 'Balance = 100 pesos'.

	self assert: ((accountSummary reportOf: portfolio) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:49'!
test10TheReportOfAPortfolioWithABiggerDepositHasRegisteredSaidTransaction

	Deposit register: 150 * peso on: account.
	portfolio add: account.
	expectedReport add: 'Deposit for 150 pesos'.
	expectedReport add: 'Balance = 150 pesos'.

	self assert: ((accountSummary reportOf: portfolio) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:48'!
test11TheReportOfAPortfolioWithADepositAndWithdrawHasRegisteredSaidTransactinos

	Deposit register: 200 * peso on: account.
	Withdraw register: 20 * peso on: account.
	portfolio add: account.
	expectedReport add: 'Deposit for 200 pesos'.
	expectedReport add: 'Withdraw for 20 pesos'.
	expectedReport add: 'Balance = 180 pesos'.

	self assert: ((accountSummary reportOf: portfolio) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:48'!
test12TheReportOfAPortofolioWithADepositAndBothLegsOfATransferHasRegisteredSaidTransactions

	| newPortfolio newAccount |

	newAccount _ ReceptiveAccount new.
	Deposit register: 200 * peso on: account.
	Transfer amount: 160 * peso from: account to: newAccount.
	newPortfolio _ Portfolio with: account.
	
	portfolio add: newPortfolio.
	portfolio add: newAccount.
	
	expectedReport add: 'Deposit for 200 pesos'.
	expectedReport add: 'Transfer withdraw for 160 pesos'.
	expectedReport add: 'Transfer deposit for 160 pesos'.
	expectedReport add: 'Balance = 200 pesos'.

	self assert: ((accountSummary reportOf: portfolio) isEqualTo: expectedReport)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:49'!
test13MakingTheReportOfAPortfolioTwiceRegistersItsTransactionOnce

	Deposit register: 800 * peso on: account.
	
	expectedReport add: 'Deposit for 800 pesos'.
	expectedReport add: 'Balance = 800 pesos'.
	
	portfolio add: account.
	accountSummary reportOf: portfolio.	

	self assert: ((accountSummary reportOf: portfolio) isEqualTo: expectedReport)! !


!classDefinition: #NetTransferTest category: 'ServiciosFinancieros-Solucion'!
ReportTest subclass: #NetTransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test01NetTransferOfAnEmptyReceptiveAccountHasRegisteredABalanceOfZero

	self assert: ((netTransfer reportOf: account) isEqualTo: 0 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test02NetTransferOfAReceptiveAccountWithATransferDepositHasRegisteredABalanceOfAnAmountOfPesos

	Transfer amount: 100 * peso from: ReceptiveAccount new to: account.

	self assert: ((netTransfer reportOf: account) isEqualTo: 100 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test03NetTransferOfAReceptiveAccountWithABiggerTransferDepositHasRegisteredABalanceOfAnAmountOfPesos

	Transfer amount: 150 * peso from: ReceptiveAccount new to: account.

	self assert: ((netTransfer reportOf: account) isEqualTo: 150 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test04NetTransferOfAReceptiveAccountWithTwoTransferDepositHasRegisteredABalanceOfAnAmountOfPesos

	Transfer amount: 150 * peso from: ReceptiveAccount new to: account.
	Transfer amount: 20 * peso from: ReceptiveAccount new to: account.

	self assert: ((netTransfer reportOf: account) isEqualTo: 170 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test05NetTransferOfAReceptiveAccountWithADepositHasRegisteredABalanceOfZero

	Deposit register: 100 * peso on: account.

	self assert: ((netTransfer reportOf: account) isEqualTo: 0 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test06NetTransferOfAReceptiveAccountWithAWithdrawHasRegisteredABalanceOfZero

	Withdraw register: 100 * peso on: account.

	self assert: ((netTransfer reportOf: account) isEqualTo: 0 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test07NetTransferOfAReceptiveAccountWithManyTransfersHasRegisteredABalanceOfAnAmountOfPesos

	Transfer amount: 100 * peso from: ReceptiveAccount new to: account.
	Transfer amount: 60 * peso from: account to: ReceptiveAccount new.
	Transfer amount: 80 * peso from: ReceptiveAccount new to: account.
	Transfer amount: 110 * peso from: account to: ReceptiveAccount new.
	Transfer amount: 30 * peso from: ReceptiveAccount new to: account.
	Transfer amount: 20 * peso from: account to: ReceptiveAccount new.

	self assert: ((netTransfer reportOf: account) isEqualTo: 20 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test08MakingNetTransferOfAReceptiveAccountTwiceRegistersItsNetTransferOnce

	Transfer amount: 800 * peso from: ReceptiveAccount new to: account.
	
	netTransfer reportOf: account.

	self assert: ((netTransfer reportOf: account) isEqualTo: 800 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test09NetTransferOfAnEmptyPortfolioHasRegisteredABalanceOfZero

	self assert: ((netTransfer reportOf: portfolio) isEqualTo: 0 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test10NetTransferOfAPortfolioWithATransferDepositHasRegisteredABalanceOfAnAmountOfPesos

	Transfer amount: 100 * peso from: ReceptiveAccount new to: account.
	
	portfolio add: account.

	self assert: ((netTransfer reportOf: portfolio) isEqualTo: 100 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test11NetTransferOfAPortfolioWithABiggerTransferDepositHasRegisteredABalanceOfAnAmountOfPesos

	Transfer amount: 150 * peso from: ReceptiveAccount new to: account.
	
	portfolio add: account.

	self assert: ((netTransfer reportOf: portfolio) isEqualTo: 150 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test12NetTransferOfAPortfolioWithTwoTransferDepositHasRegisteredABalanceOfAnAmountOfPesos

	Transfer amount: 150 * peso from: ReceptiveAccount new to: account.
	Transfer amount: 20 * peso from: ReceptiveAccount new to: account.
	
	portfolio add: account.

	self assert: ((netTransfer reportOf: portfolio) isEqualTo: 170 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test13NetTransferOfAPortfolioWithADepositHasRegisteredABalanceOfZero

	Deposit register: 100 * peso on: account.
	
	portfolio add: account.

	self assert: ((netTransfer reportOf: portfolio) isEqualTo: 0 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test14NetTransferOfAPortfolioWithAWithdrawHasRegisteredABalanceOfZero

	Withdraw register: 100 * peso on: account.
	
	portfolio add: account.

	self assert: ((netTransfer reportOf: portfolio) isEqualTo: 0 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test15NetTransferOfAPortfolioWithManyTransfersHasRegisteredABalanceOfAnAmountOfPesos

	Transfer amount: 100 * peso from: ReceptiveAccount new to: account.
	Transfer amount: 60 * peso from: account to: ReceptiveAccount new.
	Transfer amount: 80 * peso from: ReceptiveAccount new to: account.
	Transfer amount: 110 * peso from: account to: ReceptiveAccount new.
	Transfer amount: 30 * peso from: ReceptiveAccount new to: account.
	Transfer amount: 20 * peso from: account to: ReceptiveAccount new.
	
	portfolio add: account.

	self assert: ((netTransfer reportOf: portfolio) isEqualTo: 20 * peso)! !

!NetTransferTest methodsFor: 'tests' stamp: 'jc 6/16/2022 13:26:40'!
test16MakingNetTransferOfAPortfolioTwiceRegistersItsNetTransferOnce

	Transfer amount: 800 * peso from: ReceptiveAccount new to: account.
	
	portfolio add: account.
	
	netTransfer reportOf: portfolio.

	self assert: ((netTransfer reportOf: portfolio) isEqualTo: 800 * peso)! !


!classDefinition: #PortfolioDetailedTreeTest category: 'ServiciosFinancieros-Solucion'!
ReportTest subclass: #PortfolioDetailedTreeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:14:12'!
test01DetailedTreeReportOfAnEmptyPortfolioRegistersABalanceOfZero

	expectedReport add: 'Portfolio of San Martin'.
	expectedReport add: '    Balance = 0 pesos'.
	
	self assert: ((detailedTree reportOf: portfolio) isEqualTo: expectedReport)! !

!PortfolioDetailedTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:14:41'!
test02DetailedTreeReportOfAnotherEmptyPortfolioRegistersABalanceOfZero

	expectedReport add: 'Portfolio of Ceratti'.
	expectedReport add: '    Balance = 0 pesos'.
	
	self assert: ((detailedTree reportOf: secondPortfolio) isEqualTo: expectedReport)! !

!PortfolioDetailedTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:17:03'!
test03DetailedTreeReportOfAPortfolioWithOneEmptyAccountRegistersABalanceOfZero

	expectedReport add: 'Portfolio of San Martin'.
	expectedReport add: '    Account of Dorrego'.
	expectedReport add: '        Balance = 0 pesos'.
	expectedReport add: '    Balance = 0 pesos'.
	
	portfolio add: account.
	
	self assert: ((detailedTree reportOf: portfolio) isEqualTo: expectedReport)! !

!PortfolioDetailedTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:16:15'!
test04DetailedTreeReportOfAPortfolioWithOneAccountRegistersItsTransactionsAndBalance

	expectedReport add: 'Portfolio of San Martin'.
	expectedReport add: '    Account of Dorrego'.
	expectedReport add: '        Deposit for 100 pesos'.
	expectedReport add: '        Balance = 100 pesos'.
	expectedReport add: '    Balance = 100 pesos'.
	
	Deposit register: 100 * peso on: account.
	
	portfolio add: account.

	self assert: ((detailedTree reportOf: portfolio) isEqualTo: expectedReport)! !

!PortfolioDetailedTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:17:37'!
test05MakingADetailedTreeReportOfAPortfolioTwiceRegistersItsTransactionsAndBalancesOnce

	expectedReport add: 'Portfolio of San Martin'.
	expectedReport add: '    Account of Dorrego'.
	expectedReport add: '        Deposit for 100 pesos'.
	expectedReport add: '        Balance = 100 pesos'.
	expectedReport add: '    Balance = 100 pesos'.
	
	Deposit register: 100 * peso on: account.
	
	portfolio add: account.
	
	detailedTree reportOf: portfolio.
	
	self assert: ((detailedTree reportOf: portfolio) isEqualTo: expectedReport)! !


!classDefinition: #PortfolioTreeTest category: 'ServiciosFinancieros-Solucion'!
ReportTest subclass: #PortfolioTreeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:18:52'!
test01TreeReportOfAnEmptyPortfolioRegistersItsName

	expectedReport add: 'Portfolio of San Martin'.

	self assert: ((tree reportOf: portfolio) isEqualTo: expectedReport)! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:19:23'!
test02TreeReportOfAnotherEmptyPortfolioRegistersItsName

	expectedReport add: 'Portfolio of Ceratti'.

	self assert: ((tree reportOf: secondPortfolio) isEqualTo: expectedReport)! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:20:02'!
test03TreeReportOfAPortfolioWithOneAccountRegistersBothNames

	expectedReport add: 'Portfolio of San Martin'.
	expectedReport add: '    Account of Dorrego'.
	
	portfolio add: (ReceptiveAccount named: 'Account of Dorrego').

	self assert: ((tree reportOf: portfolio) isEqualTo: expectedReport)! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:20:43'!
test04TreeReportOfAPortfolioWithAnotherAccountRegistersBothNames

	expectedReport add: 'Portfolio of San Martin'.
	expectedReport add: '    Account of Lavalle'.
	
	portfolio add: (ReceptiveAccount named: 'Account of Lavalle').

	self assert: ((tree reportOf: portfolio) isEqualTo: expectedReport)! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:20:59'!
test05TreeReportOfAPortfolioWithOnePortfolioRegistersBothNames

	expectedReport add: 'Portfolio of San Martin'.
	expectedReport add: '    Portfolio of Ceratti'.
	
	portfolio add: secondPortfolio.

	self assert: ((tree reportOf: portfolio) isEqualTo: expectedReport)! !

!PortfolioTreeTest methodsFor: 'tests' stamp: 'jc 6/16/2022 18:21:18'!
test06TreeReportOfAPortfolioWithManyAccountsRegistersAllNames

	expectedReport add: 'Portfolio of San Martin'.
	expectedReport add: '    Portfolio of Ceratti'.
	expectedReport add: '        Account of Dorrego'.
	
	secondPortfolio add: account.
	portfolio add: secondPortfolio.
	
	tree reportOf: portfolio.

	self assert: ((tree reportOf: portfolio) isEqualTo: expectedReport)! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'private' stamp: 'GF 6/14/2022 23:27:58'!
balanceReportFor: anAccountSummary

	^anAccountSummary balanceReportFor: self! !

!Account methodsFor: 'private' stamp: 'jc 6/16/2022 15:29:02'!
name

	^name! !

!Account methodsFor: 'private' stamp: 'jc 6/16/2022 14:52:43'!
visitTransactionsFor: aReportToBeMade

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instancing' stamp: 'jc 6/16/2022 18:07:29'!
named: anAccountName

	^self new named: anAccountName ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'jc 6/16/2022 15:05:36'!
initialize

	accounts _ OrderedCollection new.
	parents _ OrderedCollection new.
	name _ 'NN'! !

!Portfolio methodsFor: 'initialization' stamp: 'jc 6/16/2022 15:09:05'!
named: anAccountName

	name _ anAccountName! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'private' stamp: 'jc 6/16/2022 17:22:15'!
visitAccountsFor: aReportToBeMade

	aReportToBeMade treeReportForAPortfolio: self. 
	
	accounts do: [ :eachAccount | eachAccount visitAccountsFor: aReportToBeMade ].
	
	aReportToBeMade endReportOfPortfolio: self


	! !

!Portfolio methodsFor: 'private' stamp: 'jc 6/16/2022 14:52:50'!
visitTransactionsFor: aReportToBeMade

	accounts do: [ :eachAccount | eachAccount visitTransactionsFor: aReportToBeMade ].	
	! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instancing' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instancing' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'error' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jc 6/16/2022 15:05:52'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name _ 'NN'! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jc 6/16/2022 15:12:00'!
named: anAccountName

	name _ anAccountName! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'GF 6/14/2022 20:14:13'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'private' stamp: 'jc 6/16/2022 17:20:41'!
visitAccountsFor: aReportToBeMade

	aReportToBeMade treeReportForAReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'private' stamp: 'jc 6/16/2022 14:52:58'!
visitTransactionsFor: aReportToBeMade
	
	transactions do: [ :eachTransaction | eachTransaction visitTransactionsFor: aReportToBeMade ].	

	! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!classDefinition: #AccountReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountReport methodsFor: 'main protocol' stamp: 'jc 6/16/2022 13:27:20'!
reportOf: anAccountToMakeAReportOf

	self subclassResponsibility ! !


!AccountReport methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 14:55:55'!
depositReportFor: aDeposit

	self subclassResponsibility 
	! !

!AccountReport methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 14:55:11'!
transferDepositLegReportFor: aDepositLeg

	self subclassResponsibility ! !

!AccountReport methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 14:55:21'!
transferWithdrawLegReportFor: aWithdrawLeg

	self subclassResponsibility ! !

!AccountReport methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 14:55:40'!
withdrawReportFor: aWithdraw

	self subclassResponsibility 
	! !


!AccountReport methodsFor: 'resetting - private' stamp: 'jc 6/16/2022 14:56:53'!
resetReport

	self subclassResponsibility ! !


!AccountReport methodsFor: 'initializing' stamp: 'jc 6/16/2022 14:57:52'!
initialize 

	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'main protocol' stamp: 'jc 6/16/2022 14:56:34'!
reportOf: anAccountToMakeAReportOf 

	self resetReport.
		
	anAccountToMakeAReportOf visitTransactionsFor: self	.
	
	anAccountToMakeAReportOf balanceReportFor: self.
	
	^summary	
	
	! !


!AccountSummary methodsFor: 'resetting - private' stamp: 'jc 6/16/2022 14:56:34'!
resetReport

	summary _ OrderedCollection new! !


!AccountSummary methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 12:42:49'!
balanceReportFor: anAccount

	summary add: ('Balance = ',anAccount balance amount asString,' pesos')! !

!AccountSummary methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 12:42:23'!
depositReportFor: aDeposit

	summary add: ('Deposit for ',aDeposit value amount asString,' pesos')! !

!AccountSummary methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 12:43:10'!
transferDepositLegReportFor: aDepositLeg

	summary add: ('Transfer deposit for ',aDepositLeg value amount asString,' pesos')! !

!AccountSummary methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 12:43:20'!
transferWithdrawLegReportFor: aWithdrawLeg

	summary add: ('Transfer withdraw for ',aWithdrawLeg value amount asString,' pesos')! !

!AccountSummary methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 12:43:29'!
withdrawReportFor: aWithdraw

	summary add: ('Withdraw for ',aWithdraw value amount asString,' pesos')! !


!AccountSummary methodsFor: 'initializing' stamp: 'GF 6/15/2022 00:02:37'!
initialize

	summary _ OrderedCollection new! !


!classDefinition: #NetTransfer category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #NetTransfer
	instanceVariableNames: 'netTransferBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!NetTransfer methodsFor: 'main protocol' stamp: 'jc 6/16/2022 14:56:44'!
reportOf: anAccountToMakeAReportOf

	self resetReport.

	anAccountToMakeAReportOf visitTransactionsFor: self.
	
	^netTransferBalance 
	
	! !


!NetTransfer methodsFor: 'initializing' stamp: 'jc 6/16/2022 12:57:45'!
initialize 

	netTransferBalance _ 0 * peso! !


!NetTransfer methodsFor: 'resetting - private' stamp: 'jc 6/16/2022 14:56:44'!
resetReport

	netTransferBalance _ 0 * peso! !


!NetTransfer methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 18:03:39'!
depositReportFor: aDeposit

	! !

!NetTransfer methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 13:03:52'!
transferDepositLegReportFor: aDepositLeg

	netTransferBalance _ netTransferBalance + aDepositLeg value
	! !

!NetTransfer methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 13:04:19'!
transferWithdrawLegReportFor: aWithdrawLeg

	netTransferBalance _ netTransferBalance + aWithdrawLeg value negated! !

!NetTransfer methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 18:03:36'!
withdrawReportFor: aWithdraw

	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'private' stamp: 'jc 6/16/2022 12:30:38'!
visitTransactionsFor: anAccountSummary

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'private' stamp: 'jc 6/16/2022 12:30:46'!
visitTransactionsFor: aReport

	^aReport depositReportFor: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'private' stamp: 'jc 6/16/2022 14:53:30'!
visitTransactionsFor: aReportToBeMade

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'private' stamp: 'jc 6/16/2022 14:53:34'!
visitTransactionsFor: aReportToBeMade

	^aReportToBeMade transferDepositLegReportFor: self! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'private' stamp: 'jc 6/16/2022 14:53:39'!
visitTransactionsFor: aReportToBeMade

	^aReportToBeMade transferWithdrawLegReportFor: self! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'private' stamp: 'jc 6/16/2022 12:41:08'!
visitTransactionsFor: aReport

	^aReport withdrawReportFor: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #AccountTreeReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTreeReport
	instanceVariableNames: 'tree tabs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTreeReport methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 17:36:50'!
endReportOfPortfolio: aPortfolio

	self subclassResponsibility ! !

!AccountTreeReport methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 17:37:33'!
treeReportForAPortfolio: anAccount

	self subclassResponsibility 
	! !

!AccountTreeReport methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 17:37:44'!
treeReportForAReceptiveAccount: aReceptiveAccount

	self subclassResponsibility ! !


!AccountTreeReport methodsFor: 'initialization' stamp: 'jc 6/16/2022 17:37:11'!
initialize

	self subclassResponsibility ! !


!AccountTreeReport methodsFor: 'main protocol' stamp: 'jc 6/16/2022 18:12:10'!
reportOf: aPortfolioToMakeAReportOf
	
	self resetReport.
	
	aPortfolioToMakeAReportOf visitAccountsFor: self.
	
	^tree! !


!AccountTreeReport methodsFor: 'private' stamp: 'jc 6/16/2022 17:38:26'!
decreaseIndentation

	tabs _ tabs - 1! !

!AccountTreeReport methodsFor: 'private' stamp: 'jc 6/16/2022 17:38:07'!
increaseIndentation

	tabs _ tabs + 1! !

!AccountTreeReport methodsFor: 'private' stamp: 'jc 6/16/2022 17:40:04'!
indentations

	| indentations |
	
	indentations _ ''.

	tabs timesRepeat: [ indentations _ indentations, '    '].	

	^indentations.
! !


!AccountTreeReport methodsFor: 'resetting - private' stamp: 'jc 6/16/2022 18:09:52'!
resetReport

	tree _ OrderedCollection new! !


!classDefinition: #PortfolioDetailedTree category: 'ServiciosFinancieros-Solucion'!
AccountTreeReport subclass: #PortfolioDetailedTree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTree methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 17:40:36'!
endReportOfPortfolio: aPortfolio
	
	| indentations |

	indentations _ self indentations.

	tree add:  (indentations,'Balance = ',aPortfolio balance amount asString,' pesos').

	self decreaseIndentation ! !

!PortfolioDetailedTree methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 17:41:28'!
treeReportForAPortfolio: anAccount

	| indentations |
	
	indentations _ self indentations.

	tree add: indentations,anAccount name.
	
	self increaseIndentation.! !

!PortfolioDetailedTree methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 17:42:01'!
treeReportForAReceptiveAccount: aReceptiveAccount

	| indentations accountSummary |
	
	indentations _ self indentations.
	accountSummary _ AccountSummary new.

	tree add: indentations,aReceptiveAccount name.
	
	self increaseIndentation.
	
	(accountSummary reportOf: aReceptiveAccount) do: [ :eachTransactionReport | tree add: ('    ',indentations,eachTransactionReport) ]		.
	
	self decreaseIndentation
		
	! !


!PortfolioDetailedTree methodsFor: 'initialization' stamp: 'jc 6/16/2022 16:54:22'!
initialize 

	tree _ OrderedCollection new.
	tabs _ 0! !


!classDefinition: #PortfolioTree category: 'ServiciosFinancieros-Solucion'!
AccountTreeReport subclass: #PortfolioTree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTree methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 17:43:18'!
endReportOfPortfolio: aPortfolio

	self decreaseIndentation ! !

!PortfolioTree methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 17:42:29'!
treeReportForAPortfolio: anAccount

	| indentations  |
	
	indentations _ self indentations.

	tree add: indentations,anAccount name.
	
	self increaseIndentation 
	! !

!PortfolioTree methodsFor: 'reporting - private' stamp: 'jc 6/16/2022 17:42:37'!
treeReportForAReceptiveAccount: aReceptiveAccount

	| indentations  |
	
	indentations _ self indentations.

	tree add: indentations,aReceptiveAccount name.
	! !


!PortfolioTree methodsFor: 'initialization' stamp: 'jc 6/16/2022 16:16:26'!
initialize 

	tree _ OrderedCollection new.
	tabs _ 0! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
