//
//  LocalViewController.h
//  lovelive
//
//  Created by Circle on 15/11/26.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//
typedef enum{
    LOCAL_NORMOL = 0,
    LOCAL_NEED_ADDITION = 1
}LocalListType;

#import "BaseViewController.h"
@class NowLocalModel;
@protocol LocalViewControllerDelegate <NSObject>
-(void)localViewPickerResults:(NowLocalModel *)results;
@end

@interface LocalViewController : BaseViewController
@property (copy, nonatomic) NSString *nation;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *city;

@property (copy, nonatomic) NSString *nationText;
@property (copy, nonatomic) NSString *provinceText;
@property (copy, nonatomic) NSString *cityText;

@property (nonatomic, weak) id<LocalViewControllerDelegate> delegate;
@property (assign, nonatomic) LocalListType localType;
@end