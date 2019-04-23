
@interface NSData (ex)

//Char型に変換する
- (const char*)_toChar;
//NSString型に変換する
- (NSString*)_toString;
//JsonデータからDicに変換する
- (NSDictionary*)_toDicJson_fromJsonData;
//Jsonデータからjsonと配列に変換する
- (NSArray*)_toArrayJson_fromJsonData;
//NSPropertyListのformatを判定する
- (NSDictionary*)_toDic_from_NSPropertyList:(NSString**)formatStr;
//OpenStempFormat (.Project)かどうか
- (BOOL)_isOpenStepFormat_from_NSPropertyList;

@end
