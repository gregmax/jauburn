Class {
	#name : #JbFunctionCallNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'arguments'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbFunctionCallNode >> arguments [
	^ arguments
]

{ #category : #accessing }
JbFunctionCallNode >> arguments: anObject [
	arguments := anObject
]

{ #category : #'as yet unclassified' }
JbFunctionCallNode >> evaluateIn: anEnvironment [
	| myFunc |
	"Retrieve JbFunction from environment, send call: in: message to JbFunction"
	myFunc := (anEnvironment at: identifier).
	anEnvironment associations.
	myFunc call: (arguments collect: [ :each | each evaluateIn: anEnvironment ]) in: anEnvironment.
	^myFunc.
]

{ #category : #'as yet unclassified' }
JbFunctionCallNode >> executeIn: anEnvironment [
	^ self evaluateIn: anEnvironment
]

{ #category : #accessing }
JbFunctionCallNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbFunctionCallNode >> identifier: anObject [
	identifier := anObject
]
