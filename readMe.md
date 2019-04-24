Objective-C To  Script Like

Objective-cをExtensionで加工してScriptのような便利さで使えるようにしています

既存のNSクラス、UIクラスのExtensionを追加しScriptでお馴染みの関数を追加しています

関数名の最初には_を追加することで検索できます

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


I am processing Objective-c with Extension so that it can be used with convenience like Script

Extension of existing NS class, UI class is added and familiar function is added by Script

You can search by adding _ at the beginning of the function name
