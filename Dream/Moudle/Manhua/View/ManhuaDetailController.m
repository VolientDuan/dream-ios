//
//  ManhuaDetailController.m
//  Dream
//
//  Created by dch on 2022/11/5.
//

#import "ManhuaDetailController.h"
#import "ManhuaRequestHeader.h"
#import "DreamNetworking.h"
#import "ManhuaDetailTableViewCell.h"
#import <Masonry/Masonry.h>

@interface ManhuaDetailController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ManhuaDetailController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self detailRequest];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    self.title = self.chapterDic[@"title"] ?: @"未命名";
    self.view.backgroundColor = [UIColor colorNamed:@"viewBgColor"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorNamed:@"viewBgColor"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
}

- (void)reloadView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - request

- (void)detailRequest
{
    [[DreamNetworking shareInstance] post:ManhuaDetailURL params:@{@"url":self.chapterDic[@"url"] ?: @""} completed:^(NSError *error, id response) {
        if (error) {
            return;
        }
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:response];
        [self reloadView];
    }];
}

#pragma mark - tableView Delegate/Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UIScreen.mainScreen.bounds.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ManhuaDetailTableViewCell cellWithTableView:tableView model:self.dataArray[indexPath.row]];
}


@end
