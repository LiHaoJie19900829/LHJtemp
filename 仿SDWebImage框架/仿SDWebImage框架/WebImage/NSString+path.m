//
//  NSString+path.m
//  仿SDWebImage框架
//
//  Created by 李浩杰 on 16/9/21.
//  Copyright © 2016年 李浩杰. All rights reserved.
//

#import "NSString+path.h"
#import "NSString+Hash.h"
@implementation NSString (path)


- (NSString *)appendCaches
{
       // 获取caches文件路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *name = [self md5String];
    // caches文件路径拼接文件名,得到文件缓存的全路径
    NSString *filePath = [path stringByAppendingPathComponent:name];
    
    return filePath;
}


@end
