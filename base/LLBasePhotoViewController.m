//
//  LLBasePhotoViewController.m
//  lovelive
//
//  Created by 91wan on 16/1/18.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "LLBasePhotoViewController.h"
#import "LLActionSheet.h"
@interface LLBasePhotoViewController ()<LLActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation LLBasePhotoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _allowsEditing=YES;
}
/**
 *  请选择相机 或 相册
 */
-(void)initPhoto
{
    LLActionSheet *menu = [[LLActionSheet alloc]
                           initWithTitle: nil
                           delegate:self
                           cancelButtonTitle:LLLangHmn(@"cancel", @"取消")
                           destructiveButtonTitle:nil
                           otherButtonTitles:LLLangHmn(@"camera", @"相机"),LLLangHmn(@"photo", @"相册"),nil];
    [menu showInView:self.view];
}

# pragma mark LLActionSheetDelegate method
- (void)actionSheet:(LLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self photoCamera];//相机
    }else if(buttonIndex==1){
        [self photoAlbumr];//相册
    }else if(buttonIndex==2){
    }
}
#pragma mark --UIImagePickerControllerDelegate
//启动相册
-(void)photoAlbumr{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker =[[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else {
        [self showAlert:LLLangHmn(@"noCameraAndNoPhoto", @"在设备的\"设置-隐私-相机\"中允许访问相机。")];
    }
    
    
}
//启动相机
-(void)photoCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController* imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagepicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagepicker.allowsEditing = YES;
        [self presentViewController:imagepicker animated:YES completion:nil];
    }else {
        [self showAlert:LLLangHmn(@"noCameraGongNeng", @"设备不支持拍照功能")];
    }
}

#pragma mark UIImagePicker method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    UIImage *newimage = nil;
    if(_allowsEditing)
        newimage = [info objectForKey:UIImagePickerControllerEditedImage];
    else
        newimage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self backImage:newimage];
        //设置状态栏的字体为白色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    }];
}
// 完成选取
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //设置状态栏的字体为白色
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}
/**
 *  回调图片 之类需要实现这个方法
 *
 *  @param image 图片
 */
-(void)backImage:(UIImage *)image
{
}
@end
