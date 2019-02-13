"
I am BaselineOfXMLParser.
I am a BaselineOf.
"
Class {
	#name : #BaselineOfXMLParser,
	#superclass : #BaselineOf,
	#category : #BaselineOfXMLParser
}

{ #category : #baselines }
BaselineOfXMLParser >> baselineOf: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec baseline: 'OrderPreservingDictionary' with: [ spec repository: 'github://svenvc/XML-Support-Pharo' ].
			spec baseline: 'BitmapCharacterSet' with: [ spec repository: 'github://svenvc/XML-Support-Pharo' ].
			spec baseline: 'XMLWriter' with: [ spec repository: 'github://svenvc/XML-Support-Pharo' ].
			spec package: 'XML-Parser' with: [ spec requires: #('OrderPreservingDictionary' 'BitmapCharacterSet') ].
			spec package: 'XML-ParserGTExtensions' with: [ spec requires: #('XML-Parser' 'XMLWriter') ].
			spec package: 'XML-Tests-Parser' with: [ spec requires: #('XML-Parser') ].
			spec group: 'default' with: #('core' 'gt' 'tests').
			spec group: 'core' with: #('XML-Parser').
			spec group: 'gt' with: #('XML-ParserGTExtensions').
			spec group: 'tests' with: #('XML-Tests-Parser') ]
]
