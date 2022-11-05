//
//  DreamNetworking.h
//  Dream
//
//  Created by dch on 2022/11/5.
//

#import <Foundation/Foundation.h>

@interface DreamNetworking : NSObject

+ (instancetype)shareInstance;

- (void)get:(NSString *)url params:(id)params completed:(void(^)(NSError *error ,id response))completed;

- (void)post:(NSString *)url params:(id)params completed:(void(^)(NSError *error ,id response))completed;

@end
