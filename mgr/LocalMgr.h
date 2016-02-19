//
//  LocalMgr.h
//  lovelive
//
//  Created by ZMB on 15/12/6.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseMgr.h"
#import "LocalModel.h"

@interface LocalMgr : BaseMgr
@property (strong, nonatomic) NSArray* bufferList;
+ (LocalMgr*) sharedInstance;
/**
 *  @author ZMB, 15-12-06 21:12:19
 *
 *  获取国家列表
 *
 *  @return 数组里面包含LocalModel
 */
-(NSArray *) countryList;
/**
 *  @author ZMB, 2015-12-28 10:31:16
 *
 *  根据相关的编码获取一个国家的信息
 *
 *  @param country  国家编码
 *
 *  @return 返回一个国家的信息，包含省份、城市
 */
-(LocalModel *) oneCountryData:(NSString *)country;
/**
 *  @author ZMB, 15-12-06 22:12:10
 *
 *  根据相关的编码获取一个地区名称：
 *
 *  @param country  国家编码
 *  @param province 省份编码
 *  @param city     城市编码
 *
 *  @return 发回格式化后的名字： 中国-广东-广州
 */
-(NSString *) getLocalString:(NSString *)country province:(NSString *)province city:(NSString *)city;
/**
 *  @author ZMB, 15-12-07 11:12:21
 *
 *  获取国家名字
 *
 *  @param country 国家编码
 *
 *  @return 国家名字
 */
-(NSString *) getCountryName:(NSString *)country;
@end
