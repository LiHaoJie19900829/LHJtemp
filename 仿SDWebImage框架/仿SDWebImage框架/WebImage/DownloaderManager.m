//
//  DownloaderManager.m
//  仿SDWebImage框架
//
//  Created by 李浩杰 on 16/9/21.
//  Copyright © 2016年 李浩杰. All rights reserved.
//

#import "DownloaderManager.h"
#import "DownloaderOperation.h"


@interface DownloaderManager ()


//全局队列
@property (nonatomic, strong) NSOperationQueue *queue;
//操作op缓存池()
@property (nonatomic, strong) NSMutableDictionary *OPsCache;

@end


@implementation DownloaderManager


//初始化
-(instancetype)init {

    if (self = [super init]) {
        self.OPsCache = [NSMutableDictionary dictionary];
        
        self.queue =[[NSOperationQueue alloc] init];
    }

    return self;
}

+ (instancetype)sharedManager {
    
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
    
}

///单例中   下载图片方法
- (void)downloadImageWithURLString:(NSString *)URLString successBlock:(void(^)(UIImage *image))successBlock {
    
    if ([self.OPsCache objectForKey:URLString]) {
        return;
    }
    
    //定义单例的bolck，，，用来传递单例里面还需要加的一些操作，
    void(^managerBlock)() = ^(UIImage *image){
    
        if (successBlock) {
            successBlock(image);//block是一个匿名函数，，所以可以可以直接调用：如successBlock(image);
        }
    
    };
    
    DownloaderOperation *op = [DownloaderOperation downloaderOperationWithURLString:URLString successBlock:managerBlock];
    
    [self.OPsCache setObject:op forKey:URLString];
    [self.queue addOperation:op];
    
}

//取消下载操作
- (void)cancelDownloadingOperationWithLastURLString:(NSString *)lastURLString {

    DownloaderOperation *op = [self.OPsCache objectForKey:lastURLString];
    if (op != nil) {
        [op cancel];
        [self.OPsCache removeObjectForKey:lastURLString];
    }

}

@end
