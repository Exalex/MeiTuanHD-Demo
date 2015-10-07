//
//  MTCityViewController.m
//  
//
//  Created by Alex on 15/10/5.
//
//

const int MTCoverTag = 999;
//cover的tag（常量）

#import "MTCityViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MJExtension.h"
#import "MTCitiyGroup.h"
#import "MTConst.h"
#import "MTCitySearchResultTableViewController.h"
#import "UIView+AutoLayout.h"


@interface MTCityViewController ()<UITableViewDataSource,UITableViewDelegate,UITabBarDelegate,UISearchBarDelegate>
@property (nonatomic, strong) NSArray *citygroups;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *cover;
- (IBAction)cover:(UIButton *)sender;
@property (nonatomic, weak) MTCitySearchResultTableViewController *citySearchResult;

@end

@implementation MTCityViewController
//添加创建搜索controller的方法
-(MTCitySearchResultTableViewController *)citySearchResult
{   //懒加载
    if (!_citySearchResult) {
        MTCitySearchResultTableViewController *citySearchResult = [[MTCitySearchResultTableViewController alloc]init];
        [self addChildViewController:citySearchResult];
        self.citySearchResult = citySearchResult;
    }
    return _citySearchResult;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //基本设置
    self.title = @"设置城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"btn_navigation_close" highImage:@"btn_navigation_close_hl"];
    //表索引文字的颜色
    self.tableView.sectionIndexColor = [UIColor blackColor];

    //载入城市数据
     self.citygroups = [MTCitiyGroup objectArrayWithFilename:@"cityGroups.plist"];
    //设置搜索框局部色
    self.searchBar.tintColor = MTColor(32, 191, 179);
    
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 搜索框代理方法
//代理方法：监控键盘弹出：搜索框开始编辑文字的时候，执行操作。
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //1.输入时导航栏消失
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//显示蒙板
//    UIView *cover = [[UIView alloc]init];
//    cover.backgroundColor = [UIColor blackColor];
//    cover.alpha = 0.5;
//    cover.tag = MTCoverTag;
//点击遮盖就调用方法中的remove
//    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarTextDidEndEditing:)]];
//    [self.view addSubview:cover];
  
    //2.修改搜索框的背景图片（高亮）
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    //3.显示遮盖
   [UIView animateWithDuration:0.3 animations:^{
       [self.cover setAlpha:0.25];
   }];
   //4.显示搜索栏右边取消按钮
    [self.searchBar setShowsCancelButton:YES animated:YES];
    
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{   //输入结束时导航栏出现
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //隐藏蒙板
    [[self.view viewWithTag:MTCoverTag]removeFromSuperview];
    //修改搜索框的背景图片(普通)
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    //遮盖消失
    [UIView animateWithDuration:0.3 animations:^{
    [self.cover setAlpha:0];
    //隐藏搜索栏右边取消按钮
    [self.searchBar setShowsCancelButton:NO animated:YES];
}];
}

//监听文字方法(文字变化时调用)
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText.length) {
        
        [self.view addSubview:self.citySearchResult.view];
        //用第三方库添加约束）
        [self.citySearchResult.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.citySearchResult.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar];
        //把searchText传给citySearchResult
        self.citySearchResult.searchText = searchText;
        
        
    } else {
        [self.citySearchResult.view removeFromSuperview];
    }
}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.citygroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   //拿到MTCityGroup模型数组中section的数量，中cities的数量
    
    MTCitiyGroup *group = self.citygroups[section];
    return group.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID= @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //拿到模型citygroups的section数量，再带到cities的
    MTCitiyGroup *group = self.citygroups[indexPath.section];
    
    cell.textLabel.text = group.cities[indexPath.row];
    
    return cell;
}
#pragma mark - 代理方法

//选中cell后发通知
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTCitiyGroup *group = self.citygroups[indexPath.section];
    
    [MTNotificationCeter postNotificationName:MTcityDidChangeNotification object:nil userInfo:@{MTSelectCityName : group.cities[indexPath.row]}];
 
     [self dismissViewControllerAnimated:YES completion:nil];
}

//分类title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MTCitiyGroup *group = self.citygroups[section];
    
    return group.title;

}

//索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//1.遍历方法：
//    NSMutableArray *titles = [[NSMutableArray alloc]init];
//    for (MTCitiyGroup *group in self.citygroups) {
//        [titles addObject:group.title];
//    }
    
    //1.KVC方法
    // [xx valueForKey @"XX"];
    // ruture ［寻找xx对象的xx属性]；
    return [self.citygroups valueForKey:@"title"];
    
}


//取消按钮代理
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
//    [self cover];
}

//点击遮盖
- (IBAction)cover:(UIButton *)sender {
    
    [self.searchBar resignFirstResponder];
}
@end
