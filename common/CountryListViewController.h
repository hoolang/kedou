//
//  CountryListViewController.h
//  lovelive
//
//  Created by Circle on 15/11/27.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseViewController.h"
typedef enum{
    COUNTRY_NAME = 0,//国家名列表
    COUNTRY_AREA_CODE = 1,//国家名+国家区号列表
} CountryListStyle;

@class LocalModel;
@protocol CountryListViewDelegate <NSObject>
-(void)countryListDidSelected:(LocalModel *)results;
@end

@interface CountryListViewController : BaseViewController
@property (nonatomic, weak) id<CountryListViewDelegate> delegate;
@property (nonatomic, assign) CountryListStyle listStyle;
@end
