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
#import <Foundation/Foundation.h>

#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, KSAlertViewButtonType) {
    KSAlertViewButtonCommit = 0,
    KSAlertViewButtonDelete,
};

typedef void(^CommitAction)(UIButton* button);


@class KSAlertAppearance;

@interface XLsn0wAlertChooser : UIView

+ (KSAlertAppearance *)appearances;

/** 标题, 消息1,自动消失*/
+ (void)showWithTitle:(NSString*)title message1:(NSString*)message1 druation:(NSTimeInterval)druation;

/** 标题, 消息1,取消按钮*/
+ (void)showWithTitle:(NSString*)title message1:(NSString*)message1 cancelButton:(NSString*)cancelTitle;

/** 标题, 消息1,取消按钮,确定按钮*/
+ (void)showWithTitle:(NSString*)title message1:(NSString*)message1 cancelButton:(NSString*)cancelTitle customButton:(NSString*)commitTitle commitAction:(CommitAction)commitAction;

/** 标题, 消息1,取消按钮,确定按钮(给定默认按钮样式)*/
+ (void)showWithTitle:(NSString*)title message1:(NSString*)message1 cancelButton:(NSString*)cancelTitle commitType:(KSAlertViewButtonType)type commitAction:(CommitAction)commitAction;

@end


@interface UIButton (block)

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(CommitAction)action;

@end

/**************************************************************************************************/
#define KSColor(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]

typedef NS_ENUM(NSUInteger, KSAlertAnimationStyles) {
    KSAlertAnimationStyleDefault,
};

@interface KSAlertAppearance : NSObject

/** alertView*/
@property (nonatomic,strong) UIColor* KSAlertMaskViewColor;
@property (nonatomic,strong) UIColor* KSAlertViewColor;
@property (nonatomic, assign) UIEdgeInsets KSAlertViewPadding;
@property (nonatomic,assign) CGFloat KSAlertViewCornerRadius;

/** title*/
@property (nonatomic,strong) NSDictionary<NSString *, id> * KSAlertTitleAttributed;

/** message1*/
@property (nonatomic,assign) CGFloat KSAlertMessage1TopMargin;
@property (nonatomic,strong) NSDictionary<NSString *, id> * KSAlertMessage1Attributed;

/** cancelTitle*/
@property (nonatomic,assign) CGFloat KSAlertCancelTitleTopMargin;
@property (nonatomic,strong) NSDictionary<NSString *, id> * KSAlertCancelTitleAttributed;

/** customButton*/
@property (nonatomic,strong) NSDictionary<NSString *, id> * KSAlertCustomTitleAttributed;

///** commitButton*/
@property (nonatomic,strong) NSDictionary<NSString *, id> * KSAlertCommitTitleAttributed;
//
///** deleteButton*/
//@property (nonatomic,strong) NSDictionary<NSString *, id> * KSAlertDeleteTitleAttributed;


/** line*/
@property (nonatomic,strong) UIColor* horizontalLineColor;
@property (nonatomic,strong) UIColor* verticalLineColor;

/** Animation*/
@property (nonatomic, assign) KSAlertAnimationStyles KSAlertAnimationStyle;

@end

/****************************************
 
 - (IBAction)AlertChooser1:(id)sender {
 [XLsn0wAlertChooser showWithTitle:@"我是标题,我可以为空" message1:@"我是消息,我也可以为空" druation:1.];
 }
 
 - (IBAction)AlertChooser2:(id)sender {
 [XLsn0wAlertChooser showWithTitle:@"我是标题,我可以为空" message1:@"我是消息,我也可以为空" cancelButton:@"取消"];
 
 }
 
 - (IBAction)AlertChooser3:(id)sender {
 [XLsn0wAlertChooser showWithTitle:@"我是标题,我可以为空" message1:@"我是消息,我也可以为空" cancelButton:@"取消" commitType:KSAlertViewButtonDelete commitAction:^(UIButton *button) {
 NSLog(@"关闭");
 }];
 
 }
 
 - (IBAction)AlertChooser4:(id)sender {
 [XLsn0wAlertChooser showWithTitle:@"我是标题,我可以为空" message1:@"我是消息,我也可以为空" cancelButton:@"取消" customButton:@"自定义按钮" commitAction:^(UIButton *button) {
 NSLog(@"关闭");
 }];
 }
 
 **********************************************************/
