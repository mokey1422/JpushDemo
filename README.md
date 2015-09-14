# JpushDemo
##极光推送说明包括后台的配置和单推等<br>
##简单的把极光推送的文档大体又看了一遍并做了一些系统的整理目前还有一部分功能还没有收入其中，比如说自定义消息体，实时处理通知栏信息<br>
##但是就基本的推送包括群推和分组推和单推的方法里面已经写的很详细了，可以直接复制我的代码到你的工程里并按文档里面的配置去做应该没有什么问题<br>
#这就是一个简单的教程篇，没有什么技术含量,附带部分代码<br>
```
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

```
