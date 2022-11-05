//
//  ViewController.m
//  Dream
//
//  Created by duanxiancai on 2022/11/1.
//

#import "ViewController.h"
#import "dream.h"
#import "DreamFileUtil.h"
#import <Masonry/Masonry.h>
#import "DreamNetworking.h"
#import <MJExtension.h>
#import "ManhuaModel.h"
#import "ManhuaTableViewCell.h"
#import "ManhuaChapterListViewController.h"
#import <MJRefresh.h>
#import "ManhuaRequestHeader.h"

@interface ViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITextField *searchTextFiled;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

void logFunc(const char *msg)
{
    NSLog(@"%@",[[NSString alloc]initWithUTF8String:msg]);
}

@implementation ViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[DreamFileUtil shareInstance] createDreamFolder];
//
//    setLogger((GoUintptr)logFunc);
//    NSString *path = [DreamFileUtil shareInstance].dreamFolderPath;
//    NSLog(@"iOS Path:%@",path);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        startFileServer(8080, (GoString){path.UTF8String,strlen(path.UTF8String)});
//    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        startManhuaServer(ManhuaPort);
    });
    
    self.page = 1;
    [self initUI];
    // Do any additional setup after loading the view.
}


- (void)initUI
{
    self.view.backgroundColor = [UIColor colorNamed:@"viewBgColor"];
    UIButton *searchBtn = [[UIButton alloc]init];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorNamed:@"textColor"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClickEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 30));
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
        make.trailing.mas_equalTo(-15);
    }];
    
    self.searchTextFiled = [[UITextField alloc]init];
    self.searchTextFiled.textColor = [UIColor colorNamed:@"textColor"];
    self.searchTextFiled.placeholder = @"输入漫画名称";
    self.searchTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    self.searchTextFiled.keyboardType = UIKeyboardTypeWebSearch;
    self.searchTextFiled.delegate = self;
    [self.view addSubview:self.searchTextFiled];
    [self.searchTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchBtn);
        make.trailing.equalTo(searchBtn.mas_leading).mas_equalTo(-10);
        make.leading.mas_equalTo(15);
        make.height.mas_equalTo(40);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorNamed:@"viewBgColor"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchTextFiled.mas_bottom).offset(15);
        make.bottom.leading.trailing.mas_equalTo(0);
    }];
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page = weakSelf.page + 1;
        [weakSelf searchRequest];
    }];
}

#pragma mark reloadView

- (void)reloadView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    });
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
    return 104;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ManhuaTableViewCell cellWithTableView:tableView model:self.dataArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ManhuaChapterListViewController *vc = [ManhuaChapterListViewController new];
    vc.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - request

- (void)searchRequest
{
    [[DreamNetworking shareInstance] get:ManhuaSearchURL params:@{@"key":self.searchTextFiled.text,@"page":@(self.page)} completed:^(NSError *error, id response) {
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[ManhuaModel mj_objectArrayWithKeyValuesArray:response]];
            [self reloadView];
        } else {
            if (!response || ((NSArray *)response).count == 0) {
                self.page = self.page - 1;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                });
                return;
            }
            [self.dataArray addObjectsFromArray:[ManhuaModel mj_objectArrayWithKeyValuesArray:response]];
            [self reloadView];
        }
        
    }];
}

#pragma mark - ButtonEvent

- (void)searchClickEvent
{
    [self.view endEditing:YES];
    if (!self.searchTextFiled.text.length) {
        return;
    }
    self.page = 1;
    [self searchRequest];
}

#pragma mark - TextFiledDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchClickEvent];
    return YES;
}

@end
