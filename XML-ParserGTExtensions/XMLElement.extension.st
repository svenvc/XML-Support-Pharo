Extension { #name : #XMLElement }

{ #category : #'*XML-ParserGTExtensions' }
XMLElement >> formForImageEntity: imageEntity [
  | imageType parserClassName parserClass parser |
  imageType := imageEntity contentType sub.
  parserClassName := imageType asUppercase, #ReadWriter.
  parserClass := Smalltalk globals at: parserClassName asSymbol.
  parser := parserClass on: imageEntity readStream.
    ^ parser nextImage
]

{ #category : #'*XML-ParserGTExtensions' }
XMLElement class >> gtExampleXmlNode [
	<gtExample>
	^ XMLDocument gtExampleXmlNode firstElement
]

{ #category : #'*XML-ParserGTExtensions' }
XMLElement >> gtInspectorAttributesIn: aComposite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 3>
	
	aComposite table
		when: [ self hasAttributes ];
		title: 'Attributes';
		display: [ self attributeNodes ];
		column: 'Name' evaluated: #name;
		column: 'Value' evaluated: #value
]

{ #category : #'*XML-ParserGTExtensions' }
XMLElement >> gtInspectorImageIn: composite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 40>
	| client url |
	aGTInspector panes size > 1
		ifFalse: [ ^ self ].
	client := (aGTInspector panes reversed collect: [ :each | (each port: #entity) value ])
		detect: [ :each | (each isKindOf: ZnClient) and: [ each request notNil ] ]
		ifNone: [ ^ self ].
	url := client request absoluteUrl.
	^ composite morph
		title: 'Image';
		display:
				[ self
				formForImageEntity:
					(ZnClient new
						beOneShot;
						get: url / (self attributeAt: 'src');
						entity) ];
		when: [ (self isNamed: 'img') and: [ self includesAttribute: 'src' ] ]
]

{ #category : #'*XML-ParserGTExtensions' }
XMLElement >> supportsRemoveAction [
	^ self hasParent
		and: [self parent isDocument not]
]

{ #category : #'*XML-ParserGTExtensions' }
XMLElement >> supportsSourceEditing [
	^ self hasParent
]

{ #category : #'*XML-ParserGTExtensions' }
XMLElement >> writeTreeViewLabelXMLOn: aWriter [
	self supportsTreeView
		ifTrue: [
			"write just an unclosed start tag if the element can be expanded
			to display tree view children"
			aWriter startTag
				name: self name;
				"uses setAttributes: for performance"
				setAttributes: attributes]
		ifFalse: [| tagWriter |
			(tagWriter := aWriter tag)
				name: self name;
				"uses setAttributes: for performance"
				setAttributes: attributes.
			"a non-expandable element can still have chilren (string nodes) that
			need to be written"
			self hasChildren
				ifTrue: [
					tagWriter with: [
						self writeInnerXMLOn: aWriter]]]
]
