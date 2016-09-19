//
//  APPModel.m
//  仿SDWebImage框架
//
//  Created by 李浩杰 on 16/9/19.
//  Copyright © 2016年 李浩杰. All rights reserved.
//

#import "APPModel.h"

@implementation APPModel


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@",self.name,self.download,self.icon];
}

@end
