
@interface NSMutableArray (ex)

-(NSString*)_toStringWithLine;

-(NSString*)_toString;

- (NSNumber*)_getMaxNum_from_Number;

- (NSMutableArray*)_insertFirst:(id)data;

- (void)_removeObject:(int)index;

- (NSMutableArray*)_deleteEmpty;

- (void)_setObject_from_Index:(NSInteger)index value:(id)value;

//配列の要素をランダムにシャッフルする
- (void)_exchange;

- (NSMutableArray*)_slice:(NSUInteger)start length:(NSUInteger)length;

- (NSMutableArray*)_reverse;

- (BOOL)_containsDic:(id)dic;

- (NSMutableArray*)_removeLength:(NSString*)str;

- (void)_lastDeleteDataRow;
- (void)_deleteDataRowIndex:(int)index;

- (NSString*)_arrayToJson;

- (NSMutableArray*)_deleteDataRow:(NSMutableDictionary*)deleteDic;

//arrayをnsuserdefaultに保存する
- (void)_saveArray:(NSString*)fileName;
- (NSMutableArray*)_loadArray:(NSString*)fileName;

+ (void)_saveUserSettingArray:(NSString*)fileName;
+ (NSMutableArray*)_loadUserSettingArray:(NSString*)fileName;

- (NSString*)_toJson;

- (BOOL)_safeObjecAtIndex_Bool:(NSUInteger)index;
- (id)_safeObjectAtIndex:(NSUInteger)index;
- (int)_searchAtIndex:(NSString*)word;
- (int)_searchAtIndex_range:(NSString*)word;
- (NSString*)_join:(NSString*)str;

//同じ要素を削除する
- (NSMutableArray*)_arrayUnique;

- (NSMutableArray*)_sort_dic:(NSString*)dicKey isAsc:(BOOL)isAsc;

- (NSMutableArray*)_sortNum:(BOOL)isAsc;

//getカウント
- (id)_getRandValue;

- (int)_searchContainsIndex:(NSString*)word;

- (id)_objectAtIndex:(int)index;

@end
