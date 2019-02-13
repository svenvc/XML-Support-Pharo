"
I am BaselineOfXMLWriter.
I am a BaselineOf.
"
Class {
	#name : #BaselineOfXMLWriter,
	#superclass : #BaselineOf,
	#category : #BaselineOfXMLWriter
}

{ #category : #baselines }
BaselineOfXMLWriter >> baselineOf: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec baseline: 'OrderPreservingDictionary' with: [ spec repository: 'github://svenvc/XML-Support-Pharo' ].
			spec package: 'XML-Writer-Core' with: [ spec requires: #('OrderPreservingDictionary') ].
			spec package: 'XML-Writer-Tests' with: [ spec requires: #('XML-Writer-Core') ].
			spec group: 'default' with: #('core' 'tests').
			spec group: 'core' with: #('XML-Writer-Core').
			spec group: 'tests' with: #('XML-Writer-Tests') ]
]
