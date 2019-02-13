"
I am BaselineOfOrderPreservingDictionary.
I am a BaselineOf.
"
Class {
	#name : #BaselineOfOrderPreservingDictionary,
	#superclass : #BaselineOf,
	#category : #BaselineOfOrderPreservingDictionary
}

{ #category : #baselines }
BaselineOfOrderPreservingDictionary >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'Collections-OrderPreservingDictionary';
				package: 'Collections-OrderPreservingDictionaryGTExtensions' with: [ spec requires: #('Collections-OrderPreservingDictionary') ];
				package: 'Collections-Tests-OrderPreservingDictionary' with: [ spec requires: #('Collections-OrderPreservingDictionary') ];
				group: 'default' with: #('core' 'gt' 'tests');
				group: 'core' with: #('Collections-OrderPreservingDictionary');
				group: 'gt' with: #('Collections-OrderPreservingDictionaryGTExtensions');
				group: 'tests' with: #('Collections-Tests-OrderPreservingDictionary') ]
]
