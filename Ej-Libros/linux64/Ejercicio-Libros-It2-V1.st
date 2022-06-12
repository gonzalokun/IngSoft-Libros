!classDefinition: #CartTest category: 'Ejercicio-Libros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'smalltalk80 designPatterns objectThinking'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/9/2021 18:50:37'!
setUp

	smalltalk80 := '9780201113723'.
	designPatterns := '9780201184624'.
	objectThinking := '9780735619654'.! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/10/2021 14:06:27'!
test01CartThatWasJustCreatedIsEmpty

	| carrito |
	
	carrito := Cart createNewWithAllowedList: ''.
	
	self assert: carrito isEmpty.
	! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/10/2021 14:07:00'!
test02CartWithAnItemIsNotEmpty

	| carrito librosValidos |
	
	librosValidos := OrderedCollection new.
	librosValidos add: smalltalk80 .
	
	carrito := Cart createNewWithAllowedList: librosValidos.
	carrito add: smalltalk80.
	
	self deny: carrito isEmpty.
	! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/10/2021 17:48:49'!
test03CartWithSeveralItemsAddedContainsTheRightItemsAndAmounts

	| carrito tuplaLibroCant librosValidos |
	
	librosValidos := OrderedCollection new.
	librosValidos add: smalltalk80.
	librosValidos add: designPatterns.
	
	carrito := Cart createNewWithAllowedList: librosValidos.
		
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

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/10/2021 15:00:22'!
test04CartCannotAddItemsThatAreNotAllowed
		
	self testCartFailToAdd: smalltalk80 
		withAmount: 1
		whileAllowing: {designPatterns.}  
		expectingErrorMessage: Cart errorBookNotInAllowedList.
	! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/10/2021 14:59:42'!
test05CartCannotAddANonIntegerAmountOfAnItem
	
	self testCartFailToAdd: smalltalk80 
		withAmount: 1.5
		whileAllowing: {smalltalk80.}  
		expectingErrorMessage: Cart errorAmountNotInteger.
	! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/10/2021 14:59:07'!
test06CartCannotAddANegativeAmountOfAnItem
	
	self testCartFailToAdd: smalltalk80 
		withAmount: -1
		whileAllowing: {smalltalk80.}  
		expectingErrorMessage: Cart errorAmountNegative.! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/10/2021 14:58:29'!
test07CartCannotAddAZeroAmountOfAnItem
	
	self testCartFailToAdd: smalltalk80 
		withAmount: 0
		whileAllowing: {smalltalk80.}  
		expectingErrorMessage: Cart errorAmountZero.
	! !

!CartTest methodsFor: 'testing' stamp: 'G.L.S 6/10/2021 14:56:14'!
testCartFailToAdd: aBook withAmount: anAmount whileAllowing: aBookList expectingErrorMessage: anErrorMessage

	| carrito librosValidos |
	
	librosValidos := OrderedCollection new.
	aBookList do: [:aBookToAllow | librosValidos add: aBookToAllow.].
	
	carrito := Cart createNewWithAllowedList: librosValidos.
	
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
	instanceVariableNames: 'smalltalk80 designPatterns objectThinking catalog1 emptyCatalog catalog2 donQuixote workingCreditCard expiredCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/14/2021 19:32:27'!
setUp

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
	
	workingCreditCard := CreditCard forOwner: 'Marco' withNumber: '0000000000000000' withExpirationDate: FixedGregorianDate tomorrow.
	expiredCreditCard := CreditCard forOwner: 'Jorge' withNumber: '0000000000000000' withExpirationDate: FixedGregorianDate yesterday.! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/14/2021 19:52:02'!
test01CashierCannotCheckoutWithAnEmptyCart
	
	| cart cashier |
	
	cashier := Cashier new.
	
	cart := Cart createNewWithAllowedList: emptyCatalog.
	
	self should: [cashier checkout: cart withCreditCard: workingCreditCard onDate: FixedGregorianDate today]
		raise: Error 
		withExceptionDo: [
			:anError | 
			self assert: anError messageText = Cashier errorCannotCheckoutEmptyCart.
			].! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/14/2021 19:52:02'!
test02CashierCannotCheckoutWithACartWithThatDoesntHaveAMatchingCatalog
	
	| cart cashier |
	
	cashier := Cashier withCatalog: catalog1.
	
	cart := Cart createNewWithAllowedList: catalog2.
	cart add: donQuixote.
	
	self should: [cashier checkout: cart withCreditCard: workingCreditCard onDate: FixedGregorianDate today]
		raise: Error 
		withExceptionDo: [
			:anError | 
			self assert: anError messageText = Cashier errorCannotCheckoutACartWithADifferentCatalog.
			].! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/14/2021 19:52:02'!
test03CheckoutReturnsTheRightAmount
	
	| cart cashier result |
	
	cashier := Cashier withCatalog: catalog1.
	
	cart := Cart createNewWithAllowedList: catalog1 .
	cart add: smalltalk80 amount: 3.
	cart add: designPatterns amount: 5.
	
	result := cashier checkout: cart withCreditCard: workingCreditCard onDate: FixedGregorianDate today.
	
	self assert: 530 equals: result.! !

!CashierTest methodsFor: 'testing' stamp: 'G.L.S 6/14/2021 19:52:01'!
test04CashierCannotCheckOutWithAnExpiredCard
	
	| cart cashier |
	
	cashier := Cashier withCatalog: catalog1.
	
	cart := Cart createNewWithAllowedList: catalog1 .
	cart add: smalltalk80 amount: 3.
	cart add: designPatterns amount: 5.
	
	self should: [cashier checkout: cart withCreditCard: expiredCreditCard onDate: FixedGregorianDate today.]  
		raise: Error 
		withExceptionDo: [
			:anError |
			self assert: anError messageText = Cashier errorExpiredCard.
			]
	! !


!classDefinition: #CreditCardTest category: 'Ejercicio-Libros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Libros'!

!CreditCardTest methodsFor: 'testing' stamp: 'G.L.S 6/14/2021 21:22:56'!
test01CreditCardCannotHaveEmptyOwner
	
	self should: [CreditCard forOwner: '' withNumber: '0000000000000000'  withExpirationDate: FixedGregorianDate today]  
		raise: Error - MessageNotUnderstood
		withExceptionDo: [
			:anError |
			self assert: anError messageText = CreditCard errorOwnerEmpty].! !

!CreditCardTest methodsFor: 'testing' stamp: 'G.L.S 6/14/2021 21:28:17'!
test02CreditCardNumberForACreditCardCannotHaveLessThan16Digits
	
	self should: [CreditCard forOwner: 'Jorge' withNumber: ''  withExpirationDate: FixedGregorianDate today]  
		raise: Error - MessageNotUnderstood
		withExceptionDo: [
			:anError |
			self assert: anError messageText = CreditCard errorCardNumberLessThan16Digits].! !

!CreditCardTest methodsFor: 'testing' stamp: 'G.L.S 6/14/2021 21:32:19'!
test03CreditCardNumberForACreditCardCannotHaveMoreThan16Digits
	
	self should: [CreditCard forOwner: 'Jorge' withNumber: '00000000000000001'  withExpirationDate: FixedGregorianDate today]  
		raise: Error - MessageNotUnderstood
		withExceptionDo: [
			:anError |
			self assert: anError messageText = CreditCard errorCardNumberMoreThan16Digits].! !


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


!Cart methodsFor: 'initialization' stamp: 'G.L.S 6/14/2021 19:08:24'!
initializeWith: anOrderedCollection
	catalog := anOrderedCollection.
	cartItems := OrderedCollection new.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/14/2021 19:08:24'!
totalItemPrice
	
	^cartItems sum: [:bookAmountTuple | (catalog at: bookAmountTuple first) * bookAmountTuple second].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Ejercicio-Libros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'G.L.S 6/9/2021 18:32:52'!
createNewWithAllowedList: anOrderedCollection 
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

!Cashier methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/14/2021 19:54:34'!
assertCard: aCreditCard hasNotExpiredOn: aDate.
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: self class errorExpiredCard].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/10/2021 20:49:32'!
assertCartHasTheSameCatalog: aCart

	(aCart hasCatalog: catalog) ifFalse: [self error: self class errorCannotCheckoutACartWithADifferentCatalog].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/10/2021 20:33:20'!
assertCartIsNotEmpty: aCart
	
	aCart isEmpty ifTrue: [self error: self class errorCannotCheckoutEmptyCart].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'G.L.S 6/14/2021 19:54:34'!
checkout: aCart withCreditCard: aCreditCard onDate: aDate  
	
	self assertCartIsNotEmpty: aCart.
	self assertCartHasTheSameCatalog: aCart.
	self assertCard: aCreditCard hasNotExpiredOn: aDate.
	
	^aCart totalItemPrice.! !


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

!Cashier class methodsFor: 'errors' stamp: 'G.L.S 6/14/2021 19:41:47'!
errorExpiredCard
	^'Error - No se puede hacer checkout con una tarjeta de crédito vacía'.! !


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


!CreditCard methodsFor: 'private' stamp: 'G.L.S 6/14/2021 21:25:06'!
assertNameNotEmpty: anOwner
	
	anOwner withBlanksTrimmed isEmpty ifTrue: [self error: self class errorOwnerEmpty].! !


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
