//
//  DreamRootRouter.h
//  Dream
//
//  Created by duan on 2022/11/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DreamRootRouter : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong) UIWindow *window;

@end

NS_ASSUME_NONNULL_END
