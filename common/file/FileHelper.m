//
//  FileHelper.m
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import "FileHelper.h"

static FileHelper *instance;

@implementation FileHelper

+(FileHelper *)sharedInstance
{
    if(instance==nil)
    {
        instance=[[FileHelper alloc] init];
    }
    return instance;
}

-(NSString *)getDocumentPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

-(BOOL)isExistPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

- (BOOL)addSkipBackupAttributeToItemAtURL_iOS5_1:(NSURL *)URL

{
    
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    
    
    NSError *error = nil;
    
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                    
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    
    if(!success){
        
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        
    }
    
    return success;
    
}


#pragma mark - Setting the Extended Attribute on iOS 5.0.1



-(BOOL)createDirectory:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error=nil;
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    if(error!=nil)
    {
        NSLog(@"创建文件夹失败:%@",error);
        return NO;
    }
    
    NSURL *urlDefault=[NSURL fileURLWithPath:path];
    NSString *strVersion = [[UIDevice currentDevice] systemVersion];
    
    float fVersion = 0.0;
    
    if(strVersion.length > 0)
        
        fVersion = [strVersion floatValue];
    
    [self addSkipBackupAttributeToItemAtURL_iOS5_1:urlDefault];
    
    return YES;
}

-(id)getObjectFromPath:(NSString *)path
{
    if(![self isExistPath:path])
    {
        NSLog(@"传入的文件不存在:%@",path);
        return nil;
    }
    NSData *data=[NSData dataWithContentsOfFile:path];
    return data;
}


-(void)writeObject:(id)obj toDestionPath:(NSString *)destionPath
{
    BOOL writeResult = [obj writeToFile:destionPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"writeResult : %d", writeResult);
}


-(void)archiverModel:(id)model filePath:(NSString *)filePath
{
    NSMutableData *archiverData=[[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
    [archiver encodeObject:model forKey:@"Data"];
    [archiver finishEncoding];
    [archiverData writeToFile:filePath atomically:YES];
}

-(id)unArchiverModel:(NSString *)filePath
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath])
    {
        return nil;
    }
    
    NSData *unArchiverData=[[NSData alloc] initWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:unArchiverData];
    id model=[unarchiver decodeObjectForKey:@"Data"];
    [unarchiver finishDecoding];
    return model;
}

-(BOOL)removeItemAtPath:(NSString *)path
{
    BOOL flag=NO;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL isDirectory= NO;
    [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    if(!isDirectory)
    {
        flag= [fileManager removeItemAtPath:path error:nil];
    }
    else {
        NSError *error=nil;
        NSArray *sublist=[fileManager contentsOfDirectoryAtPath:path error:&error];
        if(error!=nil)
        {
            NSLog(@"%@",error);
            flag=NO;
        }
        else {
            for(NSString *fileName in sublist)
            {
                NSString *filePath=[path stringByAppendingPathComponent:fileName];
                [self removeItemAtPath:filePath];
            }
            error=nil;
            flag= [fileManager removeItemAtPath:path error:&error];
            if(error!=nil)
            {
                NSLog(@"%@",error);
            }
        }
    }
    return flag;
}

-(NSMutableArray *)getFilelistByPath:(NSString *)path onlyDirectory:(BOOL)flag
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL isDirectory=NO;
    if(![fileManager fileExistsAtPath:path isDirectory:&isDirectory])
    {
        return nil;
    }
    if(!isDirectory)
    {
        return nil;
    }
    NSError *error=nil;
    NSArray *filelist= [fileManager contentsOfDirectoryAtPath:path error:&error];
    if(error!=nil)
    {
        NSLog(@"%@",error);
        return nil;
    }
//    NSMutableArray *datalist=[NSMutableArray array];
    NSMutableArray *datalist=[[NSMutableArray alloc] init];
    for(NSString *fileName in filelist)
    {
        isDirectory=NO;
        NSString *subFilePath=[path stringByAppendingPathComponent:fileName];
        [fileManager fileExistsAtPath:subFilePath isDirectory:&isDirectory];
        if(flag)
        {
            if(isDirectory)
            {
                [datalist addObject:subFilePath.lastPathComponent];
            }
        }
        else {
            [datalist addObject:subFilePath.lastPathComponent];
        }
    }
    return datalist;
}

-(int)getFileCountByPath:(NSString *)directoryPath
{
    NSError*error=nil;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *filelist=[fileManager contentsOfDirectoryAtPath:directoryPath error:&error];
    if(error!=nil)
    {
        NSLog(@"%@",error);
        return 0;
    }
    int fileCount=0;
    for(NSString *fileName in filelist)
    {
        if([fileName rangeOfString:@"Store"].location==NSNotFound)
        {
            fileCount++;
        }
    }
    return fileCount;
}

-(void)moveFilesFrom:(NSString *)path toDestionPath:(NSString *)destionPath
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
     NSError *error=nil;
    [fileManager moveItemAtPath:path toPath:destionPath error:&error];
    if(error!=nil)
    {
        NSLog(@"%@",error);
    }
}
@end
