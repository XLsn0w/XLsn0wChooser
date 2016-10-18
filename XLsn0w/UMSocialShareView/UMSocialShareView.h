/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

#import <UIKit/UIKit.h>

#import "UMSocial.h"

@protocol UMSocialShareViewDelegate <NSObject>

- (void)handleUMSocialShareEventWithTag:(NSInteger)tag;

@end

@interface UMSocialShareView : UIView

@property (nonatomic, weak) id<UMSocialShareViewDelegate> xlsn0wDelegate;

+(instancetype)shareViewWithPresentedViewController:(UIViewController *)controller items:(NSArray *)items title:(NSString *)title image:(UIImage *)image urlResource:(NSString *)url;

@end

@interface UIView(Additions)

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;


+(id)getView;

- (UIViewController *)superviewcontroller;

#pragma mark - Border radius
/**
 *  @brief 设置圆角
 */
- (void)rounded:(CGFloat)cornerRadius;

/**
 *  @brief 设置圆角和边框
 */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**
 *  @brief 设置边框
 */
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor;


/** 更新约束 */
-(void)updateViewContraint:(NSLayoutAttribute)attribute value:(CGFloat)value;

@end

/*
 
 #pragma mark - UMSocial
 
 #import <UMSocial.h>
 #import "UMSocialQQHandler.h"
 #import "UMSocialWechatHandler.h"
 
 - (void)initUMSocial {
 [UMSocialData setAppKey:UMAppKey];
 [UMSocialWechatHandler setWXAppId:WeChatAppId appSecret:WeChatAppSecret url:@""];
 [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAppKey url:@""];
 }

 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
 BOOL result = [UMSocialSnsService handleOpenURL:url];
 if (result == FALSE) {
 //调用其他SDK，例如支付宝SDK等
 }
 return result;
 }

 //友盟提供的默认分享UI
 - (IBAction)shareAction:(id)sender {
 [UMSocialSnsService presentSnsIconSheetView:self
 appKey:@"570c660367e58e91600010a5"
 shareText:@"花花的简书"
 shareImage:[UIImage imageNamed:@"icon.png"]
 shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone, UMShareToSina, nil]
 delegate:self];
 }
 
 
 //自定义分享UI
 - (IBAction)customShareAction:(id)sender {
 UMSocialShareView *shareView = [UMSocialShareView shareViewWithPresentedViewController:self items:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone] title:@"欢迎进入花花的简书" image:[UIImage imageNamed:@"icon.png"] urlResource:nil];
 [[UIApplication sharedApplication].keyWindow addSubview:shareView];
 }
 
                 <UMSocialUIDelegate>
 
 //点击每个平台后默认会进入内容编辑页面，若想点击后直接分享内容，可以实现下面的回调方法
 //弹出列表方法presentSnsIconSheetView需要设置delegate为self  默认yes
 - (BOOL)isDirectShareInIconActionSheet {
 return YES;
 }
 
 //实现回调方法
 -(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
 //根据`responseCode`得到发送结果,如果分享成功
 if(response.responseCode == UMSResponseCodeSuccess) {
 NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);//得到分享到的微博平台名
 }
 }

 */
