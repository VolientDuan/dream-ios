//
//  DreamFileUtil.m
//  Dream
//
//  Created by duanxiancai on 2022/11/3.
//

#import "DreamFileUtil.h"

#define DreamFileMoudle @"DreamFileMoudle"

@interface DreamFileUtil()

@end

@implementation DreamFileUtil

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static DreamFileUtil *fileUtil = nil;
    dispatch_once(&onceToken, ^{
        fileUtil = [DreamFileUtil new];
    });
    return fileUtil;
}

#pragma mark - 业务

- (NSString *)dreamFolderPath
{
    return [self getFileDocumentPath:[NSString stringWithFormat:@"%@",DreamFileMoudle]];
}

- (void)createDreamFolder
{
    [self createDirectoryAtDocument:DreamFileMoudle];
}

#pragma mark - 文件

- (NSString *)getDocumentPath
{
    // 获取文档目录路径
    NSArray *userPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [userPaths objectAtIndex:0];
}

- (NSString *)getFileDocumentPath:(NSString *)fileName
{
    if (nil == fileName)
    {
        return nil;
    }
    NSString *documentDirectory = [self getDocumentPath];
    NSString *fileFullPath = [documentDirectory stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

- (BOOL)isExistFile:(NSString *)aFilePath
{
    if (aFilePath == nil || aFilePath.length == 0)
    {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:aFilePath];
}

- (BOOL)createDirectoryAtDocument:(NSString *)dirName
{
    if (nil == dirName)
    {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [self getFileDocumentPath:dirName];
    if ([fileManager fileExistsAtPath:dirPath])
    {
        return YES;
    }
    
    BOOL succ = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}

- (BOOL)removeFolderInDocumet:(NSString *)aFolderNameInDoc
{
    if (aFolderNameInDoc == nil || aFolderNameInDoc.length == 0)
    {
        return YES;
    }
    NSString *filePath = [self getFileDocumentPath:aFolderNameInDoc];
    if (nil == filePath)
    {
        return YES;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}

- (void)clearCacheFile {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self removeFolderInDocumet:DreamFileMoudle];
    });
}

@end
