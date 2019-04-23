
@interface NSMutableDictionary (ex)

//配列を結合する
- (NSMutableDictionary*)_concat:(NSMutableDictionary*)dic;

//toStrに変換
- (NSString*)_toString;

//dicがあるかどうか確認する
- (BOOL)_containsDic:(id)dic2;
//dicにキーがあるかどうか
- (BOOL)_containsKey:(NSString*)key;

//最初のキーを取得する
- (NSString*)_getKey_one;

- (void)_fetchDic:(NSMutableDictionary*)secondDic;

- (void)_fetch_schema:(NSMutableArray*)schme addDic:(NSMutableDictionary*)addDic;

//jsonをstrに変換
- (NSString*)_jsonDicToStr;

//NSUserDefaultsに保存する
- (void)_saveUserSettingDic:(NSString*)fileName;

//NSUserDefaultsを取得する
- (NSMutableDictionary*)_loadUserSettingDic:(NSString*)fileName;

//NSUserDefaultsを削除する
- (void)_deleteUsertSettingDic:(NSString*)fileName;

- (void)_add:(NSString*)key value:(id)value;

//シングルコーテーションをエスケープする
- (void)_sqlEscapeDic;

//Json化
- (NSString*)_toJson;

- (NSObject*)_jsonXPath:(NSString*)jsonXPath;

//一番右が/ならlableを追加する
- (NSObject*)_jsonXPath:(NSString*)jsonXPath withAutoLable:(BOOL)withAutoLable;

//キーを追加すると配列を返す
- (NSMutableArray*)_addObject:(NSString*)key;

//arrayをjsonに変換
- (NSString*)_arrayToJsonStr;

@end
