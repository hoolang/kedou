//
//  ReportUtil.m
//  lovelive
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "ReportUtil.h"

@implementation ReportUtil





+(ReportUtil *)sharedInstance{
    static ReportUtil *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ReportUtil alloc] init];
    });
    return instance;
}


//-(void)showalvwithtype:(NSInteger)type isteacher:(BOOL)teacher target_id:(NSString*)target_id owner_uid:(NSString*)owner_uid showview:(UIView*)showview completionBlock:(CompletionBlock)completionBlock faildBlock:(FailedBlock)faildBlock{
//    completeblock=completionBlock;
//    failedblock=faildBlock;
//    
//    isteacher=teacher;
//    thedic=[[NSMutableDictionary alloc] init];
//    NSString *strcancel=LLLangHmn(@"cancel", @"取消");
//    NSString *str1=[LangUtil langForKey:@"Low quality tutoring" tbl:@"yifan"];
//    NSString *str2=[LangUtil langForKey:@"Disturb the class" tbl:@"yifan"];
//    NSString *str3=[LangUtil langForKey:@"Terror/porn" tbl:@"yifan"];
//    NSString *str4=[LangUtil langForKey:@"Spam/Scam" tbl:@"yifan"];
//    NSString *str5=[LangUtil langForKey:@"Improper behave " tbl:@"yifan"];
//    [thedic setObject:[NSString stringWithFormat:@"%d",(int)type] forKey:@"type"];
//    [thedic setObject:[NSString stringWithFormat:@"%@",target_id] forKey:@"target_id"];
//    [thedic setObject:[NSString stringWithFormat:@"%@",owner_uid] forKey:@"owner_uid"];
//    
//    LLActionSheet *menu;
//    if (isteacher) {
//        commentlist=[NSArray arrayWithObjects:str1,str2,str3,str4,str5, nil];
//        menu= [[LLActionSheet alloc]
//               initWithTitle: nil
//               delegate:self
//               cancelButtonTitle:strcancel
//               destructiveButtonTitle:nil
//               otherButtonTitles:str1,str2,str3,str4,str5, nil];
//    }
//    else{
//        commentlist=[NSArray arrayWithObjects:str1,str2,str3,str4, nil];
//        menu= [[LLActionSheet alloc]
//               initWithTitle: nil
//               delegate:self
//               cancelButtonTitle:strcancel
//               destructiveButtonTitle:nil
//               otherButtonTitles:str1,str2,str3,str4, nil];
//    }
//    
//    [menu showInView:showview];
//
//}

#pragma mark LLActionSheetDelegate
- (void)actionSheet:(LLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *str;
    if (buttonIndex<[commentlist count]) {
        str=[commentlist objectAtIndex:buttonIndex];
        [thedic setObject:[NSString stringWithFormat:@"%@",str] forKey:@"content"];
        //[self report];
    }
}

//-(void)report{
//    
//    [[UserMgr sharedInstance] queryApiName:@"/v2/base/report" params:thedic cacheTime:0 tag:1000 completionBlock:^(id data){
//        
//        
//        NSDictionary *req=(NSDictionary*)data;
//
//        if ([[ToolObject getStringValueInDic:req key:@"code"] intValue]==0) {
//            if (completeblock) {
//                completeblock(nil);
//            }
//        }
//        else{
//            if ([[ToolObject getStringValueInDic:req key:@"code"] intValue]==107) {
//                failedblock([LangUtil langForKey:@"repeated report" tbl:@"yifan"]);
//            }
//            else{
//                if (failedblock) {
//                    failedblock([ToolObject getStringValueInDic:req key:@"msg"]);
//                }
//            }
//            
//
//            
//        }
//        
//        
//        
//    } faildBlock:^(NSString *str){
//        
//        
//        NSLog(@"error...");
//        if (failedblock) {
//            failedblock(@"fail");
//        }
//
//    }];
//}

@end
