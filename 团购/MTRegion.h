//
//  MTRegion.h
//  
//
//  Created by Alex on 15/10/5.
//
//

#import <Foundation/Foundation.h>


@interface MTRegion : NSObject
//区域名字
@property (nonatomic,copy) NSString *name;
//子区域
@property (nonatomic,strong) NSArray *subregions;
@end
