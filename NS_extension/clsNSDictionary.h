
@interface NSDictionary (extension)

//文字列に変換する
- (NSString*)_toString;

//dicが含まれているか判定する
- (BOOL)_containsDic:(id)dic2;

//最初のキー名を取得する
- (NSString*)_getKey_one;

//dicをjsonに変換して保存する
- (void)_saveJson_ProjectFile_fromPath:(NSString*)filePath;

//NSData型に変換する
- (NSData*)_toData;

//Jsonに変換する
- (NSString*)_toJson;

//dicとdicを結合する
+ (NSDictionary*)_dicToDic_merge:(NSDictionary*)dict1 with:(NSDictionary*)dict2;

//OneStepは仕様で保存できない
//-(NSData*)_toSerialData_fromOneStep;

//jsonデーターからNSPropertyData形式に変換し取得する
- (NSData*)_toNSPropertyData_from_JsonDic;

@end
