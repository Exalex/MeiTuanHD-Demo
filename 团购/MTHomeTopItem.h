//
//  MTHomeTopItem.h
//  
//
//  Created by Alex on 15/10/3.
//
//

#import <UIKit/UIKit.h>

@interface MTHomeTopItem : UIView

+(instancetype)item;

//设置点击的监听器 target监听器 action监听方法
-(void)addTarget:(id)target action:(SEL)action;

-(void)setTitle:(NSString *)title;
-(void)setsubTitle:(NSString *)subtitle;
//-(void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon;
@end

