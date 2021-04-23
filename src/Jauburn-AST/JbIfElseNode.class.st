Class {
	#name : #JbIfElseNode,
	#superclass : #JbIfNode,
	#instVars : [
		'falseStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #'as yet unclassified' }
JbIfElseNode >> executeIn: environment [
	| value |
	value := (self condition evaluateIn: environment).
	value ifTrue: [ trueStatements do: 
			[ :statement | statement executeIn: environment ]
			]
			ifFalse: [ falseStatements do: 
			[ :statement | statement executeIn: environment ]
			]
]

{ #category : #accessing }
JbIfElseNode >> falseStatements [
	^ falseStatements
]

{ #category : #accessing }
JbIfElseNode >> falseStatements: anObject [
	falseStatements := anObject
]
