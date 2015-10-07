//
//  MTHomeViewController.m
//  
//
//  Created by Alex on 15/10/3.
//
//

#import "MTHomeViewController.h"
#import "MTConst.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "MTHomeTopItem.h"
#import "MTCategoryViewController.h"
#import "MTdistrickViewController.h"

@interface MTHomeViewController ()
//分类item
@property (nonatomic,weak) UIBarButtonItem *categoryItem;
@property (nonatomic,weak) UIBarButtonItem *districkItem;
@property (nonatomic,weak) UIBarButtonItem *sortItem;

@end

@implementation MTHomeViewController

static NSString * const reuseIdentifier = @"Cell";

//调用时init设置布局的格式
-(instancetype)init
{
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc]init];
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置背景色
    self.collectionView.backgroundColor = MTGlobalBg;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //监听城市改变
    [MTNotificationCeter addObserver:self selector:@selector(cityDidChange:) name:MTcityDidChangeNotification object:nil];
    
    //设置导航栏内容
    [self setupRightNav];
    [self setupLeftNav];
    
}
//销毁通知
-(void)dealloc
{
    [MTNotificationCeter removeObserver:self];
}

#pragma mark - 监听通知
- (void)cityDidChange:(NSNotification *)notification
{
    NSString *cityName = notification.userInfo[MTSelectCityName];
//    1.更换顶部item文字
    MTHomeTopItem *topItem = (MTHomeTopItem *)self.districkItem.customView;//拿到自定义view
    
    [topItem setTitle:[NSString stringWithFormat:@"%@ - 全部",cityName]];//调用setTitle方法
    [topItem setsubTitle:nil];
    
//    2.刷新表格数据
#warning TEDO
    
}

#pragma mark - 设置导航栏内容
-(void)setupRightNav
{
    UIBarButtonItem *mapItem = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_map" highImage:@"icon_map_highlighted"];
    
    mapItem.customView.width = 60;//设置按钮间距；
    
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_search" highImage:@"icon_search_highlighted"];
    
    searchItem.customView.width = 60;
    
    self.navigationItem.rightBarButtonItems =@[mapItem,searchItem];
    //数组接受创建的item
}
-(void)setupLeftNav
{
    //1.logo
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    logoItem.enabled = NO;//继承关系显示非UI控件，无交互属性
    //2.分类
    MTHomeTopItem *categoryTopItem = [MTHomeTopItem item];
    
    [categoryTopItem addTarget:self action:@selector(categoryClicked)];
    
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc]initWithCustomView:categoryTopItem];
    
    self.categoryItem = categoryItem;//声明变量存起来（popover需使用）
    //3.地区
    MTHomeTopItem *districtTopItem = [MTHomeTopItem item];
    
    [districtTopItem addTarget:self action:@selector(districtClicked)];
    
    UIBarButtonItem *districtItem = [[UIBarButtonItem alloc]initWithCustomView:districtTopItem];
    self.districkItem = districtItem;
    //4.排序
    MTHomeTopItem *sortTopItem = [MTHomeTopItem item];
    
    [sortTopItem addTarget:self action:@selector(sortClicked)];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc]initWithCustomView:sortTopItem];
    
    self.sortItem = sortItem;
    //用数组接收items
    self.navigationItem.leftBarButtonItems =@[logoItem,categoryItem,districtItem,sortItem];
}

#pragma mark - 顶部item点击

- (void)categoryClicked
{   //显示分类菜单
    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:[[MTCategoryViewController alloc]init]];
    [popover presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (void)districtClicked
{   //显示区域菜单
    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:[[MTDistrickViewController alloc]init]];
    [popover presentPopoverFromBarButtonItem:self.districkItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
   
}
- (void)sortClicked
{
    MTLog(@"wwssasdas");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
