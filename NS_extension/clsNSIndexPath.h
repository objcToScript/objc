
@interface NSIndexPath (extension)

#if TARGET_OS_IOS
+ (NSIndexPath*)_getNSIndexPath:(int)section row:(int)row;
#endif

- (NSArray*)_allIndexes;

@end
