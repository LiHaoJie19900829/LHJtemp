//
//  ViewController.m
//  仿SDWebImage框架
//
//  Created by 李浩杰 on 16/9/19.
//  Copyright © 2016年 李浩杰. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

#import "YYModel.h"
#import "APPModel.h"
#import "DownloaderOperation.h"


#import "DownloaderManager.h"

#import "UIImageView+LHJ.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

//所有json数据转数组数据
@property (nonatomic, strong) NSArray *appList;
//全局队列
@property (nonatomic, strong) NSOperationQueue *queue;
//操作op缓存池()
@property (nonatomic, strong) NSMutableDictionary *OPsCache;
//上一次图片地址
@property (nonatomic, copy) NSString *lastURLString;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = [[NSOperationQueue alloc] init];
    
    self.OPsCache = [NSMutableDictionary dictionary];
    
    
    [self LoadJsonData];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //获取随机数
    NSInteger random = arc4random_uniform((u_int32_t)self.appList.count);

    APPModel *app = self.appList[random];
    
    
    //使用UIimageview分类实现图片下载
    [self.iconImageView LHJ_setImageWithURLString:app.icon];
    
    
    
    
 ///Users/lihaojie/Library/Developer/CoreSimulator/Devices/D0BC7700-13F0-4917-AED2-4D04FC936F62/data/Containers/Data/Application/1EE2B820-D016-4CAC-BDF4-F432A779B5B0
    
    
    
    
    //判断俩次传入图片地址是否一样， 如果不一样，把正在执行的操作op取消掉（不相等取消，就是让回传的block不调用）
//    if (![app.icon isEqualToString:self.lastURLString] && self.lastURLString != nil) {
//        
//        //单列实现取消下载操作
//        [[DownloaderManager sharedManager] cancelDownloadingOperationWithLastURLString:self.lastURLString];
    
//        [[self.OPsCache objectForKey:self.lastURLString] cancel];
//        //移除op操作，，同时要把op缓存池中也删除
//        [self.OPsCache removeObjectForKey:self.lastURLString];
        
//    }
//    
//    //保存上次图片地址
//    self.lastURLString = app.icon;
    
    
//    DownloaderOperation *op = [DownloaderOperation downloaderOperationWithURLString:app.icon successBlock:^(UIImage *image) {
//        self.iconImageView.image = image;
//    }];
//    
//    [self.OPsCache setObject:op forKey:app.icon];
//    [self.queue addOperation:op];
    
    
    //单例downloadermanager类实现下载功能
    
//    [[DownloaderManager sharedManager] downloadImageWithURLString:app.icon successBlock:^(UIImage *image) {
//        self.iconImageView.image = image;
//    }];
    
    
    
    
}













///加载json数据
- (void)LoadJsonData {
    //https://raw.githubusercontent.com/LiHaoJie19900829/LHJtemp/master/apps.json
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://raw.githubusercontent.com/LiHaoJie19900829/LHJtemp/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.appList = [NSArray yy_modelArrayWithClass:[APPModel class] json:responseObject];
        
        NSLog(@"%@",self.appList);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];


}
























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
