//
//  UIImageView+LHJ.h
//  仿SDWebImage框架
//
//  Created by 李浩杰 on 16/9/21.
//  Copyright © 2016年 李浩杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LHJ)


- (void)LHJ_setImageWithURLString:(NSString *)URLString;

@property (nonatomic, copy) NSString *lastURLString;




@end
