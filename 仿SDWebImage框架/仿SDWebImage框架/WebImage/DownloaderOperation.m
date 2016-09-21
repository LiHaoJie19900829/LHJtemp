//
//  DownloaderOperation.m
//  仿SDWebImage框架
//
//  Created by 李浩杰 on 16/9/19.
//  Copyright © 2016年 李浩杰. All rights reserved.
//

#import "DownloaderOperation.h"


@interface DownloaderOperation ()

@property (nonatomic, copy) NSString *URLString;
@property (nonatomic, copy) void(^successBlock)(UIImage *image);

@end



@implementation DownloaderOperation


//这个方法先于main方法调用
+ (instancetype)downloaderOperationWithURLString:(NSString *)URLString successBlock:(void (^)(UIImage *))successBlock {

    DownloaderOperation *op = [[DownloaderOperation alloc] init];
    
    op.URLString = URLString;
    op.successBlock = successBlock;

    return op;

}

//队列调用操作时，，先调用start方法，，再执行main方法（这里重写main方法）




- (void)main {

    [NSThread sleepForTimeInterval:2.0];
    
    
    
    NSURL *url = [NSURL URLWithString:self.URLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    //一般在耗时操作后拦截:在控制器中设置isCancelled为YEs,,,拦截就是不让block回调
    if (self.isCancelled) {
        NSLog(@"取消   %@",self.URLString);
        return ;
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        
        NSLog(@"完成 %@",self.URLString);

        self.successBlock(image);
    }];
}

@end
