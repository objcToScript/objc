###Objective-C To Like Script

Objective-cをExtensionで加工してScriptのような便利さで使うことを目標にしています。

既存のNSクラス、UIクラスのExtensionを加工しScriptのような感じにしています

関数名の最初には_を追加することで、オリジナル関数を見つけやすくしています。

Precompile Prefix Headerを追加し、記入することでソースが認識されます。

example

Before

NSArray* values = [@"test , test" componentsSeparatedByString:@","];

After

NSArray* values = [@"teste , test" _split:@","];

_でScriptでお馴染みの便利な関数を検索できます。



Build Settings

Precompile Prefix Header - YES

Prefix Header - $(SRCROOT)/PrefixHeader.pch


The goal is to process Objective-c with Extension and use it as convenient as Script.

We modify the existing NS class and UI class Extension to make it look like Script.

By adding _ at the beginning of the function name, it is easy to find the original function.

The source is recognized by adding Precompile Prefix Header and filling it in.
