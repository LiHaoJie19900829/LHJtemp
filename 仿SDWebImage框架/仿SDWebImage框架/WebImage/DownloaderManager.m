//
//  DownloaderManager.m
//  仿SDWebImage框架
//
//  Created by 李浩杰 on 16/9/21.
//  Copyright © 2016年 李浩杰. All rights reserved.
//

#import "DownloaderManager.h"
#import "DownloaderOperation.h"


#import "NSString+path.h"


@interface DownloaderManager ()


//全局队列
@property (nonatomic, strong) NSOperationQueue *queue;
////操作op缓存池()
//@property (nonatomic, strong) NSMutableDictionary *OPsCache;
///// 图片内存缓存、、、、、、还要和沙盒缓存一起用
//@property (nonatomic, strong) NSMutableDictionary *imagesCache;

//操作op缓存池()
@property (nonatomic, strong) NSCache *OPsCache;
/// 图片内存缓存、、、、、、还要和沙盒缓存一起用
@property (nonatomic, strong) NSCache *imagesCache;

@end


@implementation DownloaderManager


//初始化
-(instancetype)init {

    if (self = [super init]) {
        self.OPsCache = [[NSCache alloc] init];
        
        self.queue =[[NSOperationQueue alloc] init];
        self.imagesCache = [[NSCache alloc] init];
        
        //注册通知解决内存警告
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMemeoy) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
        
    }

    return self;
}


/// 内存警告的主方法 : 提示 : 如果使用NSCache实现内存缓存,就需要把这个方法注销(NScache会自动释放内存)
- (void)clearMemeoy
{
    //[self.imagesCache removeAllObjects];
    //[self.OPsCache removeAllObjects];
    [self.queue cancelAllOperations];
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
    
    //是否从内存加载
    if ([self checkCache:URLString]) {
        UIImage *image = [self.imagesCache objectForKey:URLString];
        
        
        if (successBlock) {
            successBlock(image);
        }
        
        return;
    }
    
    
    
    
    
    
    
    
    
    // 判断要下载的图片对应的下载操作有没有,如果有,直接返回,不再建立下载操作.反之,就建立下载操作
    if ([self.OPsCache objectForKey:URLString]) {
        return;
    }
    
    //定义单例的bolck，，，用来传递单例里面还需要加的一些操作，
    void(^managerBlock)() = ^(UIImage *image){
        
         NSLog(@"从网络加载...%@",URLString);
        if (successBlock) {
            successBlock(image);//block是一个匿名函数，，所以可以可以直接调用：如successBlock(image);
        }
        
        //图片下载完成，保存到图片内存缓存中，，
        if (image) {
            [self.imagesCache setObject:image forKey:URLString];
        }
        
        
        
        //图片下载完成，，操作池，移除对应操作
        [self.OPsCache removeObjectForKey:URLString];
        
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

//判断，图片内存缓存和沙盒缓存是否存在对应图片，，，存在就从内存下载，，不然从网络下载
- (BOOL)checkCache:(NSString *)URLString {

    if ([self.imagesCache objectForKey:URLString]) {
        NSLog(@"从图片内存加载数据。。。。。。。。%@",URLString);
        return YES;
    }
    
    //沙盒缓存，，有的话，，还需保存到图片内存缓存，，方便读取
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[URLString appendCaches]];
    if (cacheImage) {
       
        NSLog(@"从沙盒加载数据。。。。。。。。%@",URLString);

        [self.imagesCache setObject:cacheImage forKey:URLString];
        return YES;
        
        
        
    }

    return NO;



}








@end
