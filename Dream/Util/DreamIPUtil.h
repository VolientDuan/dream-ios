//
//  DreamIPUtil.h
//  Dream
//
//  Created by dch on 2022/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DreamIPUtil : NSObject

+ (NSString *)getLocalIPAddress:(BOOL)preferIPv4;

@end

NS_ASSUME_NONNULL_END
