Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var x = 4 - 2;'.
	self assert: (interpreter environment at: 'x') equals: 2.
	
	self interpret: 'var x = -2;'.
	self assert: (interpreter environment at: 'x') equals: -2.
		
	self interpret: 'var x = 4 < 2;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 4 <= 4;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 2 <= 4;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 4 > 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 4 >= 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 4 >= 4;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 4 == 2;'.
	self deny: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 4 == 4;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 4 != 4;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 4 != 12;'.
	self assert: (interpreter environment at: 'x') equals: true.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testFunctionCallNode [

	self interpret: 'var x = 0;var f = function() { x = 1; };f();'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = 0;var f = function(a,b,c) { x = a + b + c; };f(3,4,5);'.
	self assert: (interpreter environment at: 'x') equals: 12.
	
"	self interpret: 'var f = function() { return 20; }; var x = f();'.
	self assert: (interpreter environment at: 'x') equals: 20."
	
	
]

{ #category : #tests }
JbInterpreterTest >> testFunctionNode [

	self interpret: 'var x = function() { };'.
	self assert: (interpreter environment at: 'x') class equals: JbFunction.
	self assert: (interpreter environment at: 'x') parameters size equals: 0.
	self assert: (interpreter environment at: 'x') body size equals: 0.
	self assert: (interpreter environment at: 'x') environment notNil.
	
	self interpret: 'x = function(a, b, c) { };'.
	self assert: (interpreter environment at: 'x') parameters size equals: 3.
	self assert: (interpreter environment at: 'x') parameters first equals: 'a'.
	self assert: (interpreter environment at: 'x') parameters second equals: 'b'.
	self assert: (interpreter environment at: 'x') parameters third equals: 'c'.
	
	self interpret: 'var x = function() { var y = 0; y = 1; };'.
	self assert: (interpreter environment at: 'x') body size equals: 2.
	self assert: (interpreter environment at: 'x') body first class equals: JbVariableDeclarationStatementNode.
	self assert: (interpreter environment at: 'x') body second class equals: JbAssignmentStatementNode.
	
	self interpret: 'var z = 5; var x = function() { var y = 0; y = 1; };'.
	self assert: (interpreter environment at: 'x') environment size equals: 2.
	self assert: ((interpreter environment at: 'x') environment at: 'z') equals: 5.
	
]

{ #category : #tests }
JbInterpreterTest >> testIfElseStatement [

	self interpret: 'var x = 0; if (true) { x = 5; } else { x = 7; };'.
	self assert: (interpreter environment at: 'x') equals: 5.
	
	self interpret: 'var x = 0; if (false) { x = 5; } else { x = 7; };'.
	self assert: (interpreter environment at: 'x') equals: 7.
]

{ #category : #tests }
JbInterpreterTest >> testIfStatement [

	self interpret: 'var x = 0; if (true) { x = 5; };'.
	self assert: (interpreter environment at: 'x') equals: 5.
	
	self interpret: 'var x = 0; if (false) { x = 5; };'.
	self assert: (interpreter environment at: 'x') equals: 0.
]

{ #category : #tests }
JbInterpreterTest >> testPrimitivesAbs [

	self interpret: 'var x = abs(-5);'.
	self assert: (interpreter environment at: 'x') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testPrimitivesConcat [

	self interpret: 'var x = concat("hello","world");'.
	self assert: (interpreter environment at: 'x') equals: 'helloworld'.
]

{ #category : #tests }
JbInterpreterTest >> testPrimitivesLength [

	self interpret: 'var x = length("hello");'.
	self assert: (interpreter environment at: 'x') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testPrimitivesMod [

	self interpret: 'var x = mod(6, 3);'.
	self assert: (interpreter environment at: 'x') equals: 0.
]

{ #category : #tests }
JbInterpreterTest >> testPrimitivesNot [

	self interpret: 'var x = not(true);'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testPrimitivesPrintln [

	self interpret: 'var x = println("knock knock");'.
	self assert: (interpreter environment at: 'x') equals: 'knock knock'.
]

{ #category : #tests }
JbInterpreterTest >> testWhileLoop [

	self interpret: 'var x = 1; var y = 0; while (x <= 10) { y = y + x; x = x + 1; }'.
	self assert: (interpreter environment at: 'y') equals: 55.
]
