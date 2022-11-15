//
//  DreamRootRouter.m
//  Dream
//
//  Created by duan on 2022/11/15.
//

#import "DreamRootRouter.h"
#import "ManhuaListViewController.h"

@implementation DreamRootRouter

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static DreamRootRouter *router = nil;
    dispatch_once(&onceToken, ^{
        router = [DreamRootRouter new];
    });
    return router;
}

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
        _window.rootViewController = ManhuaListViewController.new;
        [_window makeKeyAndVisible];
    }
    return _window;
}

@end
