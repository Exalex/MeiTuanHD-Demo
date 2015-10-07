//
//  MTHomeTopItem.m
//  
//
//  Created by Alex on 15/10/3.
//
//

#import "MTHomeTopItem.h"

@interface MTHomeTopItem()

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
//@property (weak, nonatomic) IBOutlet UIButton *icon;

@end

@implementation MTHomeTopItem

+(instancetype)item //封装自定义item
{
    return [[[NSBundle mainBundle]loadNibNamed:@"MTHomeTopItem" owner:nil options:nil]firstObject];
  }

-(void)addTarget:(id)target action:(SEL)action
{
    [self.iconBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}
-(void)setsubTitle:(NSString *)subtitle
{
    self.subTitleLabel.text = subtitle;
}
//-(void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon
//{
//    [self.icon setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
//    [self.icon setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
//}

- (IBAction)btn:(UIButton *)sender {
}
@end
