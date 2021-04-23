Class {
	#name : #JbWhileLoopNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbWhileLoopNode >> condition [
	^ condition
]

{ #category : #accessing }
JbWhileLoopNode >> condition: anObject [
	condition := anObject
]

{ #category : #'as yet unclassified' }
JbWhileLoopNode >> executeIn: anEnvironment [
	[ condition evaluateIn: anEnvironment ]
		whileTrue: [ trueStatements do: [ :each | each executeIn: anEnvironment ] ]
]

{ #category : #accessing }
JbWhileLoopNode >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbWhileLoopNode >> trueStatements: anObject [
	trueStatements := anObject
]
