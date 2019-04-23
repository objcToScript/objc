
#if TARGET_OS_MAC

@interface NSXMLElement(utility)

+(NSXMLElement*)_mkElement:(NSString*)name;
-(void)_addChildNode:(NSXMLElement*)element;
-(NSString*)_getName;
-(void)_remove;
-(void)_remove:(NSString*)name;
-(void)_setAttribute:(NSString*)name value:(NSString*)value;
-(NSArray*)_getAttributes;
-(NSString*)_getAttributesValue:(NSString*)name;
-(NSArray*)_selectNodes:(NSString*)xPath;
-(NSXMLElement*)_selectSingleNode:(NSString*)xPath;
+(NSXMLElement*)_mkElement:(NSString*)name;
-(NSString*)_getXmlStr;

-(NSArray*)_getChildrenNode;
-(NSInteger)_getChildrenNode_count;

@end

@interface NSXMLDocument(utility)

-(NSXMLElement*)_getElement;
+(NSXMLDocument*)_loadXmlDoc:(NSString*)filePath;
-(NSXMLElement*)_selectSingleNode:(NSString*)xPath;
-(NSArray*)_selectNodes:(NSString*)xPath;
-(NSXMLDocument*)_mkXMLDocumentFromFile:(NSString *)file;
-(NSString*)_getXmlStr;
-(NSData*)_getXmlData;
-(BOOL)_save:(NSString *)filePath;
+(NSXMLElement*)_mkElement:(NSString*)name;

@end
#endif
