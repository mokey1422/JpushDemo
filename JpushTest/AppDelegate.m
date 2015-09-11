//
//  AppDelegate.m
//  JpushTest
//
//  Created by 张国兵 on 15/8/31.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     *  极光推送使用说明（从控制台到前段全部过程）
     *1、使用极光首先需要配置其开发环境找到自己的控制台创建应用获取key
     *   *创建支持推送的AppID，或者在现有的AppID的基础上编辑打开推送一开始推送功能显示的是一个小黄点并显示configable没关系这是在提示你要去配置证书环境了
     *   *创建完成之后就要配置证书环境：生产环境和测试环境
     *   *证书创建Apple Push Notification service SSL (Sandbox)、Apple Push Notification service SSL (Production)
     *   *生成证书需要生成证书的请求这个去钥匙串里面去找钥匙串请求->证书助理->从颁发机构请求证书
     *   *配置完成之后你会发现小黄点变成小绿点了恭喜你你已经成功了
     *   *在钥匙串中找到你生成的两张证书并导出极光配置环境需要，将导出的p12文件分别拖到控制台的测试环境项和生产环境项提交创建获取到App_key
     *   *证书环境配置成功之后就需要生成两张描述文件也是一张测试用、一张生产环境下用
     *   *做到这一步基本上控制台的工作就完成了接下来就是前端的配置
     *2、前端配置
     *   *必要的框架
         CFNetwork.framework
         CoreFoundation.framework
         CoreTelephony.framework
         SystemConfiguration.framework
         CoreGraphics.framework
         Foundation.framework
         UIKit.framework
         Security.framework
         libz.dylib
     *  *直接把demo里面的PushConfig.plist文件拖到你的项目中区配置相应项
    *    "APS_FOR_PRODUCTION" = "0";   //是否是生产环境
         "CHANNEL" = "Publish channel";//固定不变
         "APP_KEY" = "AppKey copied from JPush Portal application";             //极光推送的关键key
     *
     *
     *
     *
     */


    [self registerPushOfJiGuang:launchOptions];
    
    return YES;
    
 
    
}
/**
 *  极光推送->注册
 */
- (void)registerPushOfJiGuang:(NSDictionary *)launchOptions
{
    
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
}
#pragma mark-提交DeviceToken注册通知
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
    //设置别名-->每个用户只能指定一个别名,如果一个别名对应多个用户那么推送的时候会推送多人，目的是根据别名找到唯一的一个用户
    //[APService setAlias:@"1" callbackSelector:nil object:nil];
  
    /**
     *  设置标签
     *  为了根据标签，来批量下发 Push 消息符合标签条件的局部群发
     *  可为每个用户打多个标签。
     *  一个 tag 最多 40个字符、tags 数量最多 100个
     *  不同应用程序、不同的用户，可以打同样的标签
     *  例如根据game, old_page,  women这几个标签给符合这个条件的人发送消息
     *  符合其中一条或者是全部符合的都会收到推送，最少满足一条
     */
    //[APService setTags:[NSSet setWithArray:@[@"girl",@"women",@"boy"]] callbackSelector:nil object:nil];
    /**
     *  设置标签和别名
     *
     *  @param Tags  标签
     *
     *  @param alias 别名
     */
    //[APService setTags:[NSSet setWithArray:@[@"girl",@"women",@"boy"]]  alias:@"1" callbackSelector:nil target:nil];
    /**
     *  RegistrationID
     *
     *  注册极光推送成功之后获取的我唯一标示可以用它来作为别名区分用户
     */
    
    //[APService setAlias:[APService registrationID] callbackSelector:nil object:nil];
    
    
    
    
    
    
    
}
#pragma mark-处理通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
    //收到通知
     NSLog(@"%@",userInfo[@"aps"]);

    
}
#pragma mark-ios7以上处理通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
 
    
    //应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
    if (application.applicationState == UIApplicationStateActive) {
        //前台
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到推送消息"
                                                        message:userInfo[@"aps"][@"alert"]
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        [alert show];
    }else if ([UIApplication sharedApplication].applicationState ==UIApplicationStateBackground){
       //后台
        NSLog(@"后台操作");
        
        
        
    }
    
  
    //设置极光推送服务器存储的每个用户的角标(当用户打开应用时可以把角标清零)
    //[APService setBadge:0];
    //本地仍须调用UIApplication:setApplicationIconBadgeNumber函数,来设置脚标
    //[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSLog(@"%@",userInfo[@"aps"]);
    
}
#pragma mark-程序被唤醒的时候角标清零
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [application setApplicationIconBadgeNumber:0];

}
#pragma mark-控制屏幕旋转
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    
      return UIInterfaceOrientationMaskPortrait;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
