
#import "clsNSObject.h"

#import <objc/runtime.h>

@implementation NSObject (ex)

- (id)_func:(NSString*)method args:(id)args
{

    return [self performSelector:NSSelectorFromString(method) withObject:args];
}
- (id)_func:(NSString*)method args:(id)args args2:(id)args2
{
    return [self performSelector:NSSelectorFromString(method) withObject:args withObject:args2];
}

- (BOOL)_isNull
{
    return [[NSNull null] isEqual:self];
}
+ (BOOL)isNull:(id)obj
{
    return obj == nil || [[NSNull null] isEqual:obj];
}

- (BOOL)_isEmpty
{
    if (self == nil) {
        return YES;
    }
    if ([self isKindOfClass:[NSString class]] && [self isEqual:@""]) {
        return YES;
    }

    return NO;
}

- (BOOL)_isExsits
{
    if (self != nil) {
        return YES;
    }
    if ([self isKindOfClass:[NSString class]] && ![self isEqual:@""]) {
        return YES;
    }

    return NO;
}

- (void)_dictionaryRepresentation:(id)modelClass
{

    unsigned int i, count;
    objc_property_t* properties = class_copyPropertyList([modelClass class], &count);
    for (i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char* attrs = property_getAttributes(property);
        NSArray* k = [[NSString stringWithUTF8String:attrs] componentsSeparatedByString:@","];
        //@dynamic修飾子のチェック
        if ([k containsObject:@"D"]) {

            const char* propName = property_getName(property);
            if (propName) {
                NSString* propertyName = [NSString stringWithUTF8String:propName];

                /*
                NSString* getterName = propertyName;
                NSString* setterName = [NSString stringWithFormat:@"set%@%@:",
                                                                  [[propertyName substringToIndex:1] uppercaseString],
                                                                  [propertyName substringFromIndex:1]];
                SEL getterSEL = NSSelectorFromString(getterName);
                SEL setterSEL = NSSelectorFromString(setterName);
                */
                NSString* code = [k objectAtIndex:0];
                NSRange range = [code rangeOfString:@"NCMBRelation"];
            }
        }
    }
    free(properties);
}

static const char* _getPropertyType(objc_property_t property)
{
    const char* attributes = property_getAttributes(property);
    // printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            return (const char*)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        } else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        } else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            return (const char*)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "";
}

+ (NSDictionary*)_properties
{
    NSMutableDictionary* results = [[NSMutableDictionary alloc] init];

    unsigned int outCount, i;
    objc_property_t* properties = class_copyPropertyList(self, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char* propName = property_getName(property);
        if (propName) {
            const char* propType = _getPropertyType(property);
            NSString* propertyName = [NSString stringWithUTF8String:propName];
            NSString* propertyType = [NSString stringWithUTF8String:propType];

            if (![propertyType isEqual:@"Q"] && ![propertyType isEqual:@"#"]) {
                if ([propertyType isEqual:@"q"]) {
                    propertyType = @"NSInteger";
                }
                [results setObject:propertyType forKey:propertyName];
            }
        }
    }

    //NSLog(@" results %@",   results  );

    free(properties);

    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}

@end
