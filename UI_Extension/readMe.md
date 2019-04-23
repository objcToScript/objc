###Objective-C To Like Script

Objective-cをExtensionで加工してScriptのような便利さで使うことを目標にしています。

既存のNSクラス、UIクラスのExtensionを加工しScriptのような感じにしています

The goal is to process Objective-c with Extension and use it as convenient as Script.
We modify the existing NS class and UI class Extension to make it look like Script.

Precompile Prefix Headerを追加し、記入することでソースが認識されます。

Build Settings

Precompile Prefix Header - YES

Prefix Header - $(SRCROOT)/PrefixHeader.pch
