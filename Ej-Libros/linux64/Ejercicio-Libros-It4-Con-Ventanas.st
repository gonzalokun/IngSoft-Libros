!classDefinition: #LibrosClientCartWindow category: 'Ejercicio-Libros'!
Panel subclass: #LibrosClientCartWindow
	instanceVariableNames: 'createCartButton'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!LibrosClientCartWindow methodsFor: 'initialization' stamp: 'G.L.S 7/3/2021 21:08:12'!
initializeWith: aModel

	self titleMorph showButtonsNamed: #( close collapse ).
	self model: aModel.
	self setLabel: 'Gestion de carrito'.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	
	"self model when: #userCredentialsFailed send: #showCredentialError to: self.
	self model when: #successfullyLogedIn send: #showUserWindow to: self."! !


!LibrosClientCartWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 21:09:19'!
buildMorphicWindow
	
	! !

!LibrosClientCartWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 21:08:48'!
defaultExtent
	
	^1035@485.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LibrosClientCartWindow class' category: 'Ejercicio-Libros'!
LibrosClientCartWindow class
	instanceVariableNames: ''!

!LibrosClientCartWindow class methodsFor: 'as yet unclassified' stamp: 'G.L.S 7/3/2021 20:12:00'!
withModel: aModel
	
	^self new initializeWith: aModel.! !


!classDefinition: #LibrosClientErrorWindow category: 'Ejercicio-Libros'!
Panel subclass: #LibrosClientErrorWindow
	instanceVariableNames: 'description'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!LibrosClientErrorWindow methodsFor: 'as yet unclassified' stamp: 'G.L.S 7/3/2021 19:56:48'!
buildMorphicWindow
	
	| errorLabel |
	errorLabel := LabelMorph contents: description.
	
	self layoutMorph
		beRow;
		axisEdgeWeight: 0.5;
		addMorph: (errorLabel).
	
	self morphExtent: (errorLabel minimumExtent + self errorMessagePanning).! !

!LibrosClientErrorWindow methodsFor: 'as yet unclassified' stamp: 'G.L.S 7/3/2021 19:57:06'!
errorMessagePanning

	^50@0.! !


!LibrosClientErrorWindow methodsFor: 'initialization' stamp: 'G.L.S 7/3/2021 19:55:55'!
initializeWith: anErrorDescription
	
	description := anErrorDescription.
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: 'ERROR'.
	self buildMorphicWindow.
	self openInWorld.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LibrosClientErrorWindow class' category: 'Ejercicio-Libros'!
LibrosClientErrorWindow class
	instanceVariableNames: ''!

!LibrosClientErrorWindow class methodsFor: 'as yet unclassified' stamp: 'G.L.S 7/3/2021 19:42:22'!
contents: anErrorDescription

	^self new initializeWith: anErrorDescription.! !


!classDefinition: #LibrosClientLoginWindow category: 'Ejercicio-Libros'!
Panel subclass: #LibrosClientLoginWindow
	instanceVariableNames: 'usernameTextMorph userpasswordTextMorph createCartButton listPurchasesButton'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!LibrosClientLoginWindow methodsFor: 'initialization' stamp: 'G.L.S 7/3/2021 20:45:16'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (LibrosClientModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	
	self model when: #userCredentialsFailed send: #showCredentialError to: self.
	self model when: #successfullyCreatedCart send: #showCartWindow to: self.
	self model when: #successfullyListedPurchases send: #showPurchasesWindow to: self.! !


!LibrosClientLoginWindow methodsFor: 'windows' stamp: 'G.L.S 7/3/2021 20:38:34'!
buildMorphicWindow

	self layoutMorph beColumn; 
	axisEdgeWeight: 0.5;
	separation: 25.

	self createUsernameTextMorph.
	self createUserpasswordTextMorph.
	self createCreateCartButton.
	self createListPurchasesButton.
	
	self setButtonsWidth.
	
	self addUsernameInput.
	self addUserpasswordInput.
	self addCreateCartButton.
	self addListPurchasesButton.! !

!LibrosClientLoginWindow methodsFor: 'windows' stamp: 'G.L.S 7/3/2021 20:28:25'!
showCartWindow

	"Mostrar ventana principal acá"
	LibrosClientCartWindow withModel: self model.! !

!LibrosClientLoginWindow methodsFor: 'windows' stamp: 'G.L.S 7/3/2021 19:39:59'!
showCredentialError
	
	LibrosClientErrorWindow contents: MockRestInterface errorWrongUserCredentials.! !

!LibrosClientLoginWindow methodsFor: 'windows' stamp: 'G.L.S 7/3/2021 20:47:02'!
showPurchasesWindow
	
	LibrosClientPurchasesWindow withModel: self model.! !


!LibrosClientLoginWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 20:32:36'!
addCreateCartButton
	
	self layoutMorph addMorph: createCartButton.! !

!LibrosClientLoginWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 20:33:04'!
addListPurchasesButton

	self layoutMorph addMorph: listPurchasesButton.! !

!LibrosClientLoginWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 16:59:29'!
addUsernameInput

	self layoutMorph
		addMorph: (LabelMorph contents: 'Usuario');
		addMorph: usernameTextMorph.
! !

!LibrosClientLoginWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 17:00:04'!
addUserpasswordInput
	
	self layoutMorph 
		addMorph: (LabelMorph contents: 'Contraseña');
		addMorph: userpasswordTextMorph.
! !

!LibrosClientLoginWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 20:38:17'!
createCreateCartButton

	createCartButton := PluggableButtonMorph model: self model 
								stateGetter: nil  
								action: #tryToCreateCartWithUserCredentials
								label: 'Create Cart'.
! !

!LibrosClientLoginWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 20:32:20'!
createListPurchasesButton.

	listPurchasesButton := PluggableButtonMorph model: self model 
								stateGetter: nil  
								action: #tryToListPurchasesWithUserCredentials
								label: 'List Purchases'.
	
	! !

!LibrosClientLoginWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 17:02:48'!
createUsernameTextMorph
	
	usernameTextMorph := TextModelMorph textProvider: self model textGetter: #usernameText textSetter: #usernameText:. 
   	usernameTextMorph textMorph setProperty: #keyStroke: toValue: [ :key | usernameTextMorph textMorph acceptContents ].
    	usernameTextMorph borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300. 
    	usernameTextMorph morphHeight: 10.
	! !

!LibrosClientLoginWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 17:02:57'!
createUserpasswordTextMorph

	userpasswordTextMorph := TextModelMorph textProvider: self model textGetter: #userpasswordText textSetter: #userpasswordText:. 
   	userpasswordTextMorph textMorph setProperty: #keyStroke: toValue: [ :key | userpasswordTextMorph textMorph acceptContents ] .
    	userpasswordTextMorph borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300. 
    	userpasswordTextMorph morphHeight: 10.! !

!LibrosClientLoginWindow methodsFor: 'private' stamp: 'G.L.S 7/1/2021 18:49:18'!
defaultExtent

	^ 1035@485! !

!LibrosClientLoginWindow methodsFor: 'private' stamp: 'G.L.S 7/3/2021 20:38:48'!
setButtonsWidth.
	
	createCartButton layoutSpec proportionalWidth: 0.3.
	listPurchasesButton layoutSpec proportionalWidth: 0.3.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LibrosClientLoginWindow class' category: 'Ejercicio-Libros'!
LibrosClientLoginWindow class
	instanceVariableNames: ''!

!LibrosClientLoginWindow class methodsFor: 'as yet unclassified' stamp: 'G.L.S 7/1/2021 18:47:35'!
open
	
	^self new initializeWith: 'Ejercicio Libros Client Window'.! !


!classDefinition: #LibrosClientPurchasesWindow category: 'Ejercicio-Libros'!
Panel subclass: #LibrosClientPurchasesWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!LibrosClientPurchasesWindow methodsFor: 'as yet unclassified' stamp: 'G.L.S 7/3/2021 21:11:35'!
buildMorphicWindow
	
	! !

!LibrosClientPurchasesWindow methodsFor: 'as yet unclassified' stamp: 'G.L.S 7/3/2021 21:10:35'!
defaultExtent
	
	^1035@485.! !

!LibrosClientPurchasesWindow methodsFor: 'as yet unclassified' stamp: 'G.L.S 7/3/2021 21:10:15'!
initializeWith: aModel

	self titleMorph showButtonsNamed: #( close collapse ).
	self model: aModel.
	self setLabel: 'Compras anteriores'.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	
	"self model when: #userCredentialsFailed send: #showCredentialError to: self.
	self model when: #successfullyLogedIn send: #showUserWindow to: self."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LibrosClientPurchasesWindow class' category: 'Ejercicio-Libros'!
LibrosClientPurchasesWindow class
	instanceVariableNames: ''!

!LibrosClientPurchasesWindow class methodsFor: 'as yet unclassified' stamp: 'G.L.S 7/3/2021 21:09:46'!
withModel: aModel
	
	^self new initializeWith: aModel.! !


!classDefinition: #CartTest category: 'Ejercicio-Libros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'smalltalk80 designPatterns objectThinking emptyCatalog catalog1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:31:30'!
setUp

	smalltalk80 := '9780201113723'.
	designPatterns := '9780201184624'.
	objectThinking := '9780735619654'.
	
	emptyCatalog := Dictionary new.
	
	catalog1 := Dictionary new.
	catalog1 add: smalltalk80 -> 10.
	catalog1 add: designPatterns -> 100.
	catalog1 add: objectThinking -> 50.! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:26:27'!
test01CartThatWasJustCreatedIsEmpty

	| carrito |
	
	carrito := Cart createNewWithCatalog: emptyCatalog.
	
	self assert: carrito isEmpty.
	! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:26:53'!
test02CartWithAnItemIsNotEmpty

	| carrito |
	
	carrito := Cart createNewWithCatalog: catalog1.
	carrito add: smalltalk80.
	
	self deny: carrito isEmpty.
	! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:28:50'!
test03CartWithSeveralItemsAddedContainsTheRightItemsAndAmounts

	| carrito tuplaLibroCant |
	
	carrito := Cart createNewWithCatalog: catalog1.
		
	carrito add: smalltalk80 amount: 4.
	carrito add: designPatterns amount: 2.
	
	tuplaLibroCant := OrderedCollection new.
	tuplaLibroCant add: smalltalk80.
	tuplaLibroCant add: 4.
	
	self deny: carrito isEmpty.
	self assert: 2 equals: carrito size.
	self assert: tuplaLibroCant equals: carrito first.
	
	tuplaLibroCant := OrderedCollection new.
	tuplaLibroCant add: designPatterns .
	tuplaLibroCant add: 2.
	
	self assert: tuplaLibroCant equals: carrito second.! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:30:26'!
test04CartCannotAddItemsThatAreNotAllowed
		
	self testCartFailToAdd: smalltalk80 
		withAmount: 1
		whileAllowing: emptyCatalog 
		expectingErrorMessage: Cart errorBookNotInAllowedList.
	! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:30:36'!
test05CartCannotAddANonIntegerAmountOfAnItem
	
	self testCartFailToAdd: smalltalk80 
		withAmount: 1.5
		whileAllowing: catalog1  
		expectingErrorMessage: Cart errorAmountNotInteger.
	! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:30:40'!
test06CartCannotAddANegativeAmountOfAnItem
	
	self testCartFailToAdd: smalltalk80 
		withAmount: -1
		whileAllowing: catalog1  
		expectingErrorMessage: Cart errorAmountNegative.! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:30:46'!
test07CartCannotAddAZeroAmountOfAnItem
	
	self testCartFailToAdd: smalltalk80 
		withAmount: 0
		whileAllowing: catalog1  
		expectingErrorMessage: Cart errorAmountZero.
	! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:29:34'!
testCartFailToAdd: aBook withAmount: anAmount whileAllowing: aBookList expectingErrorMessage: anErrorMessage

	| carrito |
	
	carrito := Cart createNewWithCatalog: aBookList.
	
	self should: [
		carrito add: aBook amount: anAmount.
		]
		raise: Error  
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: anErrorMessage.
			].
	! !


!classDefinition: #CashierTest category: 'Ejercicio-Libros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'smalltalk80 designPatterns objectThinking catalog1 emptyCatalog catalog2 donQuixote workingCreditCard expiredCreditCard sales stolenCreditCard merchantProcessor fakeCreditCard creditCardWithoutMoney listToAdd emptyListToAdd listToAdd2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:04:23'!
setUp
	
	sales := OrderedCollection new.
	
	smalltalk80 := '9780201113723'.
	designPatterns := '9780201184624'.
	objectThinking := '9780735619654'.
	donQuixote := '9781400132171'.
	
	emptyCatalog := Dictionary new.
	
	catalog1 := Dictionary new.
	catalog1 add: smalltalk80 -> 10.
	catalog1 add: designPatterns -> 100.
	catalog1 add: objectThinking -> 50.
	
	catalog2 := Dictionary new.
	catalog2 add: donQuixote -> 50.
	
	emptyListToAdd := Dictionary new.
	
	listToAdd := Dictionary new.
	listToAdd add: donQuixote -> 1.
	
	listToAdd2 := Dictionary new.
	listToAdd2 add: smalltalk80 -> 3.
	listToAdd2 add: designPatterns -> 5.
	
	workingCreditCard := CreditCard forOwner: 'Marco' withNumber: '0000000000000000' withExpirationDate: FixedGregorianDate tomorrow.
	expiredCreditCard := CreditCard forOwner: 'Jorge' withNumber: '0000000000000000' withExpirationDate: FixedGregorianDate yesterday.
	stolenCreditCard := CreditCard forOwner: 'Gervasio' withNumber: '1234567891011120' withExpirationDate: FixedGregorianDate tomorrow.
	fakeCreditCard := CreditCard  forOwner: 'Pepe' withNumber: '1000000000000000' withExpirationDate: FixedGregorianDate tomorrow.
	creditCardWithoutMoney := CreditCard  forOwner: 'Ivan' withNumber: '1200000000000000' withExpirationDate: FixedGregorianDate tomorrow.
	
	merchantProcessor := MockMerchantProcesor new.
	merchantProcessor registerStolenCard: stolenCreditCard.
	merchantProcessor registerCard: workingCreditCard withBalance: 1000.
	merchantProcessor registerCard: creditCardWithoutMoney withBalance: 0.	! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:13:22'!
test01CashierCannotCheckoutWithAnEmptyCart
		
	self testCashierWithCatalog: emptyCatalog 
		cannotCheckoutCartWithCatalog: emptyCatalog 
		withItems: emptyListToAdd 
		withCreditCard: workingCreditCard 
		ThrowingError: Cashier errorCannotCheckoutEmptyCart.! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:13:22'!
test02CashierCannotCheckoutWithACartWithThatDoesntHaveAMatchingCatalog
		
	self testCashierWithCatalog: catalog1 
		cannotCheckoutCartWithCatalog: catalog2 
		withItems: listToAdd 
		withCreditCard:  workingCreditCard 
		ThrowingError: Cashier errorCannotCheckoutACartWithADifferentCatalog! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:18:05'!
test03CheckoutReturnsTheRightAmount
	
	self testCashierWithCatalog: catalog1 
		checkoutCartWithItems: listToAdd2 
		withCreditCard: workingCreditCard 
		asserting: [:aResult | self assert: 530 equals: aResult.]! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:13:22'!
test04CashierCannotCheckOutWithAnExpiredCard
	
	self testCashierWithCatalog: catalog1 
		cannotCheckoutCartWithCatalog: catalog1 
		withItems: listToAdd2  
		withCreditCard: expiredCreditCard 
		ThrowingError: Cashier errorExpiredCard.! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:19:13'!
test05CashierCheckoutRegistersSale
	
	self testCashierWithCatalog: catalog1 
	 	checkoutCartWithItems: listToAdd2 
		withCreditCard: workingCreditCard 
		asserting: [:aResult | self deny: sales isEmpty.
						self assert: 530 equals: (sales at: 1)].! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:13:22'!
test06CashierCannotCheckoutAStolenCard
	
	self testCashierWithCatalog: catalog1 
		cannotCheckoutCartWithCatalog: catalog1 
		withItems: listToAdd2 
		withCreditCard: stolenCreditCard 
		ThrowingError: Cashier errorStolenCard.! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:13:22'!
test07CashierCannotCheckoutWithAFakeCard
		
	self testCashierWithCatalog: catalog1 
		cannotCheckoutCartWithCatalog: catalog1 
		withItems: listToAdd2 
		withCreditCard: fakeCreditCard 
		ThrowingError: Cashier errorNotARegisteredCard.
	! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:13:22'!
test08CashierCannotCheckoutWithACardWithoutMoney
		
	self testCashierWithCatalog: catalog1 
		cannotCheckoutCartWithCatalog: catalog1 
		withItems: listToAdd2 
		withCreditCard: creditCardWithoutMoney 
		ThrowingError: Cashier errorCardDoesNotHaveEnoughBalance.
	! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:26:27'!
testCashierWithCatalog: aCatalog cannotCheckoutCartWithCatalog: aCartCatalog withItems: aListOfItemsAndAmounts withCreditCard: aCreditCard ThrowingError: anErrorMessage
	
	| cart cashier |
	
	cashier := Cashier withCatalog: aCatalog.
	
	cart := Cart createNewWithCatalog: aCartCatalog .
	
	aListOfItemsAndAmounts keysDo: [:anItem | cart add: anItem amount: (aListOfItemsAndAmounts at: anItem)].
	
	self should: [cashier checkout: cart 
					withCreditCard: aCreditCard
					onDate: FixedGregorianDate today 
					registerOn: sales 
					forMerchantProcessor: merchantProcessor]
		raise: Error 
		withExceptionDo: [
			:anError | 
			self assert: anError messageText = anErrorMessage.
			].! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 18:26:27'!
testCashierWithCatalog: aCatalog checkoutCartWithItems: aListOfItemsAndAmounts withCreditCard: aCreditCard asserting: anAssertionBlock
	
	| cart cashier result |
	
	cashier := Cashier withCatalog: aCatalog.
	
	cart := Cart createNewWithCatalog: aCatalog.
	
	aListOfItemsAndAmounts keysDo: [:anItem | cart add: anItem amount: (aListOfItemsAndAmounts at: anItem).].
	
	result := cashier checkout: cart 
		withCreditCard: aCreditCard
		onDate: FixedGregorianDate today 
		registerOn: sales 
		forMerchantProcessor: merchantProcessor.
		
	anAssertionBlock value: result.! !


!classDefinition: #CreditCardTest category: 'Ejercicio-Libros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!CreditCardTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 17:32:43'!
test01CreditCardCannotHaveEmptyOwner
	
	self testCreditCardFail: [CreditCard forOwner: '' withNumber: '0000000000000000' withExpirationDate: FixedGregorianDate today] 
		withErrorMessage: CreditCard errorOwnerEmpty.! !

!CreditCardTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 17:33:30'!
test02CreditCardNumberForACreditCardCannotHaveLessThan16Digits
	
	self testCreditCardFail: [CreditCard forOwner: 'Jorge' withNumber: ''  withExpirationDate: FixedGregorianDate today] 
		 withErrorMessage: CreditCard errorCardNumberLessThan16Digits.! !

!CreditCardTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 17:34:49'!
test03CreditCardNumberForACreditCardCannotHaveMoreThan16Digits
	
	self testCreditCardFail: [CreditCard forOwner: 'Jorge' withNumber: '00000000000000001'  withExpirationDate: FixedGregorianDate today]
		withErrorMessage: CreditCard errorCardNumberMoreThan16Digits.! !

!CreditCardTest methodsFor: 'testing' stamp: 'G.L.S 6/16/2021 17:31:36'!
testCreditCardFail: aBlockToFail withErrorMessage: anErrorMessage
	
	self should: aBlockToFail 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [
			:anError |
			self assert: anError messageText = anErrorMessage].! !


!classDefinition: #MockRestInterfaceTest category: 'Ejercicio-Libros'!
TestCase subclass: #MockRestInterfaceTest
	instanceVariableNames: 'mockInterface userData sales smalltalk80 designPatterns objectThinking donQuixote emptyCatalog catalog1 catalog2 workingCreditCard merchantProcessor timer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/24/2021 15:19:09'!
test01CannotCreateCartWithTheWrongUserPassword

	| password usuario |
	
	usuario := 'pepe'.
	password := '1234'.
	
	self testFail: [mockInterface createCartForUser: usuario password: password] withErrorMessage: MockRestInterface errorWrongUserCredentials.! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/21/2021 16:22:46'!
test02CreateCartForAnExistingUserDoesNotFail

	| password usuario huboError |
	
	usuario := 'pepe'.
	password := '5678'.
	
	huboError := #No.
	
	[mockInterface createCartForUser: usuario password: password] 
		on: Error 
		do: [huboError := #Si].
		
	self assert: #No equals: huboError.! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/24/2021 15:19:38'!
test03CannotCreateCartForAUserThatDoesntExist

	| password usuarioNoExistente |
	
	usuarioNoExistente := 'Jorge'.
	password := '1234'.
		
	self testFail: [mockInterface createCartForUser: usuarioNoExistente password: password] withErrorMessage: MockRestInterface errorWrongUserCredentials.	! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/24/2021 15:20:49'!
test04CannotAddItemToAnUnexistentCart

	self testFail: [mockInterface add: 17 ofItem: smalltalk80 toCart: 0] withErrorMessage: MockRestInterface errorCartIdDoesNotExist.! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/21/2021 15:47:11'!
test05AddingItemsToCartWorksAsExpected

	| password usuario huboError cartId cartList |
	
	usuario := 'pepe'.
	password := '5678'.
	
	huboError := #No.
	
	cartId := mockInterface createCartForUser: usuario password: password.
	
	[mockInterface add: 17 ofItem: smalltalk80 toCart: cartId] 
		on: Error 
		do: [huboError := #Si].
	
	cartList := (mockInterface listCart: cartId).
	
	self assert: #No equals: huboError.
	self deny: (cartList) isEmpty.
	self assert: smalltalk80 equals: cartList first first.
	self assert: 17 equals: cartList first second.
	! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/21/2021 15:47:11'!
test06DifferentCartsCannotHaveTheSameId

	| password usuario cartId1 cartId2 password2 usuario2 |
	
	usuario := 'pepe'.
	password := '5678'.
	
	usuario2 := 'ramon'.
	password2 := '1234'.
	
	cartId1 := mockInterface createCartForUser: usuario password: password.
	cartId2 := mockInterface createCartForUser: usuario2 password: password2.
	
	self deny: (cartId1 = cartId2).! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/24/2021 15:23:55'!
test07CannotListCartAnUnexistentCart

	self testFail: [mockInterface listCart: 0] withErrorMessage: MockRestInterface errorCartIdDoesNotExist.! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/24/2021 15:24:35'!
test08CannotListPurchasesWithAnUserThatDoesntExist

	| password usuarioNoExistente |
	
	usuarioNoExistente := 'Jorge'.
	password := '1234'.
	
	self testFail: [mockInterface listPurchasesForUser: usuarioNoExistente withPassword: password] withErrorMessage: MockRestInterface errorWrongUserCredentials.
			! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/28/2021 21:25:34'!
test09CannotCheckOutWithACartThatDoesNotExist

		
	self testFail: [mockInterface checkOutCart: 0 withCreditCard: '' withExpirationDate: '' withOwner: '']  		withErrorMessage: MockRestInterface errorCartIdDoesNotExist.! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/28/2021 21:28:27'!
test10SuccessfulCheckoutAltersUserListPurchase
	
	| password usuario cartId |
	
	usuario := 'pepe'.
	password := '5678'.
	
	cartId := mockInterface createCartForUser: usuario password: password.
	
	mockInterface add: 17 ofItem: smalltalk80 toCart: cartId.
	
	mockInterface checkOutCart: cartId 
				withCreditCard: '0000000000000000' 
				withExpirationDate: FixedGregorianDate tomorrow 
				withOwner: 'Marco'.
	
	self assert: ((mockInterface listPurchasesForUser: usuario withPassword: password) at: smalltalk80) = 17.
	self assert: ((mockInterface listPurchasesForUser: usuario withPassword: password) at: 'totalBooks') = 170.
	
	cartId := mockInterface createCartForUser: usuario password: password.
	
	mockInterface add: 17 ofItem: smalltalk80 toCart: cartId.
	
	mockInterface checkOutCart: cartId 
				withCreditCard: '0000000000000000' 
				withExpirationDate: FixedGregorianDate tomorrow 
				withOwner: 'Marco'.
	
	self assert: ((mockInterface listPurchasesForUser: usuario withPassword: password) at: smalltalk80) = 34.
	self assert: ((mockInterface listPurchasesForUser: usuario withPassword: password) at: 'totalBooks') = 340.! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/28/2021 21:26:04'!
test11CannotUseACartAfterItExpired

	| password usuario cartId |
	
	usuario := 'pepe'.
	password := '5678'.
	
	cartId := mockInterface createCartForUser: usuario password: password.
	
	mockInterface add: 17 ofItem: smalltalk80 toCart: cartId.
	
	mockInterface listCart: cartId.
	
	timer passTime: 35.
	
	self testFail: [mockInterface add: 17 ofItem: smalltalk80 toCart: cartId] withErrorMessage: MockRestInterface errorCartExpired.
	
	self testFail: [mockInterface listCart: cartId]  withErrorMessage: MockRestInterface errorCartExpired.
	
	self testFail: [mockInterface checkOutCart: cartId 
				withCreditCard: '0000000000000000' 
				withExpirationDate: FixedGregorianDate tomorrow 
				withOwner: 'Marco'] 
		withErrorMessage: MockRestInterface errorCartExpired.
	
! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/28/2021 21:36:24'!
test12SuccesfulCheckoutsProduceDifferentTransactionIds
	
	| password usuario cartId transactionId1 transactionId2 |
	
	usuario := 'pepe'.
	password := '5678'.
	
	cartId := mockInterface createCartForUser: usuario password: password.
	
	mockInterface add: 17 ofItem: smalltalk80 toCart: cartId.
	
	transactionId1 := mockInterface checkOutCart: cartId 
					withCreditCard: '0000000000000000' 
					withExpirationDate: FixedGregorianDate tomorrow 
					withOwner: 'Marco'.
	
	cartId := mockInterface createCartForUser: usuario password: password.
	
	mockInterface add: 17 ofItem: smalltalk80 toCart: cartId.
	
	transactionId2 := mockInterface checkOutCart: cartId 
					withCreditCard: '0000000000000000' 
					withExpirationDate: FixedGregorianDate tomorrow 
					withOwner: 'Marco'.
	
	self deny: (transactionId1 = transactionId2).! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/29/2021 19:50:24'!
test13CannotCheckoutAPreviouslyCheckoutedCart
	
	| password usuario cartId |
	
	usuario := 'pepe'.
	password := '5678'.
	
	cartId := mockInterface createCartForUser: usuario password: password.
	
	mockInterface add: 17 ofItem: smalltalk80 toCart: cartId.
	
	mockInterface checkOutCart: cartId 
				withCreditCard: '0000000000000000' 
				withExpirationDate: FixedGregorianDate tomorrow 
				withOwner: 'Marco'.
				
	self testFail: [
			mockInterface checkOutCart: cartId 
				withCreditCard: '0000000000000000' 
				withExpirationDate: FixedGregorianDate tomorrow 
				withOwner: 'Marco'.
				] 
		withErrorMessage: MockRestInterface errorCartIdDoesNotExist.! !

!MockRestInterfaceTest methodsFor: 'testing' stamp: 'G.L.S 6/24/2021 15:18:27'!
testFail: aBlock withErrorMessage: anErrorMessage
	
	self should: aBlock 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: anErrorMessage.
			].! !


!MockRestInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'G.L.S 6/28/2021 21:25:02'!
setUp
	
	smalltalk80 := '9780201113723'.
	designPatterns := '9780201184624'.
	objectThinking := '9780735619654'.
	donQuixote := '9781400132171'.
	
	sales := OrderedCollection new.
	
	emptyCatalog := Dictionary new.
	
	catalog1 := Dictionary new.
	catalog1 add: smalltalk80 -> 10.
	catalog1 add: designPatterns -> 100.
	catalog1 add: objectThinking -> 50.
	
	catalog2 := Dictionary new.
	catalog2 add: donQuixote -> 50.
	
	userData := Dictionary new.
	userData add: 'pepe' -> '5678'.
	userData add: 'ramon' -> '1234'.
	
	timer := (MockTimer new).
	
	workingCreditCard := CreditCard forOwner: 'Marco' withNumber: '0000000000000000' withExpirationDate: FixedGregorianDate tomorrow.
	
	merchantProcessor := MockMerchantProcesor new.
	merchantProcessor registerCard: workingCreditCard withBalance: 1000.
	
	mockInterface := MockRestInterface createFor: userData withCatalog: catalog1 withTimer: timer withSalesBook: sales withMerchantProcesor: merchantProcessor.
	! !


!classDefinition: #Cart category: 'Ejercicio-Libros'!
Object subclass: #Cart
	instanceVariableNames: 'cartItems catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!Cart methodsFor: 'operations' stamp: 'G.L.S 6/9/2021 18:11:29'!
add: aBook 
	self add: aBook amount: 1.! !

!Cart methodsFor: 'operations' stamp: 'G.L.S 6/14/2021 19:08:24'!
add: aBook amount: anAmount 
	| tuplaLibroCant |
	
	self assertBookIsAllowed: aBook.
	self assertAmountIsValid: anAmount.
	
	tuplaLibroCant := OrderedCollection new.
	tuplaLibroCant add: aBook.
	tuplaLibroCant add: anAmount.
	
	cartItems add: tuplaLibroCant.! !

!Cart methodsFor: 'operations' stamp: 'G.L.S 6/10/2021 13:49:35'!
assertAmountIsValid: anAmount.

	(anAmount isInteger) ifFalse: [self error: self class errorAmountNotInteger].
	(anAmount < 0) ifTrue: [self error: self class errorAmountNegative].
	(anAmount = 0) ifTrue: [self error: self class errorAmountZero].! !

!Cart methodsFor: 'operations' stamp: 'G.L.S 6/14/2021 19:00:17'!
assertBookIsAllowed: aBook

	(catalog keys includes: aBook) ifFalse:[self error: self class errorBookNotInAllowedList.].! !

!Cart methodsFor: 'operations' stamp: 'G.L.S 6/14/2021 19:08:23'!
first
	^cartItems first.! !

!Cart methodsFor: 'operations' stamp: 'G.L.S 6/14/2021 19:00:17'!
hasCatalog: aCatalog
	^catalog = aCatalog.! !

!Cart methodsFor: 'operations' stamp: 'G.L.S 6/14/2021 19:08:24'!
isEmpty
	^cartItems isEmpty.! !

!Cart methodsFor: 'operations' stamp: 'G.L.S 6/14/2021 19:08:23'!
second
	^cartItems second.! !

!Cart methodsFor: 'operations' stamp: 'G.L.S 6/14/2021 19:08:23'!
size
	^cartItems size.! !

!Cart methodsFor: 'operations' stamp: 'G.L.S 6/14/2021 19:08:24'!
totalItemPrice
	
	^cartItems sum: [:bookAmountTuple | (catalog at: bookAmountTuple first) * bookAmountTuple second].! !


!Cart methodsFor: 'initialization' stamp: 'G.L.S 6/14/2021 19:08:24'!
initializeWith: anOrderedCollection
	catalog := anOrderedCollection.
	cartItems := OrderedCollection new.! !


!Cart methodsFor: 'private' stamp: 'G.L.S 6/21/2021 15:46:50'!
itemListFor: aMockRestInterface
	^aMockRestInterface listCartItemsFor: cartItems.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Ejercicio-Libros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'G.L.S 6/16/2021 18:26:27'!
createNewWithCatalog: anOrderedCollection 
	^self new initializeWith: anOrderedCollection.! !


!Cart class methodsFor: 'errors' stamp: 'G.L.S 6/10/2021 13:40:37'!
errorAmountNegative
	^'Error - La cantidad no puede ser negativa'.! !

!Cart class methodsFor: 'errors' stamp: 'G.L.S 6/10/2021 13:35:33'!
errorAmountNotInteger
	^'Error - La cantidad tiene que ser un número entero'.! !

!Cart class methodsFor: 'errors' stamp: 'G.L.S 6/10/2021 13:49:02'!
errorAmountZero
	^'Error - La cantidad de libros no puede ser 0'.! !

!Cart class methodsFor: 'errors' stamp: 'G.L.S 6/9/2021 18:35:13'!
errorBookNotInAllowedList
	^'Error - El Libro no está en la lista de productos permitidos'.! !


!classDefinition: #Cashier category: 'Ejercicio-Libros'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!Cashier methodsFor: 'private' stamp: 'G.L.S 6/14/2021 19:54:34'!
assertCard: aCreditCard hasNotExpiredOn: aDate.
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: self class errorExpiredCard].! !

!Cashier methodsFor: 'private' stamp: 'G.L.S 6/15/2021 18:16:42'!
assertCard: aCreditCard isNotStolenFor: aMerchantProcessor

	(aMerchantProcessor isCardStolen: aCreditCard) ifTrue: [self error: self class errorStolenCard].! !

!Cashier methodsFor: 'private' stamp: 'G.L.S 6/16/2021 16:25:06'!
assertCard: aCreditCard isRegisteredOn: aMerchantProcessor
	
	(aMerchantProcessor isCardRegistered: aCreditCard) ifFalse: [self error: self class errorNotARegisteredCard].! !

!Cashier methodsFor: 'private' stamp: 'G.L.S 6/10/2021 20:49:32'!
assertCartHasTheSameCatalog: aCart

	(aCart hasCatalog: catalog) ifFalse: [self error: self class errorCannotCheckoutACartWithADifferentCatalog].! !

!Cashier methodsFor: 'private' stamp: 'G.L.S 6/10/2021 20:33:20'!
assertCartIsNotEmpty: aCart
	
	aCart isEmpty ifTrue: [self error: self class errorCannotCheckoutEmptyCart].! !


!Cashier methodsFor: 'operations' stamp: 'G.L.S 6/16/2021 17:21:01'!
assertCard: aCreditCard canSpend: aTotal on: aMerchantProcessor
	
	(aMerchantProcessor can: aCreditCard spend: aTotal) ifFalse: [self error: self class errorCardDoesNotHaveEnoughBalance]! !

!Cashier methodsFor: 'operations' stamp: 'G.L.S 6/16/2021 17:02:31'!
checkout: aCart withCreditCard: aCreditCard onDate: aDate registerOn: aSalesBook forMerchantProcessor: aMerchantProcessor    
	
	| total |
	
	self assertCartIsNotEmpty: aCart.
	self assertCartHasTheSameCatalog: aCart.
	self assertCard: aCreditCard hasNotExpiredOn: aDate.
	self assertCard: aCreditCard isNotStolenFor: aMerchantProcessor.
	self assertCard: aCreditCard isRegisteredOn: aMerchantProcessor.
	
	total := aCart totalItemPrice.
	
	self assertCard: aCreditCard canSpend: total on: aMerchantProcessor.
	
	aSalesBook add: total.
	
	^total.! !


!Cashier methodsFor: 'initialization' stamp: 'G.L.S 6/10/2021 20:45:21'!
initializeWithCatalog: aCatalog 
	catalog := aCatalog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'Ejercicio-Libros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'errors' stamp: 'G.L.S 6/10/2021 20:48:53'!
errorCannotCheckoutACartWithADifferentCatalog
	^'Error - No se puede hacer checkout de un carrito con un catálogo diferente'.! !

!Cashier class methodsFor: 'errors' stamp: 'G.L.S 6/10/2021 20:01:29'!
errorCannotCheckoutEmptyCart
	^'Error - No se puede hacer checkout de un carrito vacío'.! !

!Cashier class methodsFor: 'errors' stamp: 'G.L.S 6/16/2021 17:07:06'!
errorCardDoesNotHaveEnoughBalance

	^'Error - La tarjeta de crédito no tiene suficiente saldo'.! !

!Cashier class methodsFor: 'errors' stamp: 'G.L.S 6/14/2021 19:41:47'!
errorExpiredCard
	^'Error - No se puede hacer checkout con una tarjeta de crédito vacía'.! !

!Cashier class methodsFor: 'errors' stamp: 'G.L.S 6/16/2021 16:18:52'!
errorNotARegisteredCard
	^'Error - La tarjeta utilizada no se encuentra registrada'.! !

!Cashier class methodsFor: 'errors' stamp: 'G.L.S 6/15/2021 18:14:08'!
errorStolenCard
	^'Error - No se puede realizar una transacción con una tarjeta robada'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'G.L.S 6/10/2021 20:44:34'!
withCatalog: aDictionary 
	^self new initializeWithCatalog: aDictionary. ! !


!classDefinition: #CreditCard category: 'Ejercicio-Libros'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner creditCardNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!CreditCard methodsFor: 'initialization' stamp: 'G.L.S 6/14/2021 21:35:08'!
assertCardNumberIsCorrect: aCreditCardNumber

	(aCreditCardNumber size < 16) ifTrue: [self error: self class errorCardNumberLessThan16Digits].
	(aCreditCardNumber size > 16) ifTrue: [self error: self class errorCardNumberMoreThan16Digits].! !

!CreditCard methodsFor: 'initialization' stamp: 'G.L.S 6/14/2021 21:30:19'!
initializeForOwner: anOwner withNumber: aCreditCardNumber withExpirationDate: aDate 

	self assertNameNotEmpty: anOwner.
	self assertCardNumberIsCorrect: aCreditCardNumber.

	owner := anOwner.
	creditCardNumber := aCreditCardNumber.
	expirationDate := aDate.! !


!CreditCard methodsFor: 'private' stamp: 'G.L.S 6/21/2021 18:49:48'!
= aCreditCard
	
	^ aCreditCard isNumber: creditCardNumber.! !

!CreditCard methodsFor: 'private' stamp: 'G.L.S 6/14/2021 21:25:06'!
assertNameNotEmpty: anOwner
	
	anOwner withBlanksTrimmed isEmpty ifTrue: [self error: self class errorOwnerEmpty].! !

!CreditCard methodsFor: 'private' stamp: 'G.L.S 6/21/2021 18:58:58'!
isNumber: aCreditCardNumber.
	
	^ aCreditCardNumber = creditCardNumber.! !


!CreditCard methodsFor: 'expiration' stamp: 'G.L.S 6/14/2021 19:50:01'!
isExpiredOn: aDate
	^ expirationDate < aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'Ejercicio-Libros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'G.L.S 6/14/2021 19:39:49'!
forOwner: anOwner withNumber: aCreditCardNumber withExpirationDate: aDate
	^self new initializeForOwner: anOwner withNumber: aCreditCardNumber withExpirationDate: aDate ! !


!CreditCard class methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/14/2021 21:28:57'!
errorCardNumberLessThan16Digits
	^'Error - El número de la tarjeta de crédito tiene menos de 16 dígitos'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/14/2021 21:32:51'!
errorCardNumberMoreThan16Digits
	^'Error - El número de la tarjeta de crédito tiene más de 16 dígitos'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/14/2021 21:23:40'!
errorOwnerEmpty
	^'Error - El nombre dueño de la tarjeta de crédito no puede estar vacío'! !


!classDefinition: #LibrosClientModel category: 'Ejercicio-Libros'!
Object subclass: #LibrosClientModel
	instanceVariableNames: 'username userpassword restInterface cartId purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!LibrosClientModel methodsFor: 'initialization' stamp: 'G.L.S 7/3/2021 18:50:36'!
initialize
	
	username := ''.
	userpassword := ''.
	
	restInterface := LibrosRestInterface new.! !


!LibrosClientModel methodsFor: 'private' stamp: 'G.L.S 7/3/2021 20:27:23'!
tryToCreateCartWithUserCredentials
	
	[cartId := restInterface sendCreateCartRequestFor: username withPassword: userpassword]
	on: Error
	do: [self triggerEvent: #userCredentialsFailed with: self.
		^self].
	
	self triggerEvent: #successfullyCreatedCart with: self.
	
	! !

!LibrosClientModel methodsFor: 'private' stamp: 'G.L.S 7/3/2021 20:48:29'!
tryToListPurchasesWithUserCredentials
	
	[purchases := restInterface sendListPurchasesRequestFor: username withPassword: userpassword]
	on: Error
	do: [self triggerEvent: #userCredentialsFailed with: self.
		^self].
	
	self triggerEvent: #successfullyListedPurchases with: self.
	
	! !


!LibrosClientModel methodsFor: 'setters' stamp: 'G.L.S 7/3/2021 20:17:05'!
usernameText: aUserName.

	username := aUserName.
	
	^true.! !

!LibrosClientModel methodsFor: 'setters' stamp: 'G.L.S 7/3/2021 20:19:09'!
userpasswordText: aUserPassword.

	userpassword := aUserPassword.
	
	^true.! !


!LibrosClientModel methodsFor: 'getters' stamp: 'G.L.S 7/3/2021 16:56:36'!
usernameText
	
	^username.! !

!LibrosClientModel methodsFor: 'getters' stamp: 'G.L.S 7/3/2021 17:01:29'!
userpasswordText
	
	^userpassword.! !


!classDefinition: #LibrosRestInterface category: 'Ejercicio-Libros'!
Object subclass: #LibrosRestInterface
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!LibrosRestInterface methodsFor: 'private' stamp: 'G.L.S 7/3/2021 18:52:36'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'.! !


!LibrosRestInterface methodsFor: 'url' stamp: 'G.L.S 7/3/2021 18:51:34'!
url
	
	^'http://localhost:', self port asString! !


!LibrosRestInterface methodsFor: 'port' stamp: 'G.L.S 7/3/2021 18:51:55'!
port

	^port ifNil: [port:=8080].! !


!LibrosRestInterface methodsFor: 'requests' stamp: 'G.L.S 7/3/2021 21:07:30'!
sendCreateCartRequestFor: aUsername withPassword: aPassword

	| fieldsDict resp |
	fieldsDict := Dictionary new.
	fieldsDict at: 'clientId' put: aUsername.
	fieldsDict at: 'password' put: aPassword.
	
	resp := WebClient htmlSubmit: (self url, '/createCart') fields: fieldsDict.
	
	resp isSuccess
		ifTrue: [ |decodedResult|
			decodedResult := WebUtils jsonDecode: ((resp content) readStream).
			^(decodedResult copyFrom: 3 to: decodedResult size) asNumber.]
		ifFalse: [^self error: resp content].
	
	"| fieldDict resp urlEncodedSentence |

	urlEncodedSentence := self correctlyEncodeSpacesForUrlRequestParameter: sentence.	
	fieldDict := Dictionary newFromPairs: {'sentence'. urlEncodedSentence.}.		
	
	resp:= WebClient htmlSubmit: (self url,'/words') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection .] 
		ifFalse:[^self error: resp content]."
	
	! !

!LibrosRestInterface methodsFor: 'requests' stamp: 'G.L.S 7/3/2021 20:53:27'!
sendListPurchasesRequestFor: aUsername withPassword: aPassword

	| fieldsDict resp |
	fieldsDict := Dictionary new.
	fieldsDict at: 'clientId' put: aUsername.
	fieldsDict at: 'password' put: aPassword.
	
	resp := WebClient htmlSubmit: (self url, '/listPurchases') fields: fieldsDict.
	
	resp isSuccess
		ifTrue: []
		ifFalse: [^self error: resp content].
	
	! !


!classDefinition: #LibrosServer category: 'Ejercicio-Libros'!
Object subclass: #LibrosServer
	instanceVariableNames: 'mockInterface port webServer storeOF'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!LibrosServer methodsFor: 'private' stamp: 'G.L.S 6/28/2021 21:13:34'!
addInterfaceService: aServiceName withAction: anActionBlock

	webServer addService: aServiceName action: [ 
		:request |
		[anActionBlock value: request]
		on: Error
		do:[ :anError |
			request send400Response: ('1|', anError messageText)]
		].! !

!LibrosServer methodsFor: 'private' stamp: 'G.L.S 7/3/2021 18:19:32'!
port

	^port ifNil: [port:=8080].! !

!LibrosServer methodsFor: 'private' stamp: 'G.L.S 6/29/2021 18:56:18'!
processExpirationDateFrom: aString
	
	| expMonth expYear tempString |
	
	tempString := ''.
			
	aString do:[ :char |
			char = $/ 
			ifTrue:[		expYear := tempString asNumber.
					tempString := ''.]
			ifFalse:[tempString := tempString, char asString]
		].
			
			expMonth := tempString asNumber.
			
	^FixedGregorianDate fromDate: (Date year: expYear month: expMonth day: 1).
! !

!LibrosServer methodsFor: 'private' stamp: 'G.L.S 6/28/2021 21:04:23'!
startAddToCartService.

	self addInterfaceService: '/addToCart' withAction: [
		:request | 
		|cartId bookIsbn bookQuantity result| 
			cartId := (request fields at:'cartId') asNumber.
			bookIsbn := (request fields at:'bookIsbn').
			bookQuantity := (request fields at:'bookQuantity') asNumber.
			
			mockInterface add: bookQuantity ofItem: bookIsbn toCart: cartId.
			
        			result := WebUtils jsonEncode: ('0|', 'OK').
    			request send200Response: result.
		].! !

!LibrosServer methodsFor: 'private' stamp: 'G.L.S 6/29/2021 18:55:27'!
startCheckOutCartService

	self addInterfaceService: '/checkOutCart' withAction: [
		:request | 
		|cartId ccn cced cco resultString result transactionId | 
			cartId := (request fields at:'cartId') asNumber.
			ccn := (request fields at:'ccn').
			cced := self processExpirationDateFrom: (request fields at:'cced').
			cco := (request fields at:'cco'). 
			
			transactionId := mockInterface checkOutCart: cartId  
							withCreditCard: ccn
							withExpirationDate: cced 
							withOwner: cco.
			
			resultString := '0|', transactionId asString.
			
        			result := WebUtils jsonEncode: (resultString).
    			request send200Response: result.
		].
! !

!LibrosServer methodsFor: 'private' stamp: 'G.L.S 6/28/2021 21:01:24'!
startCreateCartService.

	self addInterfaceService: '/createCart' withAction: [ 
		:request |
		|clientId password cartId result| 
			clientId := (request fields at:'clientId').
      			password := (request fields at:'password').
			cartId := mockInterface createCartForUser: clientId password: password.
			
        			result := WebUtils jsonEncode: ('0|', cartId asString).
    			request send200Response: result.
		].! !

!LibrosServer methodsFor: 'private' stamp: 'G.L.S 6/28/2021 21:01:30'!
startListCartService

	self addInterfaceService: '/listCart' withAction: [
		:request | 
		|cartId cartList resultString result|
			
			cartId := (request fields at:'cartId') asNumber.
			cartList := mockInterface listCart: cartId.
			
			resultString := '0|'.
			
			cartList do: [ :cartItem |
					resultString := resultString, cartItem first asString, '|'.
					resultString := resultString, cartItem second asString, '|'.
				].
			
        			result := WebUtils jsonEncode: (resultString).
    			request send200Response: result.
		].! !

!LibrosServer methodsFor: 'private' stamp: 'G.L.S 6/29/2021 19:16:32'!
startListPurchasesService
	
	self addInterfaceService: '/listPurchases' withAction: [
		:request | 
		|clientId password list resultString result | 
			
			clientId := (request fields at:'clientId').
      			password := (request fields at:'password').
			
			list := mockInterface listPurchasesForUser: clientId withPassword: password.
			
			resultString := '0|'.
			
			"self halt."
			
			list keysDo:[ :key |
				resultString := resultString, '|', key, '|', (list at: key) asString, '|'
				].
			
        			result := WebUtils jsonEncode: (resultString).
    			request send200Response: result.
		]
	! !


!LibrosServer methodsFor: 'initialization' stamp: 'G.L.S 6/28/2021 20:50:32'!
initializeWith: aPortNumber
	
	storeOF := StoreObjectFactory new.
	
	mockInterface := storeOF createDefaultMockInterface.
	
	port := aPortNumber.
	
	webServer := WebServer new listenOn: port.
	
	self startCreateCartService.
	self startAddToCartService.
	self startListCartService.
	self startCheckOutCartService.
	self startListPurchasesService.! !


!LibrosServer methodsFor: 'destruction' stamp: 'G.L.S 6/28/2021 19:24:44'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LibrosServer class' category: 'Ejercicio-Libros'!
LibrosServer class
	instanceVariableNames: ''!

!LibrosServer class methodsFor: 'instance creation' stamp: 'G.L.S 6/27/2021 20:47:31'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !


!classDefinition: #MockMerchantProcesor category: 'Ejercicio-Libros'!
Object subclass: #MockMerchantProcesor
	instanceVariableNames: 'stolenCards registeredCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!MockMerchantProcesor methodsFor: 'initialization' stamp: 'G.L.S 6/16/2021 17:04:23'!
initialize

	stolenCards := OrderedCollection new.
	registeredCards := Dictionary new.! !


!MockMerchantProcesor methodsFor: 'operations' stamp: 'G.L.S 6/21/2021 19:35:03'!
can: aCreditCard spend: aTotal
	
	| storedCard |
	
	registeredCards keysDo: [
		:storedCreditCard |
		storedCreditCard = aCreditCard ifTrue: [storedCard := storedCreditCard].
		].
	
	^ (registeredCards at:storedCard) >= aTotal.! !

!MockMerchantProcesor methodsFor: 'operations' stamp: 'G.L.S 6/21/2021 18:47:23'!
isCardRegistered: aCreditCard

	^registeredCards keys includes: aCreditCard.! !

!MockMerchantProcesor methodsFor: 'operations' stamp: 'G.L.S 6/15/2021 18:17:16'!
isCardStolen: aCreditCard

	^stolenCards includes: aCreditCard.! !

!MockMerchantProcesor methodsFor: 'operations' stamp: 'G.L.S 6/16/2021 17:04:50'!
registerCard: aCreditCard withBalance: aBalance  
	registeredCards add: aCreditCard -> aBalance.! !

!MockMerchantProcesor methodsFor: 'operations' stamp: 'G.L.S 6/15/2021 18:19:08'!
registerStolenCard: aCreditCard
	
	stolenCards add: aCreditCard.! !


!classDefinition: #MockRestInterface category: 'Ejercicio-Libros'!
Object subclass: #MockRestInterface
	instanceVariableNames: 'datosUsuarios catalog carts lastId userPurchases timer cartTimers salesBook merchantProcesor transactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!MockRestInterface methodsFor: 'checkout' stamp: 'G.L.S 6/29/2021 19:50:55'!
checkOutCart: aCartId withCreditCard: aCreditCardNumber withExpirationDate: aDate withOwner: anOwner
	
	| cartToCheckout creditCard cashier cartUser |
	
	cartToCheckout := self cartForId: aCartId.
	cartUser := self userOfCart: aCartId.
	creditCard := CreditCard forOwner: anOwner withNumber: aCreditCardNumber withExpirationDate: aDate.
	
	cashier := Cashier withCatalog: catalog.
	
	self assertCartTimerDidNotExpireFor: aCartId.
	
	cashier checkout: cartToCheckout 
		withCreditCard: creditCard 
		onDate: FixedGregorianDate today
		registerOn: salesBook
		forMerchantProcessor: merchantProcesor.
	
	self updatePurchasesFor: cartUser withCart: aCartId withTotal: cartToCheckout totalItemPrice.
	
	self deleteCart: aCartId.
	
	transactionId := transactionId + 1.
	^transactionId.
! !


!MockRestInterface methodsFor: 'private' stamp: 'G.L.S 6/20/2021 19:50:53'!
assertCartExists: aCartID. 

	(carts includesKey: aCartID) ifFalse: [self error: self class errorCartIdDoesNotExist.].! !

!MockRestInterface methodsFor: 'private' stamp: 'G.L.S 6/28/2021 17:57:56'!
assertCartTimerDidNotExpireFor: aCartID

	| cartTimer |
	
	cartTimer := cartTimers at: aCartID.
	
	(timer isDifferenceWith: cartTimer biggerThan: 30) ifTrue: [self error: self class errorCartExpired].
! !

!MockRestInterface methodsFor: 'private' stamp: 'G.L.S 6/21/2021 15:55:13'!
assertUser: aUser existsWithPassword: aPassword.

	((datosUsuarios includesKey: aUser) and: [(datosUsuarios at:aUser) = aPassword]) ifFalse: [self error: self class errorWrongUserCredentials].! !

!MockRestInterface methodsFor: 'private' stamp: 'G.L.S 6/22/2021 17:31:45'!
cartForId: aCartId
	
	self assertCartExists: aCartId.
	^(carts at: aCartId) first.
! !

!MockRestInterface methodsFor: 'private' stamp: 'G.L.S 6/29/2021 19:53:11'!
deleteCart: aCartId
	
	carts removeKey: aCartId.
	cartTimers removeKey: aCartId.! !

!MockRestInterface methodsFor: 'private' stamp: 'G.L.S 6/21/2021 15:42:58'!
listCartItemsFor: aCartItemList
	^aCartItemList.
	! !

!MockRestInterface methodsFor: 'private' stamp: 'G.L.S 6/28/2021 16:35:29'!
updateCartTimerFor: aCartID

	cartTimers at: aCartID put: timer now.
	! !

!MockRestInterface methodsFor: 'private' stamp: 'G.L.S 6/22/2021 18:19:07'!
updatePurchasesFor: aUser withCart: aCartId withTotal: aTotal .
	
	(self listCart: aCartId) do: [
		:aBookAmountTuple |
		(userPurchases at: aUser) at: aBookAmountTuple first 
			ifPresent:[:cant | (userPurchases at: aUser) at: aBookAmountTuple first put: cant + aBookAmountTuple second] 
			ifAbsent:[(userPurchases at: aUser) at: aBookAmountTuple first put: aBookAmountTuple second].
		(userPurchases at:aUser) at: 'totalBooks' put: ((userPurchases at:aUser) at: 'totalBooks') + aTotal.
		].
! !

!MockRestInterface methodsFor: 'private' stamp: 'G.L.S 6/22/2021 17:31:39'!
userOfCart: aCartId

	self assertCartExists: aCartId.
	^(carts at: aCartId) second.
! !


!MockRestInterface methodsFor: 'initialization' stamp: 'G.L.S 6/28/2021 21:37:57'!
initializeFor: aUserDataDictionary withCatalog: aCatalog withTimer: aTimer withSalesBook: aSalesBook withMerchantProcesor: aMerchantProcesor

	datosUsuarios := aUserDataDictionary.
	catalog := aCatalog.
	carts := Dictionary new.
	cartTimers := Dictionary new.
	lastId := 0.
	transactionId := 0.
	
	timer := aTimer.
	salesBook  := aSalesBook.
	merchantProcesor := aMerchantProcesor.
	
	userPurchases := Dictionary new.
	
	datosUsuarios keysDo: [
			:aUserId | 
			userPurchases add: aUserId -> Dictionary new.
			(userPurchases at: aUserId) add: 'totalBooks' -> 0.
		].
	! !


!MockRestInterface methodsFor: 'operations' stamp: 'G.L.S 6/22/2021 18:14:16'!
add: anAmount ofItem: anItemID toCart: aCartID 
	
	| cart |
	
	cart := self cartForId: aCartID.
	
	self assertCartTimerDidNotExpireFor: aCartID.
	
	cart add: anItemID amount: anAmount.
	
	self updateCartTimerFor: aCartID.
	! !

!MockRestInterface methodsFor: 'operations' stamp: 'G.L.S 6/28/2021 16:44:11'!
createCartForUser: aUser password: aPassword 
	
	| newId |
	self assertUser: aUser existsWithPassword: aPassword.
	
	newId := lastId + 1.
	carts add: newId -> OrderedCollection new.
	cartTimers add: newId -> timer now.
	
	(carts at: newId) add: (Cart createNewWithCatalog: catalog).
	(carts at: newId) add: aUser.
	
	lastId := newId.
	
	^newId.! !

!MockRestInterface methodsFor: 'operations' stamp: 'G.L.S 6/28/2021 19:49:23'!
listCart: aCartId 
	
	| cartItemList cart |
	
	"self halt."
	
	cart := self cartForId: aCartId.
	
	self assertCartTimerDidNotExpireFor: aCartId.
	
	cartItemList := cart itemListFor: self.
	
	self updateCartTimerFor: aCartId.
	
	^cartItemList.! !

!MockRestInterface methodsFor: 'operations' stamp: 'G.L.S 6/21/2021 17:33:33'!
listPurchasesForUser: aUser withPassword: aPassword 
	
	self assertUser: aUser existsWithPassword: aPassword.
	
	^userPurchases at: aUser.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockRestInterface class' category: 'Ejercicio-Libros'!
MockRestInterface class
	instanceVariableNames: ''!

!MockRestInterface class methodsFor: 'error handling' stamp: 'G.L.S 6/28/2021 21:21:36'!
createFor: aUserDataDictionary withCatalog: aCatalog withTimer: aTimer withSalesBook: aSalesBook withMerchantProcesor: aMerchantProcesor

	^self new initializeFor: aUserDataDictionary withCatalog: aCatalog withTimer: aTimer withSalesBook: aSalesBook withMerchantProcesor: aMerchantProcesor.! !

!MockRestInterface class methodsFor: 'error handling' stamp: 'G.L.S 6/22/2021 18:07:18'!
errorCartExpired
	^ 'Error - El carrito utilizado expiró'.! !

!MockRestInterface class methodsFor: 'error handling' stamp: 'G.L.S 6/20/2021 18:01:47'!
errorCartIdDoesNotExist
	^'Error - No existe un carrito con esa ID'.! !

!MockRestInterface class methodsFor: 'error handling' stamp: 'G.L.S 6/17/2021 21:24:23'!
errorWrongUserCredentials
	^'Error - Las credenciales del usuario no son correctas'.! !


!classDefinition: #MockTimer category: 'Ejercicio-Libros'!
Object subclass: #MockTimer
	instanceVariableNames: 'currentTime manualyPased'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!MockTimer methodsFor: 'initialization' stamp: 'G.L.S 6/28/2021 17:59:17'!
initialize

	self initialize: DateAndTime now.! !

!MockTimer methodsFor: 'initialization' stamp: 'G.L.S 6/28/2021 17:59:27'!
initialize: aTime

	currentTime := aTime.
	manualyPased  := false.! !


!MockTimer methodsFor: 'operation' stamp: 'G.L.S 6/28/2021 18:00:43'!
isDifferenceWith: aTimer biggerThan: anAmountOfTime
	|actualTimer|
	actualTimer  := manualyPased ifTrue: [currentTime] ifFalse: [self now].
	^((actualTimer - aTimer) minutes abs > anAmountOfTime).
	
	! !

!MockTimer methodsFor: 'operation' stamp: 'G.L.S 6/28/2021 17:55:42'!
now
	currentTime := DateAndTime now.
	^currentTime.! !

!MockTimer methodsFor: 'operation' stamp: 'G.L.S 6/28/2021 19:04:32'!
passTime: anAmontOfTime

	self now.
	currentTime := currentTime + anAmontOfTime minutes.
	manualyPased := true.! !


!classDefinition: #StoreObjectFactory category: 'Ejercicio-Libros'!
Object subclass: #StoreObjectFactory
	instanceVariableNames: 'smalltalk80 designPatterns objectThinking donQuixote workingCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 15:56:21'!
createDefaultCatalog

	| catalog |
	
	catalog := Dictionary new.
	catalog add: smalltalk80 -> 10.
	catalog add: designPatterns -> 100.
	catalog add: objectThinking -> 50.
	
	^catalog! !

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 21:32:32'!
createDefaultMerchantProcesor

	| merchantProcessor |
	
	merchantProcessor := MockMerchantProcesor new.
	merchantProcessor registerCard: workingCreditCard withBalance: 1000.
	
	^merchantProcessor.! !

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 21:22:41'!
createDefaultMockInterface

	| mockInterface |
	
	mockInterface := MockRestInterface createFor: self createDefaultUserData 
					withCatalog: self createDefaultCatalog 
					withTimer: self createDefaultMockTimer
					withSalesBook: self createDefaultSalesBook 
					withMerchantProcesor: self createDefaultMerchantProcesor.
	
	^mockInterface! !

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 16:15:41'!
createDefaultMockTimer

	^MockTimer new.! !

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 15:58:19'!
createDefaultSalesBook

	^ OrderedCollection new.! !

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 16:16:05'!
createDefaultTimer

	self shouldBeImplemented.! !

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 16:01:32'!
createDefaultUserData
	
	| userData |
	
	userData := Dictionary new.
	userData add: 'pepe' -> '5678'.
	userData add: 'ramon' -> '1234'.
	
	^ userData.! !

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 16:03:05'!
createEmptyCatalog

	^Dictionary new.! !

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 21:22:04'!
createMerchantProcesor

	^MockMerchantProcesor new.! !

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 16:06:09'!
createSingleItemCatalog

	| catalog |
	
	catalog := Dictionary new.
	catalog add: donQuixote -> 50.
	
	^catalog! !

!StoreObjectFactory methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/28/2021 21:32:27'!
initialize

	smalltalk80 := '9780201113723'.
	designPatterns := '9780201184624'.
	objectThinking := '9780735619654'.
	donQuixote := '9781400132171'.
	
	workingCreditCard := CreditCard forOwner: 'Marco' withNumber: '0000000000000000' withExpirationDate: FixedGregorianDate tomorrow.! !
