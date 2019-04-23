
#import "clsNSPasteboard.h"

@implementation clsNSPasteboard

/*
+(NSString*)_getDragBoradFilePath1{
    
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSArray *classes = [NSArray arrayWithObject:[NSURL class]];
    
    NSArray* acceptedTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
    NSArray* urls = [pasteboard readObjectsForClasses:[NSArray arrayWithObject:[NSURL class]]
                                      options:[NSDictionary dictionaryWithObject:acceptedTypes
                                                                          forKey:NSPasteboardURLReadingContentsConformToTypesKey]];    
    
    return @"";
}
+(NSString*)_getDragBoradFilePath{
    
    NSURL *fileURL; // Assume this exists
    
    NSPasteboard *pboard = [NSPasteboard pasteboardWithName:NSDragPboard];
    
    [pboard declareTypes:[NSArray arrayWithObject:NSURLPboardType] owner:nil];
    
    [fileURL writeToPasteboard:pboard];
    return @"";
}
 */

+(NSString*)_getClipBoradFilePath{

    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSArray *classes = [NSArray arrayWithObject:[NSURL class]];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:
                             [NSNumber numberWithBool:YES] forKey:NSPasteboardURLReadingFileURLsOnlyKey];
    
    NSArray *fileURLs =
    [pasteboard readObjectsForClasses:classes options:options];
    
    if([fileURLs count] > 0){

        NSString* filePath2 = [((NSURL*)[fileURLs objectAtIndex:0]) absoluteString];
        filePath2 = [filePath2 _replace:@"file://" replaceStr:@""];
        filePath2 = [filePath2 _replace:@"%20" replaceStr:@" "];
        return  filePath2;

    }
    
    
    return @"";
}

+(NSString*)_getClipBoradFileContent{

    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSString* myString = [pasteboard  stringForType:NSPasteboardTypeString];
   
    return myString;
}

+(void)_setClipBoradText:(NSString*)str{

    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
    [pasteboard setString:str forType:NSStringPboardType];
    
}

+(void)_setCleare{
    
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    
    [pasteboard clearContents];
    
}


+(void)_setClipBoradArray:(NSMutableArray<NSPasteboardItem*>*)array{
    
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
  //  NSDictionary *options = [NSDictionary dictionaryWithObject:
  //                           [NSNumber numberWithBool:YES] //forKey:NSPasteboardURLReadingFileURLsOnlyKey];
    
  //  NSArray *fileURLs =
  // [pasteboard readObjectsForClasses:array options:options];

   // [pasteboard declareTypes:[NSArray arrayWithObject:NSFontPboardType] owner:nil];
    
   //   [pasteboard setData:[[array copy] _toData] forType:NSFontPboardType];
    
    BOOL copied = [pasteboard writeObjects:[array copy]];
    
   // return copied;
   
}


@end
