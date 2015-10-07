//
//  MTHomeDropdown.m
//  
//
//  Created by Alex on 15/10/4.
//
//

#import "MTHomeDropdown.h"
#import "MTCategory.h"

@interface MTHomeDropdown()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

//用来记录被选中分类数据的属性
@property (nonatomic, strong) MTCategory *selectedCategory;

@end

@implementation MTHomeDropdown

+(instancetype)dropDown
{
    return [[[NSBundle mainBundle]loadNibNamed:@"MTHomeDropdown" owner:nil options:nil]firstObject];
}
-(void)setCategories:(NSArray *)categories
{
    _categories = categories;//重写接收到的数组
    
    [self.mainTableView reloadData];//拿到数据就通知tableview刷新
}

#pragma mark - 实现数据源放法 (用if判断区分主从表)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   //用if判断区分主从表
    
    if (tableView == _mainTableView) {
        return self.categories.count;
    }else{
        return self.selectedCategory.subcategories.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == self.mainTableView) {
        static NSString *mainID = @"main-cell";
        cell = [tableView dequeueReusableCellWithIdentifier:mainID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainID];
        //美化cell：给cell加下划线的图片
            cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
            
            cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
        }
        
        //重要！显示文字（拿模型类的变量接收数组）
        MTCategory *category = self.categories[indexPath.row];
        
        cell.textLabel.text = category.name;
        cell.imageView.image = [UIImage imageNamed:category.small_icon];
        //设置tableviewcell右边小箭头
        if (category.subcategories.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;        }
 
    }else{
        
        static NSString *mainID = @"sub-cell";
        cell = [tableView dequeueReusableCellWithIdentifier:mainID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainID];
            //给cell加背景view
            cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
            cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
        }
        cell.textLabel.text = self.selectedCategory.subcategories[indexPath.row];
    }
        return cell;
}

#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.判断点击是否为主表cell 2.点击的cell是否subcategories有值 3.通知subtableView刷新数据 4.然后就调用数据源方法。
    if (tableView == _mainTableView) {
    //被点击的分类
        self.selectedCategory = self.categories[indexPath.row];
    //刷新右边数据，调用数据源方法进入else分支
        [self.subTableView reloadData];
    
    }
}

@end
