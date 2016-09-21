//
//  UIImageView+LHJ.m
//  仿SDWebImage框架
//
//  Created by 李浩杰 on 16/9/21.
//  Copyright © 2016年 李浩杰. All rights reserved.
//

#import "UIImageView+LHJ.h"
#import <objc/runtime.h>


#import "DownloaderManager.h"

//@interface UIImageView (LHJ)
//{
//
//
////@property (nonatomic, copy) NSString *lastURLString;
//}
//@end


//static NSString *lastURLString = nil;
@implementation UIImageView (LHJ)
//{
//
//   NSString *_lastURLString;
//
//}
- (void)setLastURLString:(NSString *)lastURLString
{
    
    objc_setAssociatedObject(self, "key", lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastURLString
{
    
    return objc_getAssociatedObject(self, "key");
}



- (void)LHJ_setImageWithURLString:(NSString *)URLString {
    
    
    
    if (![URLString isEqualToString:self.lastURLString] && self.lastURLString != nil) {
        
        //单列实现取消下载操作
        [[DownloaderManager sharedManager] cancelDownloadingOperationWithLastURLString:self.lastURLString];        
    }
    
    //保存上次图片地址
    self.lastURLString = URLString;
    
    
    [[DownloaderManager sharedManager] downloadImageWithURLString:URLString successBlock:^(UIImage *image) {
        self.image = image;
    }];
    
    
    
    
}




@end
