//
//  ManhuaDetailTableViewCell.m
//  Dream
//
//  Created by dch on 2022/11/5.
//

#import "ManhuaDetailTableViewCell.h"
#import <SDWebImage.h>
#import <Masonry/Masonry.h>

@interface ManhuaDetailTableViewCell()
@property (nonatomic, strong) UIImageView *detailImageView;
@property (nonatomic, copy) void (^block)(NSString *url, CGFloat height);

@end
@implementation ManhuaDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(id)model block:(nonnull void (^)(NSString * _Nonnull, CGFloat))block {
    ManhuaDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManhuaDetailTableViewCell"];
    if (!cell) {
        cell = [[ManhuaDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ManhuaDetailTableViewCell"];
    }
    cell.block = block;
    [cell prepareUrl:model retryTime:5];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)prepareUrl:(NSString *)imgUrl retryTime:(NSInteger)times
{
    if (!times) {
        return;
    }
    __weak __typeof(self) weakSelf = self;
    [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"img_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            [weakSelf prepareUrl:imgUrl retryTime:times-1];
            return;
        }
        if (!image) {
            return;
        }
        CGSize size = image.size;
        if (weakSelf.block) {
            weakSelf.block(imgUrl, UIScreen.mainScreen.bounds.size.width * (size.height/size.width));
        }
    }];
}

- (void)initUI
{
    self.contentView.backgroundColor = [UIColor colorNamed:@"viewBgColor"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.detailImageView  = [[UIImageView alloc]init];
    [self.contentView addSubview:self.detailImageView];
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


@end
