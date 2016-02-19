//
//  ReportUtil.h
//  lovelive
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLActionSheet.h"
#import "AppDelegate.h"
@interface ReportUtil : NSObject<LLActionSheetDelegate>
{
    BOOL isteacher;
    NSArray *commentlist;
    NSMutableDictionary *thedic;

}

+(ReportUtil *)sharedInstance;

/**
 *  举报接口
 *  type  举报类型（1=直播、2=用户、3=动态）
 *  teacher  被举报用户是否老师
 *  target_id    举报对象ID,例：直播ID、用户ID、动态ID
 *  owner_uid    被举报者id
 *  showview     显示页面
 */
//-(void)showalvwithtype:(NSInteger)type isteacher:(BOOL)teacher target_id:(NSString*)target_id owner_uid:(NSString*)owner_uid showview:(UIView*)showview completionBlock:(CompletionBlock)completionBlock faildBlock:(FailedBlock)faildBlock;
@end
