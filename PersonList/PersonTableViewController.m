//
//  PersonTableViewController.m
//  PersonList
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "PersonTableViewController.h"
#import "ChineseString.h"

@interface PersonTableViewController ()
/// 索引数组
@property(nonatomic,strong)NSMutableArray *indexArray;
/// 处理后的联系人列表
@property(nonatomic,strong)NSMutableArray *letterResultArr;
/// 搜索框
@property (nonatomic, strong)UISearchDisplayController *searchDisplayController;
/// 搜索的数据
@property (nonatomic, strong)NSArray *filterData;

@end

@implementation PersonTableViewController
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self initData];
    self.tableView.sectionIndexColor = [UIColor grayColor];
}

/**
 *  初始化数据
 */
- (void)initData {
    self.stringsToSort = [NSArray arrayWithObjects:
                          @"￥hhh, .$",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
                          @"开源技术",@"社区",@"开发者",@"传播",
                          @"2014",@"a1",@"100",@"中国",@"暑假作业",
                          @"键盘", @"鼠标",@"hello",@"world",@"b1",
                          nil];
    self.indexArray = [ChineseString IndexArray:self.stringsToSort];
    self.letterResultArr = [ChineseString LetterSortArray:self.stringsToSort];
}

/**
 *  设置导航条
 */
- (void)setupNav {
    self.title = @"联系人";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
}

/**
 *  取消事件
 */
- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return self.indexArray.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return [self.letterResultArr[section] count];
    }else{
        // 谓词搜索
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",self.searchDisplayController.searchBar.text];
        self.filterData =  [[NSArray alloc] initWithArray:[self.stringsToSort filteredArrayUsingPredicate:predicate]];
        return self.filterData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (tableView == self.tableView) {
        NSArray *results = self.letterResultArr[indexPath.section];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", results[indexPath.row]];
    }else{
        cell.textLabel.text = self.filterData[indexPath.row];
    }
    
    return cell;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *result;
    if (tableView == self.tableView) {
        NSArray *results = self.letterResultArr[indexPath.section];
        result = results[indexPath.row];
        NSLog(@"%@", results[indexPath.row]);
    }else {
        result = self.filterData[indexPath.row];
        NSLog(@"%@", self.filterData[indexPath.row]);
    }
    if ([self.delegate respondsToSelector:@selector(personTableViewController:didSelect:)]) {
        [self.delegate personTableViewController:self didSelect:result];
    }
}

#pragma mark - 懒加载
- (UISearchDisplayController *)searchDisplayController {
    if (_searchDisplayController) {
        return _searchDisplayController;
    }
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    searchBar.placeholder = @"搜索";
    
    // 添加 searchbar 到 headerview
    self.tableView.tableHeaderView = searchBar;
    // 用 searchbar 初始化 SearchDisplayController
    // 并把 searchDisplayController 和当前 controller 关联起来
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    // searchResultsDataSource 就是 UITableViewDataSource
    _searchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 就是 UITableViewDelegate
    _searchDisplayController.searchResultsDelegate = self;
    return _searchDisplayController;
}


@end
