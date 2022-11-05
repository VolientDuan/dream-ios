//
//  DreamNetworking.m
//  Dream
//
//  Created by dch on 2022/11/5.
//

#import "DreamNetworking.h"
#import <AFNetworking.h>
@interface DreamNetworking()
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end
@implementation DreamNetworking

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static DreamNetworking *share = nil;
    dispatch_once(&onceToken, ^{
        share = DreamNetworking.new;
    });
    return share;
}

- (AFURLSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [[AFJSONRequestSerializer alloc]init];
    }
    return _manager;
}

- (void)get:(NSString *)url params:(id)params completed:(void (^)(NSError *, id))completed
{
    [self.manager GET:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completed) {
            completed(nil, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completed) {
            completed(error, nil);
        }
    }];
}

- (void)post:(NSString *)url params:(id)params completed:(void(^)(NSError *error ,id response))completed
{
    [self.manager POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completed) {
            completed(nil, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completed) {
            completed(error, nil);
        }
    }];
}

@end
