//
//  DeviceMgr.h
//  lovelive
//
//  Created by Kong on 15/12/28.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseMgr.h"

@interface DeviceMgr : BaseMgr{
    BOOL _isBusy;
    NSTimer *_timerReport;
}

+(DeviceMgr *)sharedInstance;

-(void) runTask;

-(void) setIsBusy:(BOOL)busy;

-(BOOL) getIsBusy;

/**
 *  活跃报告
 *
 *  @param succ 成功
 */
//-(void)reportActiveSucc:(CompletionBlock)succ;
@end
