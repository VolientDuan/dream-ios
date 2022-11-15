//
//  ManhuaTableViewCell.m
//  Dream
//
//  Created by dch on 2022/11/5.
//

#import "ManhuaTableViewCell.h"
#import <SDWebImage.h>
#import <Masonry/Masonry.h>
#import "ManhuaModel.h"

@interface ManhuaTableViewCell()
@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *authorLabel;

@end
@implementation ManhuaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(id)model {
    ManhuaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManhuaTableViewCell"];
    if (!cell) {
        cell = [[ManhuaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ManhuaTableViewCell"];
    }
    [cell prepareModel:model];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)prepareModel:(ManhuaModel *)model
{
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.nameLabel.text = model.name;
    self.contentLabel.text = model.content;
    self.authorLabel.text = model.author;
}

- (void)initUI
{
    self.contentView.backgroundColor = [UIColor colorNamed:@"viewBgColor"];
    self.coverView  = [[UIImageView alloc]init];
    self.coverView.layer.borderColor = [UIColor colorNamed:@"placeholderColor"].CGColor;
    self.coverView.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.coverView];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.leading.top.mas_equalTo(12);
    }];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textColor = [UIColor colorNamed:@"textColor"];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.coverView.mas_trailing).offset(5);
        make.trailing.mas_equalTo(-15);
        make.top.equalTo(self.coverView);
    }];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.textColor = [UIColor colorNamed:@"textColor"];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.numberOfLines = 2;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.coverView.mas_trailing).offset(5);
        make.trailing.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
    }];
    
    self.authorLabel = [UILabel new];
    self.authorLabel.textColor = [UIColor colorNamed:@"textColor"];
    self.authorLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.authorLabel];
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.coverView.mas_trailing).offset(5);
        make.trailing.equalTo(self.nameLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(5);
    }];
}

@end

