//
//  MTCitySearchResultTableViewController.m
//  
//
//  Created by Alex on 15/10/6.
//
//

#import "MTCitySearchResultTableViewController.h"
#import "MTConst.h"
#import "MTCity.h"
#import "MJExtension.h"
@interface MTCitySearchResultTableViewController ()
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NSMutableArray *resultCities;
@end

@implementation MTCitySearchResultTableViewController

//懒加载拿到模型
- (NSArray *)cities
{
    if (!_cities) {
        self.cities = [MTCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
//被传文字后要重写set方法
- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    _searchText = searchText.uppercaseString;
    //把输入数据改成大写好让对比忽略大小写
    NSLog(@"正在输入文字%@",searchText);
    //每次输入改变都要更新arry
    self.resultCities = [NSMutableArray array];
    //根据关键字搜索想要的城市数据（遍历）
    for (MTCity *city in self.cities) {
        //城市的name中包含了searchText
        //城市的pinYin中包含了
        //城市的pinYinHead包含了
        if ([city.name containsString: self.searchText] || [city.pinYin.uppercaseString containsString:self.searchText] ||
            [city.pinYinHead.uppercaseString containsString:self.searchText]) {
            [self.resultCities addObject:city];
        }
    }
    //刷新数组
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    MTCity *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}
//表头（共有xx种搜索结果）
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共有%d个搜索结果",self.resultCities.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTCity *city = self.resultCities[indexPath.row];
    
    [MTNotificationCeter postNotificationName:MTcityDidChangeNotification object:nil userInfo:@{MTSelectCityName : city.name}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
