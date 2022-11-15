//
//  ManhuaChapterTableViewCell.m
//  Dream
//
//  Created by dch on 2022/11/5.
//

#import "ManhuaChapterTableViewCell.h"
#import <Masonry/Masonry.h>
@interface ManhuaChapterTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;

@end
@implementation ManhuaChapterTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(id)model {
    ManhuaChapterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManhuaChapterTableViewCell"];
    if (!cell) {
        cell = [[ManhuaChapterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ManhuaChapterTableViewCell"];
        
    }
    cell.nameLabel.text = model[@"title"] ?: @"未命名";
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.contentView.backgroundColor = [UIColor colorNamed:@"viewBgColor"];
    self.nameLabel = [UILabel new];
    self.nameLabel.textColor = [UIColor colorNamed:@"textColor"];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(12, 12, 12, 12));
    }];
}

@end
