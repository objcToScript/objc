
@interface NSArray (ex)

-(void)_compare_asc:(NSString*)key func:(void (^)(NSArray*))func;

-(void)_compare_desc:(NSString*)key func:(void (^)(NSArray*))func;
//ソートする
-(NSArray*)_sort;
//キーだけにする
- (NSMutableDictionary*)_to_dic_keyOnly;
//配列の要素をランダムにシャッフルする
- (NSArray*)_exchange;
//配列をスライスする
- (NSArray*)_slice:(NSUInteger)start length:(NSUInteger)length;
//配列をDictionaryにする
- (NSMutableDictionary*)_toDic;
//配列をひっくり返す
- (NSArray*)_reverse;
//配列を結合する
- (NSArray*)_concat:(NSArray*)secondArray;
//空の要素を削除する
- (NSArray*)_deleteEmpty;
//要素にDictionaryがあるかどうか
- (BOOL)_containsDic:(id)dic;
//要素の文字列があれば削除する
- (NSArray*)_removeLength:(NSString*)str;
//指定した要素をインデックスで削除する
- (NSArray*)_removeObjct:(int)index;
//Jsonにする
- (NSString*)_toJson;
//安全にIndexがあるかどうか
- (id)_safeObjectAtIndex:(NSUInteger)index;
//文字列を検索しインデックスが返す
- (int)_searchAtIndex:(NSString*)word;
//文字列を検索しヒットした行の範囲を数字で返す
- (int)_searchAtIndex_range:(NSString*)word;
//安全にIndexがあるかどうかBoolでけ返す
- (BOOL)_safeObjecAtIndex_Bool:(NSUInteger)index;
//配列に文字列を追加する
- (NSString*)_join:(NSString*)str;

@end
