//
//  ManhuaDetailTableViewCell.h
//  Dream
//
//  Created by dch on 2022/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManhuaDetailTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(id)model block:(void(^)(NSString *url, CGFloat height))block;

@end

NS_ASSUME_NONNULL_END
