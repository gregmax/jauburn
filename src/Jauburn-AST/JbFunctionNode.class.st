Class {
	#name : #JbFunctionNode,
	#superclass : #Object,
	#instVars : [
		'body',
		'parameters'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbFunctionNode >> body [
	^ body
]

{ #category : #accessing }
JbFunctionNode >> body: anObject [
	body := anObject
]

{ #category : #'as yet unclassified' }
JbFunctionNode >> evaluateIn: anEnvironment [
	| myFunc |
	myFunc := JbFunction new.
	myFunc parameters: (parameters collect: [ :each | each identifier ]).
	myFunc body: body.
	myFunc environment: anEnvironment.
	^myFunc.

]

{ #category : #'as yet unclassified' }
JbFunctionNode >> executeIn: anEnvironment [
	| myFunc |
	myFunc := JbFunction new.
	myFunc parameters: (parameters collect: [ :each | each identifier ]).
	myFunc body: body.
	myFunc environment: anEnvironment.
	^myFunc.

]

{ #category : #accessing }
JbFunctionNode >> parameters [
	^ parameters
]

{ #category : #accessing }
JbFunctionNode >> parameters: anObject [
	parameters := anObject
]
