//
//  DownloaderOperation.h
//  仿SDWebImage框架
//
//  Created by 李浩杰 on 16/9/19.
//  Copyright © 2016年 李浩杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface DownloaderOperation : NSOperation



//自定义操作对象方法，，返回操作对象
+ (instancetype)downloaderOperationWithURLString:(NSString *)URLString successBlock:(void(^)(UIImage *image))successBlock;



@end
