"
I am BaselineOfBitMapCharacterSet.
I am a BaselineOf.
"
Class {
	#name : #BaselineOfBitMapCharacterSet,
	#superclass : #BaselineOf,
	#category : #BaselineOfBitMapCharacterSet
}

{ #category : #baselines }
BaselineOfBitMapCharacterSet >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'Collections-BitmapCharacterSet';
				package: 'Collections-Tests-BitmapCharacterSet' with: [ spec requires: #('Collections-BitmapCharacterSet') ];
				group: 'default' with: #('core' 'tests');
				group: 'core' with: #('Collections-BitmapCharacterSet');
				group: 'tests' with: #('Collections-Tests-BitmapCharacterSet') ]
]
