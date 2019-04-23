
#if TARGET_OS_IOS
#import "clsNSString+iOS.h"
#import <UIKit/UIKit.h>

#endif

@interface NSString (ex)

- (NSString*)_getLastWord;

- (BOOL)_isLastNumStr;

- (BOOL)_isLastStr:(NSString*)searchWord;

- (BOOL)_isFirstStr:(NSString*)searchWord;

- (BOOL)_isBool;

- (BOOL)isNotEmpty;

- (BOOL)_isDate;

- (BOOL)_isNum;

- (BOOL)_isFloat;

#if TARGET_OS_IOS
- (int)_getLineNum:(UILabel*)label;
#endif

- (NSAttributedString*)_to_AttributedString;

- (NSString*)_replaceFileExtension_fromPath:(NSString*)extension;

//メソッドのない丸カッコ
- (NSString*)_getMaruKako_methodStr;

//メッソドないのカッコ中身を取る
-(NSString*)_getKako_methodStr;

-(NSArray *)_splitCharacterEvery:(NSUInteger)splitNum;

-(void)_saveReXml_ProjectFile_fromPath;
-(NSDictionary*)_getJson_ProjectFile_fromPath;

-(void)_saveNSUserText:(NSString*)fileName;
-(NSString*)_loadNSUserText:(NSString*)fileName;

- (NSString *)_lTrim:(NSString*)str;
- (NSString *)_lTrim_newLineSpace;
- (NSString *)_rTrim:(NSString*)str;
- (NSString *)_rTrim_newLineSpace;
- (NSString*)_rTrim2:(NSString*)str;
- (NSString*)_lTrim2:(NSString*)str;

-(NSString*)_randomString:(int)kestaNum;

-(NSString *)_add:(NSString *)list, ...;
-(NSString*)_addStr:(NSString*)str;

-(NSString*)_getCategoryName_NoFileName_fromPath;
-(NSString*)_getReplaceFilePath_fromPath:(NSString*)fileName;
-(NSString*)_getFilePath_FileNameNoExtension_fromPath;
-(NSString*)_getFileName_NoExtension_NoPlus_fromPath;
-(NSString*)_getFileName_NoPlus_fromPath;
-(NSString*)_getCategoryFilePath_fromPath:(NSString*)categoryFileName isHFile:(BOOL)isHFile;
-(NSArray*)_getPathArray_fromPath;
-(NSString*)_getParentDirPath_fromPath;
-(NSString*)_getFileExtension_fromPath;
-(NSString*)_getFileName_NoExtension_fromPath;
-(NSString*)_getDirPath_fromPath;
-(NSString*)_getDirName_fromPath;
-(NSString*)_getFileName_fromPath;
-(NSString*)_replaceExtension_fromPath:(NSString*)extension;
-(NSString*)_renameLastName_fromPath:(NSString*)newFileName;
    
-(NSString*)_renameFilePath_fromPath:(NSString*)replaceValue_old
                        replaceValue_new:(NSString*)replaceValue_new;

-(NSString *) _md5;
-(int)_indexOf:(NSString *)text;
-(NSString*)_getSentouStr:(int)length;
-(NSString*)_getKouhouStr:(int)length;
-(NSString*)_getDirPath;

-(NSString*)_sqlEscapeStr;

-(NSString*)_trim_characterSet:(NSString*)str;
-(NSString*)_regReplace:(NSString*)pattern;
-(NSString*)_regReplacePartarn2:(NSString*)pattern replaceText:(NSString*)replaceText;
-(NSString*)_regMatchOne:(NSString*)pattern;
-(NSString*)_replace:(NSString*)search replaceStr:(NSString*)replaceStr;
-(NSMutableArray*)_regMatchMauti:(NSString*)pattern;
-(const char *)_toChar;
-(NSData *)_toData;
-(NSData *)_toData_fromPath;
-(NSDate *)_toDate;
-(char*)_convertToChar;
-(NSString*)_convertToNSString:(char*)str;
-(NSString *)_oomojiFirst;

-(NSString*)_substr:(int)i length:(int)length;
-(NSString*)_substr:(int)i;

-(NSString*)_strrev;

-(NSArray*)_split:(NSString *)splitStr;

-(NSString*)_xmlEscapeEncode;
-(NSString*)_xmlEscapeDecode;

-(NSString*)_canma_split;
-(NSString*)_charAt:(int)i;
-(NSString*)_removeKaigyou;
-(NSMutableArray*)_split_Kaigyou;
-(NSString*)_firstMojiRemove:(NSString *)removeMoji;

//前後の改行
- (NSString*)_trim_newLine;

//前後の半角スペース
- (NSString*)_trim_whiteSpace;

//前後の改行と半角スペース
- (NSString*)_trim_newLine_whiteSpace;

//jsonをarrayに変換
- (NSMutableDictionary*)_jsonStrToArray;

//jsonをDicに変換
- (NSMutableDictionary*)_jsonStrToDic;

//numberをstringに変える
//-(NSString*)_numberToStr;

//jsonをarrayに
- (id)_jsonToArray;

//urlをデコードする
- (NSString*)_urlDecode;
//urlをエンコードする
- (NSString*)_urlEncode;

- (unsigned int)_getNumberFromHex:(int)from;
//日付をNSDateにする
- (NSDate*)_getStrToNSDate;
- (NSDate*)_getStrToNSDate:(NSString*)formatStr;

//あるかどうか
- (BOOL)_isExits;

#pragma mark _addLeftStr
- (NSString*)_addLeftStr:(NSString*)str;
#pragma mark _addRightStr
- (NSString*)_addRightStr:(NSString*)str;

//拡張しのないファイル名を取得
- (NSString*)_getFileName_noPath_noExtension;

@end
