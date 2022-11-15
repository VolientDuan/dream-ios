//
//  ManhuaChapterListViewController.m
//  Dream
//
//  Created by dch on 2022/11/5.
//

#import "ManhuaChapterListViewController.h"
#import "MAnhuaModel.h"
#import <Masonry/Masonry.h>
#import "ManhuaRequestHeader.h"
#import "DreamNetworking.h"
#import <MJExtension.h>
#import "ManhuaDetailController.h"
#import "ManhuaChapterTableViewCell.h"
#import <MJRefresh.h>

@interface ManhuaChapterListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ManhuaChapterListViewController

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
}

- (void)initUI
{
    self.title = self.model.name;
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
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf detailRequest];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - request

- (void)detailRequest
{
    [[DreamNetworking shareInstance] post:ManhuaChapterURL params:@{@"url":self.model.url} completed:^(NSError *error, id response) {
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
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ManhuaChapterTableViewCell cellWithTableView:tableView model:self.dataArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ManhuaDetailController *vc = [ManhuaDetailController new];
    vc.chapterDic = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
