//
//  MTCitiyGroup.h
//  
//
//  Created by Alex on 15/10/5.
//
//

#import <Foundation/Foundation.h>

@interface MTCitiyGroup : NSObject
//这组的标题
@property (nonatomic,copy) NSString *title;
//这组的所有城市
@property (nonatomic,strong) NSArray *cities;
@end
