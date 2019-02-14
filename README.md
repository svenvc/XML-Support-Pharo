# XML-Support-Pharo
XML Support Pharo

Experimental conversion of current XML Support for Pharo

[![Build Status](https://travis-ci.org/svenvc/XML-Support-Pharo.svg?branch=master)](https://travis-ci.org/svenvc/XML-Support-Pharo)

## Loading

```smalltalk
Metacello new
   baseline: 'XMLParser';
   repository: 'github://svenvc/XML-Support-Pharo';
   load.
```

## Dependency

```smalltalk
spec baseline: 'XMLParser' with: [ spec repository: 'github://svenvc/XML-Support-Pharo' ].
```

