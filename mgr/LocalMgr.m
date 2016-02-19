//
//  LocalMgr.m
//  lovelive
//
//  Created by ZMB on 15/12/6.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "LocalMgr.h"
#import "LocalModel.h"

@implementation LocalMgr

+(LocalMgr *)sharedInstance{
    static LocalMgr *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LocalMgr alloc] init];
    });
    return instance;
}

-(void) initialize{

    _bufferList = [NSArray array];

}

- (NSArray *)bufferList
{
    if (_bufferList == nil) {
        _bufferList = [NSArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LocalList" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        _bufferList = [jsonStr stringToJson];
    }
    return _bufferList;
}

-(NSArray *) countryList
{   // TODO 转模型后的国家列表，直接保存一份到内存，或许好一些。不用每次都遍历一次。但这样子会导致内存增加。
    NSMutableArray *mArrary = [NSMutableArray array];
    for (NSDictionary *dic in self.bufferList) {
        LocalModel *localModel = [[LocalModel alloc] init];
        localModel.name = dic[@"name"];
        localModel.code = dic[@"code"];
        localModel.areanumber = dic[@"areanumber"];
        localModel.localArray = dic[@"state"];
        [mArrary addObject:localModel];
    }
    return mArrary;
}

-(LocalModel *) oneCountryData:(NSString *)country
{
    LocalModel *localModel;
    for (NSDictionary *dic in self.bufferList) {
        if ([[NSString stringWithFormat:@"%@",dic[@"code"]] isEqualToString:country]) {
            localModel = [[LocalModel alloc] init];
            localModel.name = dic[@"name"];
            localModel.code = dic[@"code"];
            localModel.areanumber = dic[@"areanumber"];
            localModel.localArray = dic[@"state"];
        }
    }
    return localModel;
}

-(NSString *) getLocalString:(NSString *)country province:(NSString *)province city:(NSString *)city
{
    if (!country)
    {
        return @"";
    }
    
    BOOL isChinese = [LangUtil isChinese];
    
    NSString *params = @"name";
    
    if (!isChinese) {
        params = @"code";
    }
    
    country = [NSString stringWithFormat:@"%@", country];
    province = [NSString stringWithFormat:@"%@", province];
    city = [NSString stringWithFormat:@"%@", city];
    
    NSString *str = @"";
    
    for (NSDictionary *dic in self.bufferList) {
        if ([[NSString stringWithFormat:@"%@",dic[@"code"]] isEqualToString:country]) {
            if([country isEqualToString:province] && [country isEqualToString:city]){
                str =  dic[params];
            }
            else
            {
                NSArray *stateArr = dic[@"state"];
                if (stateArr.count > 0) {
                    if(stateArr.count == 1)
                    {
                        // 只有一个省份或者没有省份
                        NSDictionary *citiesDic = (NSDictionary *)stateArr[0];
                        
                        NSArray *cityArr = citiesDic[@"city"];
                        if (cityArr.count > 0) {
                            for (NSDictionary *cityDic in cityArr) {
                                if([[NSString stringWithFormat:@"%@", cityDic[@"code"] ] isEqualToString:city])
                                {
                                    str =  [NSString stringWithFormat:@"%@-%@", dic[params], cityDic[params]];
                                }
                            }
                        }
                        else
                        {
                            str =  [NSString stringWithFormat:@"%@-%@", dic[params], citiesDic[params]];
                        }
                    }
                    else
                    {   // 多个省份
                        for (NSDictionary *state in stateArr) {
                            if ([[NSString stringWithFormat:@"%@", state[@"code"]]  isEqualToString:province]) {
                                if([[NSString stringWithFormat:@"%@",state[@"code"]] isEqualToString:city])
                                {
                                    
                                    str =  [NSString stringWithFormat:@"%@-%@", dic[params], state[params]];
                                }
                                else
                                {
                                    NSArray *cityArr = state[@"city"];
                                    if (cityArr.count > 0) {
                                        for (NSDictionary *cityDic in cityArr) {
                                            if([[NSString stringWithFormat:@"%@", cityDic[@"code"] ] isEqualToString:city])
                                            {
                                                str =  [NSString stringWithFormat:@"%@-%@-%@", dic[params], state[params], cityDic[params]];
                                                
                                            }
                                        }
                                    }
                                    else
                                    {
                                        str =  [NSString stringWithFormat:@"%@-%@", dic[params], state[params]];
                                        
                                    }
                                    
                                }
                            }
                            else
                            {
                                //LLLog(@"省份不一致");
                            }
                        }
                    }
                    
                }
                else
                {
                    str = dic[params];
                }
                
            }
        }
    }
    
    return str;
}

-(NSString *) getCountryName:(NSString *)country
{
    BOOL isChinese = [LangUtil isChinese];
    NSString *str;
    for (NSDictionary *dic in self.bufferList) {
        if([dic[@"code"] isEqualToString:country])
        {
            if (isChinese) {
                str =  dic[@"name"];
            }
            else
            {
                str =  dic[@"code"];
            }
            return str;
        }
    }
    return str;
}
@end
