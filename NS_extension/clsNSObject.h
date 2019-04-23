
@interface NSObject (ex)

- (id)_func:(NSString*)method args:(id)args;
- (id)_func:(NSString*)method args:(id)args args2:(id)args2;

- (BOOL)_isNull;

+ (BOOL)isNull:(id)obj;

- (BOOL)_isEmpty;

- (BOOL)_isExsits;

+ (NSDictionary*)_properties;

@end
