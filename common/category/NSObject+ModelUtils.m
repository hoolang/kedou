//
//  NSObject+ModelUtils.m
//  lovelive
//
//  Created by 91wan on 16/1/14.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "NSObject+ModelUtils.h"

@implementation NSObject (ModelUtils)
-(SEL)getSet:(NSString *)name
{
    NSString *str1=[[name substringToIndex:1]uppercaseString];
    NSString *str=[NSString stringWithFormat:@"set%@%@:",str1,[name substringFromIndex:1]];
    return NSSelectorFromString(str);
    
}
/**
 *  NSDictionary 转 model
 *
 */
-(void)setAttributes:(NSDictionary*)dataDic
{
    //获取所以key值
    NSEnumerator *keyEnum=[dataDic keyEnumerator];
    id attrname=nil;
    while (attrname=[keyEnum nextObject]) {
        SEL sel=[self getSet:attrname];
        if ([self respondsToSelector:sel]) {
            if ([dataDic[attrname] isKindOfClass:[NSNull class]]) {
                [self setValue:@"" forKey:attrname];
            }
            else
            {
                [self setValue:dataDic[attrname] forKey:attrname];
            }
        }
        
    }
}
-(SEL)getGet:(NSString *)name
{
    NSString *str1=[[name substringToIndex:1]uppercaseString];
    NSString *str=[NSString stringWithFormat:@"get%@%@:",str1,[name substringFromIndex:1]];
    return NSSelectorFromString(str);
    
}
/**
 *  model 转 NSDictionary
 *
 *  @return NSDictionary
 */
-(NSDictionary *)getAttr
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    Class c=[self class];
    while (c&&c!=[NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(c, &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            id propertyValue = [self valueForKey:propertyName];
            if (propertyValue) [props setObject:propertyValue forKey:propertyName];
        }
        c=class_getSuperclass(c);
    }
    
    return props;
}


/**
 *  NSDictionary 转 model 方法2 根据model属性类型   没用的 先留着
 *
 */
-(void)setDics:(NSDictionary*)dataDic
{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        const char* char_a =property_getAttributes(property);
        NSString *className = [NSString stringWithUTF8String:char_a];
        BOOL isString = NO;
        if ([className rangeOfString:@"NSString"].location == NSNotFound) {
            isString=YES;
        }
        
        //获取所以key值
        NSEnumerator *keyEnum=[dataDic keyEnumerator];
        NSString *attrname=nil;
        while (attrname=[keyEnum nextObject])
        {
            if ([attrname isEqualToString:propertyName]) {
                if ([dataDic[attrname] isKindOfClass:[NSNull class]]) {
                    [self setValue:@"" forKey:attrname];
                }
                else
                {
                    if (isString) {
                        [self setValue:[NSString stringWithFormat:@"%@",dataDic[attrname]] forKey:attrname];
                    }else
                    {
                        [self setValue:dataDic[attrname] forKey:attrname];
                    }
                }
                
            }
        }
        
        
    }
    free(properties);
}
@end
