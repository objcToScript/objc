
#import <UIKit/UIKit.h>

@interface UITableView (ex)

//リロード
- (void)_reloadDataAndWait:(void (^)(void))waitBlock;

//nibファイルをテーブルに登録しキャッシュとして使う
- (void)_registClassCell:(Class) class cellIdentifier:(NSString*)cellIdentifier;
//配列で指定した値のセルを削除する
- (void)_deleteStaticCell:(NSMutableArray*)intArray section:(int)section;
//テーブルからセルをチェックする
- (void)_checkCell:(NSIndexPath*)indexPath;
//テーブルからセルをチェックを解除する
- (void)_cellCheckAllReset:(NSIndexPath*)indexPath;
//テーブルからセルを取得する
- (UITableViewCell*)_getCell:(NSIndexPath*)indexPath;
//セル選択し実行する
- (void)_cellSelectionSelected_indexPath:(NSIndexPath*)indexPath;
//セル選択した時に非表示にする
- (void)_cellSelectionSelected:(NSMutableDictionary*)indexInfoArray;
//indexへ移動する
- (void)_goToIndex:(NSIndexPath*)indexPath;
- (void)_registCell:(NSString*)nibName cellIdentifierName:(NSString*)cellIdentifierName;
//セルボタンを青を消す
+ (void)_cellBlue_turnOff:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;

//viewDidAppear以降で実行する
//テーブルセクションをを削除する
- (void)_deleteSellection:(int)index;
//テーブルの　 viewDidLoadで設定すること
//テーブルセルの分割線を長さを指定する
- (void)_setSepartionZero;
- (void)_setSepartionZero:(int)leftMargin;
- (void)_setSepartionTableView:(BOOL)boolFlag;

//指定したテーブルの表示されているセルのみ背景色を指定する
- (void)_setColor_visibleTable:(UIColor*)targetColor;

//セルの座標を取得する
- (CGPoint)_getVisibleCell_point:(UITableViewCell*)cell;

//テーブルセルの分割線を左まで描画する
- (void)_sepalter_zero:(NSString*)color;

//rootに移動する
- (void)_moveRoot:(BOOL)isAnime;

//Bottomに移動する
- (void)_moveBottom:(BOOL)isAnime;

//SeparatorStyleを設定する
- (void)_isSeparatorStyle:(BOOL)boolFlag;

@end
