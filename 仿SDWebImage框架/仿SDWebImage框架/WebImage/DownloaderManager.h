//
//  DownloaderManager.h
//  仿SDWebImage框架
//
//  Created by 李浩杰 on 16/9/21.
//  Copyright © 2016年 李浩杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloaderManager : NSObject

///单列模式实现下载管理类
+ (instancetype)sharedManager;




///单例中   下载图片方法
- (void)downloadImageWithURLString:(NSString *)URLString successBlock:(void(^)(UIImage *image))successBlock;



///单例，取消上次下载操作
- (void)cancelDownloadingOperationWithLastURLString:(NSString *)lastURLString;
@end
