
#import "clsNSXMLDocument+utility.h"

#if TARGET_OS_MAC

@implementation NSXMLElement(utility)

+(NSXMLElement*)_mkElement:(NSString*)name{
    NSXMLElement *childElement1 = [[NSXMLElement alloc] initWithName:name];
    return childElement1;
}

-(void)_addChildNode:(NSXMLElement*)element{
    [self addChild:element];
}

-(NSString*)_getXmlStr{
    NSString* string = [self XMLStringWithOptions:NSXMLNodePrettyPrint];
    return string;
}

-(NSArray*)_getChildrenNode{
    return [self children];
}

-(NSInteger)_getChildrenNode_count{
    return [self childCount];
}

-(void)_remove:(NSString*)name{

    NSXMLNode *manufacturer = [self parent];
    NSXMLElement *parent_element = (NSXMLElement *)manufacturer;

    NSArray *elements = [parent_element elementsForName:name];
    for(NSXMLElement *element in elements){
        [parent_element removeChildAtIndex:[[parent_element children] indexOfObject:element]];
    }
}

-(void)_remove{
    
    NSXMLNode *manufacturer = [self parent];
    NSXMLElement *parent_element = (NSXMLElement *)manufacturer;

    NSArray *elements = [parent_element elementsForName:[self name]];
    for(NSXMLElement *element in elements){
        
        if(self == element){
            [parent_element removeChildAtIndex:[[parent_element children] indexOfObject:element]];
        }

    }
    
}

-(void)_setAttribute:(NSString*)name value:(NSString*)value{
    [self addAttribute:[NSXMLNode attributeWithName:name stringValue:value]];
}

-(NSArray*)_getAttributes{
    return [self attributes];
}

-(NSString*)_getName{
    return [self name];
}

-(NSString*)_getAttributesValue:(NSString*)name{
    return [[self attributeForName:name] stringValue];
}

-(NSArray*)_selectNodes:(NSString*)xPath{
    NSError*err;
    NSArray *items = [self nodesForXPath:xPath error:&err];
    if(err != nil){
        NSLog(@"err.description  %@",  err.description  );
    }
    return items;
}

-(NSXMLElement*)_selectSingleNode:(NSString*)xPath{
    NSError*err;
    NSArray *items = [self nodesForXPath:xPath error:&err];
    if(err != nil){
        NSLog(@"err.description  %@",  err.description  );
    }
    if([items count] > 0){
        return [items objectAtIndex:0];
    }
    return nil;
}

@end

@implementation NSXMLDocument(utility)

-(NSXMLElement*)_getElement{
    return self.rootElement ;
}

+(NSXMLDocument*)_loadXmlDoc:(NSString*)filePath{
    
    NSXMLDocument*doc = [NSXMLDocument new];
    
    doc = [doc _mkXMLDocumentFromFile:filePath];
    
    return doc;    
}

-(NSXMLElement*)_selectSingleNode:(NSString*)xPath{
    NSError*err;
    NSArray *items = [self nodesForXPath:xPath error:&err];
    if(err != nil){
        NSLog(@"err.description  %@",  err.description  );
    }
    if([items count] > 0){
        return [items objectAtIndex:0];
    }
    return nil;
}

-(NSArray*)_selectNodes:(NSString*)xPath{
    NSError*err;
    NSArray *items = [self nodesForXPath:xPath error:&err];
    if(err != nil){
        NSLog(@"err.description  %@",  err.description  );
    }
    return items;
}

+(NSXMLElement*)_mkElement:(NSString*)name{
    NSXMLElement *childElement1 = [[NSXMLElement alloc] initWithName:name];
    return childElement1;
}

-(NSXMLDocument*)_mkXMLDocumentFromFile:(NSString *)file {
    
    NSXMLDocument *xmlDoc;
    NSError *err=nil;
    NSURL *furl = [NSURL fileURLWithPath:file];
    if (!furl) {
        NSLog(@"Can't create an URL from file %@.", file);
        return nil;
        
    }
    xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl
                                                  options:(NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA)
                                                    error:&err];
    if (xmlDoc == nil) {
        xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl
                                                      options:NSXMLDocumentTidyXML
                                                        error:&err];
    }
    if (xmlDoc == nil){
        if (err) {
           NSLog(@"  %@",  err.description   );
        }
        return nil;
    }
    if (err){
        NSLog(@"  %@",  err.description   );
        return nil;
    }
    
    return xmlDoc;
}


-(NSString*)_getXmlStr{
    NSString* string = [self XMLStringWithOptions:NSXMLNodePrettyPrint];
    return string;
}

-(NSData*)_getXmlData{
    NSData* xmlData = [self XMLDataWithOptions:NSXMLNodePrettyPrint];
    return xmlData;
}

- (BOOL)_save:(NSString *)filePath{
  
    NSData *xmlData = [self XMLDataWithOptions:NSXMLNodePrettyPrint];
    if (![xmlData writeToFile:filePath atomically:YES]) {
        NSBeep();
        NSLog(@"XMLDoc 保存失敗 not write document out...");
        return NO;
    }    
    
    return YES;
    
}

@end

#endif
