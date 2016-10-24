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

struct KSPopAnimationValue {
    NSTimeInterval duration;
    NSTimeInterval delay;
    CGFloat damping;
    CGFloat velocity;
    UIViewAnimationOptions options;
};
typedef struct KSPopAnimationValue KSPopAnimationValue;

CG_INLINE KSPopAnimationValue
KSPopAnimationValueMake(NSTimeInterval duration,
                        NSTimeInterval delay,
                        CGFloat damping,
                        CGFloat velocity,
                        UIViewAnimationOptions options)
{
    KSPopAnimationValue value;
    value.duration = duration;
    value.delay = delay;
    value.damping = damping;
    value.velocity = velocity;
    value.options = options;
    return value;
}

/** KSPopAnimationDefalult 无阻尼动画*/
CG_INLINE KSPopAnimationValue
KSPopAnimationDefalult()
{
    KSPopAnimationValue value;
    value.duration = 0.25;
    value.delay = 0;
    value.damping = 1;
    value.velocity = 0;
    value.options = UIViewAnimationOptionCurveEaseInOut;
    return value;
}

@class XLsn0wMenuChooser;

@protocol XLsn0wMenuChooserDelegate <NSObject>

@optional
- (void)popMenu:(XLsn0wMenuChooser *)menu willShowContentView:(UIView*)contentView;
- (void)popMenu:(XLsn0wMenuChooser *)menu didShowContentView:(UIView*)contentView;

- (void)popMenu:(XLsn0wMenuChooser *)menu willHiddenContentView:(UIView*)contentView;
- (void)popMenu:(XLsn0wMenuChooser *)menu didHiddenContentView:(UIView*)contentView;

@end

@protocol XLsn0wMenuChooserDataSource <NSObject>

@required
/**  指定动画类型，比如缩放，下拉, 旋转等,默认下拉（比较难看）*/
- (CGAffineTransform)popContentView:(UIView *)contentView valueForContentTransformWithDefault:(CGAffineTransform)value;

/**  指定锚点，如果要做比较好看的动画，需要指定此点,默认为(0.5,0.5)*/
- (CGPoint)popContentView:(UIView *)contentView valueForContentAnchorPointWithDefault:(CGPoint)value;

/**  指定contentView显示的位置 默认为初始化的位置*/
- (CGPoint)popContentView:(UIView *)contentView valueForContentOriginDefault:(CGPoint)value;

@optional
/**  指定动画一些属性 默认KSPopAnimationDefalult()无阻尼动画*/
- (KSPopAnimationValue)popContentView:(UIView *)contentView valueForDefaultValue:(KSPopAnimationValue)value;

/**  指定maskView的颜色*/
- (UIColor*)popMaskView:(UIView *)contentView valueForColorDefault:(UIColor*)color;

/**  点击背景是否消失 默认yes*/
- (BOOL)popMenuShouldDismissWhenSelectMaskView;

@end

@interface XLsn0wMenuChooser : UIView
/**
 *  显示弹出的view 需要指定size origin可以在代理中指定
 *
 *  @param contentView 要弹出的view
 *  @param delegate    代理
 */
+ (void)showContentView:(UIView*)contentView delegate:(id<XLsn0wMenuChooserDelegate, XLsn0wMenuChooserDataSource>)delegate;

/** 在必要的时候调用这个方法移除弹出的view */
+ (void)hiddenFromSubview;

@end
