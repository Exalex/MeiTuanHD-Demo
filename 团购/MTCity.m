//
//  MTCity.m
//  
//
//  Created by Alex on 15/10/5.
//
//

#import "MTCity.h"
#import "MTRegion.h"
#import "MJExtension.h"

@implementation MTCity
//第三方库，数组里放模型
-(NSDictionary *)objectClassInArray
{
//数组封装模型
    return @{@"regions" : [MTRegion class]};

}

@end
