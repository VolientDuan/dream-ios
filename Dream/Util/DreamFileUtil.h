//
//  DreamFileUtil.h
//  Dream
//
//  Created by duanxiancai on 2022/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DreamFileUtil : NSObject
+ (instancetype)shareInstance;


#pragma mark - 业务
@property (nonatomic, readonly) NSString *dreamFolderPath;
- (void)createDreamFolder;

@end

NS_ASSUME_NONNULL_END
