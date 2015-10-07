//
//  MTCity.h
//  
//
//  Created by Alex on 15/10/5.
//
//

#import <Foundation/Foundation.h>

@interface MTCity : NSObject
//城市名
@property (nonatomic,copy) NSString *name;
//城市名拼音
@property (nonatomic,copy) NSString *pinYin;
//城市名拼音首字母
@property (nonatomic,copy) NSString *pinYinHead;
//区域（存放MTRegion模型）
@property (nonatomic,strong) NSArray *regions;


@end
