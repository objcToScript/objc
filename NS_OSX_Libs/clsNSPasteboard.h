
@interface clsNSPasteboard : NSObject

+(NSString*)_getClipBoradFileContent;
+(NSString*)_getClipBoradFilePath;

+(void)_setClipBoradText:(NSString*)str;

+(void)_setCleare;

+(void)_setClipBoradArray:(NSMutableArray<NSPasteboardItem*>*)array;

@property (strong,nonatomic)NSString*dataSetName;

@end
