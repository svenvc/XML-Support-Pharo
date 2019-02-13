Class {
	#name : #BitmapCharacterSetTest,
	#superclass : #TestCase,
	#instVars : [
		'characters'
	],
	#category : #'Collections-Tests-BitmapCharacterSet'
}

{ #category : #enumerating }
BitmapCharacterSetTest >> absentCharactersDo: aBlock [
	| previousValue |

	previousValue := 0.
	self charactersDo: [:each |
		previousValue + 1 to: each asciiValue - 1 do: [:i |
			aBlock value: i asCharacter].
		previousValue := each asciiValue].

	previousValue + 1 to: self lastCodePoint - 1 do: [:i |
		aBlock value: i asCharacter].
]

{ #category : #asserting }
BitmapCharacterSetTest >> assertSet: aFirstSet copiedFrom: aSecondSet equals: aThirdSet [
	self
		deny: aFirstSet == aSecondSet;
		deny: aFirstSet byteCharacters == aSecondSet byteCharacters.
	(aFirstSet wideCharacters notNil
		or: [aSecondSet wideCharacters notNil])
		ifTrue: [self deny: aFirstSet wideCharacters == aSecondSet wideCharacters].
	
	self assert: aFirstSet = aThirdSet.
]

{ #category : #accessing }
BitmapCharacterSetTest >> characters [
	^ characters
		ifNil: [| writeStream previousValue offset |
			writeStream := (Array new: 250000) writeStream.
			previousValue := 0.
			writeStream nextPut: previousValue asCharacter.
			offset := 1.
			1 to: self lastCodePoint do: [:i |
				previousValue + offset = i
					ifTrue: [
						writeStream nextPut: i asCharacter.
						previousValue := i.
						offset :=
							offset = 8
								ifTrue: [1]
								ifFalse: [offset + 1]]].
			characters := writeStream contents]
]

{ #category : #enumerating }
BitmapCharacterSetTest >> charactersDo: aBlock [
	self characters do: aBlock
]

{ #category : #accessing }
BitmapCharacterSetTest >> emptySet [
	^ self setClass new
]

{ #category : #accessing }
BitmapCharacterSetTest >> lastCodePoint [
	^ 16r10FFFF
]

{ #category : #accessing }
BitmapCharacterSetTest >> nonEmptySet [
	^ self setClass newFrom: self characters
]

{ #category : #accessing }
BitmapCharacterSetTest >> rangeCharacters [
	^ 'abcdefghijklmnopqrstuvwxyz'
]

{ #category : #accessing }
BitmapCharacterSetTest >> rangeStart [
	^ self rangeCharacters first
]

{ #category : #accessing }
BitmapCharacterSetTest >> rangeStop [
	^ self rangeCharacters last
]

{ #category : #accessing }
BitmapCharacterSetTest >> setClass [
	^ BitmapCharacterSet
]

{ #category : #tests }
BitmapCharacterSetTest >> testAdd [
	| set |

	set := self emptySet.
	self charactersDo: [:each |
		self
			deny: (set includes: each);
			assert: (set add: each) = each;
			assert: (set includes: each);
			assert: (set add: each) = each;
			assert: (set includes: each)].
]

{ #category : #tests }
BitmapCharacterSetTest >> testAddRangeFromTo [
	| set |

	set := self emptySet.
	self "empty range, because from > to"
		assert: (set addRangeFrom: self rangeStop to: self rangeStart) == set;
		assert: set isEmpty.

	self
		assert: (set addRangeFrom: self rangeStart to: self rangeStop) == set;
		assert: set = (self setClass newFrom: self rangeCharacters).

	set := self emptySet.
	self
		assert: (set addRangeFrom: self rangeStart to: self rangeStart) == set;
		assert: set = (self setClass with: self rangeStart).
]

{ #category : #tests }
BitmapCharacterSetTest >> testByteCharactersDo [
	| set enumerated |

	set := self emptySet.
	enumerated := OrderedCollection new.

	set byteCharactersDo: [:each | enumerated addLast: each].
	self assert: enumerated isEmpty.

	set addAll: self characters.
	set byteCharactersDo: [:each | enumerated addLast: each].
	self assert: enumerated notEmpty.
	enumerated withIndexDo: [:each :i |
		self
			assert: each asciiValue < 256;
			assert: each = (self characters at: i)].
]

{ #category : #tests }
BitmapCharacterSetTest >> testCapacity [
	"Since the bitmap is allocated in bytes, the last byte can have excess capacity
	even when a specific capacity is specified."

	self
		assert: (self setClass new: 0) capacity = 256;
		assert: (self setClass new: 256) capacity = 256.
	257 to: 264 do: [:i |
		self assert: (self setClass new: i) capacity = 264].
	265 to: 272 do: [:i |
		self assert: (self setClass new: i) capacity = 272].
]

{ #category : #tests }
BitmapCharacterSetTest >> testComplement [
	| set complement |

	set := self nonEmptySet.
	complement := set complement.
	self deny: set = complement.
	self charactersDo: [:each |
		self
			assert: (set includes: each);
			deny: (complement includes: each)].
	self absentCharactersDo: [:each |
		self
			deny: (set includes: each);
			assert: (complement includes: each)].

	self assert: complement complement = set.
]

{ #category : #tests }
BitmapCharacterSetTest >> testConcatenation [
	| set |

	set := self emptySet.
	self
		assertSet: set, self nonEmptySet
		copiedFrom: set
		equals: self nonEmptySet.

	set := self nonEmptySet.
	self
		assertSet: set, self emptySet
		copiedFrom: set
		equals: self nonEmptySet.
	self
		assertSet: set, self nonEmptySet
		copiedFrom: set
		equals: self nonEmptySet.
]

{ #category : #tests }
BitmapCharacterSetTest >> testCopy [
	| set |

	set := self emptySet.
	self
		assertSet: set copy
		copiedFrom: set
		equals: self emptySet.

	set := self nonEmptySet.
	self
		assertSet: set copy
		copiedFrom: set
		equals: self nonEmptySet.
]

{ #category : #tests }
BitmapCharacterSetTest >> testCopyEmpty [
	| set |

	set := self emptySet.
	self
		assertSet: set copyEmpty
		copiedFrom: set
		equals: self emptySet.

	set := self nonEmptySet.
	self
		assertSet: set copyEmpty
		copiedFrom: set
		equals: self emptySet.
]

{ #category : #tests }
BitmapCharacterSetTest >> testDo [
	| set enumerated |

	set := self emptySet.
	enumerated := OrderedCollection new.

	set do: [:each | enumerated addLast: each].
	self assert: enumerated isEmpty.

	set addAll: self characters.
	set do: [:each | enumerated addLast: each].
	self assert: enumerated size = self characters size.
	enumerated
		with: self characters
		do: [:enumeratedChar :expectedChar |
			self assert: enumeratedChar = expectedChar]
]

{ #category : #tests }
BitmapCharacterSetTest >> testEquals [
	self
		assert: self emptySet = self emptySet;
		assert: self nonEmptySet = self nonEmptySet;
		deny: self emptySet = self nonEmptySet;
		deny: self nonEmptySet = self emptySet
]

{ #category : #tests }
BitmapCharacterSetTest >> testHasWideCharacters [
	| set |

	set := self emptySet.
	self deny: set hasWideCharacters.

	set add: 255 asCharacter.
	self deny: set hasWideCharacters.

	set add: 256 asCharacter.
	self assert: set hasWideCharacters.

	set remove: 256 asCharacter.
	self deny: set hasWideCharacters.
]

{ #category : #tests }
BitmapCharacterSetTest >> testHash [
	self
		assert: self emptySet hash = self emptySet hash;
		assert: self nonEmptySet hash = self nonEmptySet hash
]

{ #category : #tests }
BitmapCharacterSetTest >> testIncludes [
	| set |

	set := self emptySet.
	self
		charactersDo: [:each | self deny: (set includes: each)];
		absentCharactersDo: [:each | self deny: (set includes: each)].

	set := self nonEmptySet.
	self
		charactersDo: [:each | self assert: (set includes: each)];
		absentCharactersDo: [:each | self deny: (set includes: each)].
]

{ #category : #tests }
BitmapCharacterSetTest >> testIncludesRangeFromTo [
	| set |

	set := self emptySet.
	self rangeCharacters do: [:each |
		self
			deny: (set includesRangeFrom: self rangeStart to: self rangeStop);
			assert: (set includesRangeFrom: self rangeStop to: self rangeStart).
		set add: each].
	self
		assert: (set includesRangeFrom: self rangeStart to: self rangeStop);
		assert: (set includesRangeFrom: self rangeStop to: self rangeStart).
]

{ #category : #tests }
BitmapCharacterSetTest >> testMaxCapacity [
	| maxCapacity set |

	maxCapacity := self lastCodePoint + 1.

	set := self setClass new: maxCapacity.
	self assert: set capacity = maxCapacity.

	set := self setClass new: maxCapacity + 1.
	self assert: set capacity = maxCapacity.

	set := self setClass new: maxCapacity * 2.
	self assert: set capacity = maxCapacity.
]

{ #category : #tests }
BitmapCharacterSetTest >> testMaxCharacter [
	| set |

	set := self emptySet.
	self
		shouldnt: [set add: self lastCodePoint asCharacter]
		raise: Error.
	self assert: (set includes: self lastCodePoint asCharacter).
	self
		should: [set add: (self lastCodePoint + 1) asCharacter]
		raise: Error.
]

{ #category : #tests }
BitmapCharacterSetTest >> testNewFrom [
	| set newSet |

	set := self setClass newFrom: self characters.
	self assert: set class == self setClass.
	self charactersDo: [:each | self assert: (set includes: each)].

	newSet := self setClass newFrom: set.
	self
		assert: newSet = set;
		deny: newSet == set.
]

{ #category : #tests }
BitmapCharacterSetTest >> testRemoveAll [
	| set capacity byteCharactersSize wideCharactersSize|

	set := self nonEmptySet.
	capacity := set capacity.
	byteCharactersSize := set byteCharacters size.
	wideCharactersSize := set wideCharacters size.
	self
		assert: set removeAll == set;
		assert: set size = 0;
		assert: set capacity = capacity;
		assert: set byteCharacters size = byteCharactersSize;
		assert: (set byteCharacters allSatisfy: [:each | each = false]);
		assert: set wideCharacters size = wideCharactersSize;
		assert: (set wideCharacters allSatisfy: [:each | each = 0]).
]

{ #category : #tests }
BitmapCharacterSetTest >> testRemoveIfAbsent [
	| set |

	set := self nonEmptySet.
	self absentCharactersDo: [:each |
		self assert:
			(set
				remove: each
				ifAbsent: [#absent]) = #absent].
	self charactersDo: [:each |
		self assert:
			(set
				remove: each
				ifAbsent: [self fail]) = each.
		self assert:
			(set
				remove: each
				ifAbsent: [#absent]) = #absent].
]

{ #category : #tests }
BitmapCharacterSetTest >> testRemoveRangeFromTo [
	| set |

	set := self emptySet.
	self "empty range, because from > to"
		assert: (set removeRangeFrom: self rangeStop to: self rangeStart) == set;
		assert: set isEmpty.

	set addRangeFrom: self rangeStart to: self rangeStop.
	self
		assert: (set removeRangeFrom: self rangeStart to: self rangeStop) == set;
		assert: set isEmpty.

	self rangeCharacters do: [:each |
		set := self setClass newFrom: self rangeCharacters.
		self
			assert: (set removeRangeFrom: each to: each) == set;
			assert:
				set =
					(self setClass newFrom: (self rangeCharacters copyWithout: each)).
		self
			should: [set removeRangeFrom: each to: each]
			raise: Error].
]

{ #category : #tests }
BitmapCharacterSetTest >> testSize [
	| set size |

	set := self emptySet.
	size := 0.
	self charactersDo: [:each |
		self assert: set size = size.
		set add: each.
		size := size + 1.
		self assert: set size = size.

		"Adding the same character shouldn't alter the size"
		set add: each.
		self assert: set size = size.].

	self charactersDo: [:each |
		set remove: each.
		size := size - 1.
		self assert: set size = size].	
]

{ #category : #tests }
BitmapCharacterSetTest >> testWideCharacters [
	0 to: 7 do: [:i | | set character |
		set := self setClass new.
		character := (256 + i) asCharacter.
		self assert: set wideCharacters isNil.
		set add: character.
		self assert: set wideCharacters first = (16r80 bitShift: i negated).
		set remove: character.
		self assert: set wideCharacters first = 0].
	0 to: 7 do: [:i | | set character |
		set := self setClass new.
		character := (256 + 8 + i) asCharacter.
		self assert: set wideCharacters isNil.
		set add: character.
		self assert: set wideCharacters second = (16r80 bitShift: i negated).
		set remove: character.
		self assert: set wideCharacters second = 0]
]

{ #category : #tests }
BitmapCharacterSetTest >> testWideCharactersDo [
	| set enumerated wideCharOffset |

	set := self emptySet.
	enumerated := OrderedCollection new.

	set wideCharactersDo: [:each | enumerated addLast: each].
	self assert: enumerated isEmpty.

	set addAll: self characters.
	set wideCharactersDo: [:each | enumerated addLast: each].
	self assert: enumerated notEmpty.
	wideCharOffset :=
		(self characters findFirst: [:each | each asciiValue >= 256]) - 1.
	enumerated withIndexDo: [:each :i |
		self
			assert: each asciiValue >= 256;
			assert: each = (self characters at: wideCharOffset + i)].
]
