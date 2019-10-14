# XML-Support-Pharo

Experimental conversion of current XML Support for Pharo

[![Build Status](https://travis-ci.org/svenvc/XML-Support-Pharo.svg?branch=master)](https://travis-ci.org/svenvc/XML-Support-Pharo)

## Original Repositories

- http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/
    - http://www.smalltalkhub.com/#!/~PharoExtras/XMLParser
- http://smalltalkhub.com/mc/PharoExtras/XMLWriter/main/
    - http://www.smalltalkhub.com/#!/~PharoExtras/XMLWriter
- http://smalltalkhub.com/mc/PharoExtras/OrderPreservingDictionary/main/
    - http://www.smalltalkhub.com/#!/~PharoExtras/OrderPreservingDictionary
- http://smalltalkhub.com/mc/PharoExtras/BitmapCharacterSet/main/
    - http://www.smalltalkhub.com/#!/~PharoExtras/BitmapCharacterSet

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

## Support Disclaimer

This repository is NOT where development of XML Support for Pharo takes place, 
please post any questions yoy might have to the Pharo mailing lists. 
