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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 1.统一的较小间距 5 */
UIKIT_EXTERN CGFloat const STMarginSmall;

/** 2.统一的间距 10 */
UIKIT_EXTERN CGFloat const STMargin;

/** 3.统一的较大间距 16 */
UIKIT_EXTERN CGFloat const STMarginBig;

/** 4.导航栏的最大的Y值 64 */
UIKIT_EXTERN CGFloat const STNavigationBarY;

/** 5.控件的系统高度 44 */
UIKIT_EXTERN CGFloat const STControlSystemHeight;

/** 6.控件的普通高度 36 */
UIKIT_EXTERN CGFloat const STControlNormalHeight;


/**
 *  1.屏幕尺寸
 */
#define ScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

/**
 *  2.返回一个RGBA格式的UIColor对象
 */
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/**
 *  3.返回一个RGB格式的UIColor对象
 */
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

/**
 *  4.弱引用
 */
#define STWeakSelf __weak typeof(self) weakSelf = self;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, XLsn0wPickerButtonContentMode) {
    Bottom, // 1.选择器在视图的下方
    Center  // 2.选择器在视图的中间
};

@interface XLsn0wPickerButton : UIButton

/** 1.内部视图 */
@property (nonatomic, strong) UIView *contentView;
/** 2.边线,选择器和上方tool之间的边线 */
@property (nonatomic, strong)UIView *lineView;
/** 3.选择器 */
@property (nonatomic, strong)UIPickerView *pickerView;
/** 4.左边的按钮 */
@property (nonatomic, strong)UIButton *buttonLeft;
/** 5.右边的按钮 */
@property (nonatomic, strong)UIButton *buttonRight;
/** 6.标题label */
@property (nonatomic, strong)UILabel *labelTitle;
/** 7.下边线,在显示模式是STPickerContentModeCenter的时候显示 */
@property (nonatomic, strong)UIView *lineViewDown;

/** 1.标题，default is nil */
@property(nullable, nonatomic,copy) NSString          *title;
/** 2.字体，default is nil (system font 17 plain) */
@property(null_resettable, nonatomic,strong) UIFont   *font;
/** 3.字体颜色，default is nil (text draws black) */
@property(null_resettable, nonatomic,strong) UIColor  *titleColor;
/** 4.按钮边框颜色颜色，default is RGB(205, 205, 205) */
@property(null_resettable, nonatomic,strong) UIColor  *borderButtonColor;
/** 5.选择器的高度，default is 240 */
@property (nonatomic, assign)CGFloat heightPicker;
/** 6.视图的显示模式 */
@property (nonatomic, assign) XLsn0wPickerButtonContentMode contentMode;


/**
 *  5.创建视图,初始化视图时初始数据
 */
- (void)overrideInit;

/**
 *  6.确认按钮的点击事件
 */
- (void)selectedOk;

/**
 *  7.显示
 */
- (void)show;

/**
 *  8.移除
 */
- (void)remove;

@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@class XLsn0wPickerTimer;

@protocol XLsn0wPickerTimerDelegate <NSObject>

- (void)pickerTimer:(XLsn0wPickerTimer *)pickerTimer year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end

@interface XLsn0wPickerTimer : XLsn0wPickerButton

@property (nonatomic, weak) id<XLsn0wPickerTimerDelegate> xlsn0wDelegate;

/** 1.最小的年份，default is 1900 */
@property (nonatomic, assign) NSInteger yearLeast;
/** 2.显示年份数量，default is 200 */
@property (nonatomic, assign) NSInteger yearSum;
/** 3.中间选择框的高度，default is 28*/
@property (nonatomic, assign) CGFloat heightPickerComponent;

@end
NS_ASSUME_NONNULL_END

@interface NSCalendar (XLsn0wPickerTimerCalendar)

/**
 *  1.当前的日期数据元件模型
 *
 */
+ (NSDateComponents * _Nonnull)currentDateComponents;

/**
 *  2.当前年
 */
+ (NSInteger)currentYear;

/**
 *  3.当前月
 */
+ (NSInteger)currentMonth;

/**
 *  4.当前天
 */
+ (NSInteger)currentDay;

/**
 *  5.当前周数
 */
+ (NSInteger)currnentWeekday;

/**
 *  6.获取指定年月的天数
 */
+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month;

/**
 *  7.获取指定年月的第一天的周数
 */
+ (NSInteger)getFirstWeekdayWithYear:(NSInteger)year
                               month:(NSInteger)month;
/**
 *  8.比较两个日期元件
 */
+ (NSComparisonResult)compareWithComponentsOne:(NSDateComponents * _Nonnull)componentsOne
                                 componentsTwo:(NSDateComponents * _Nonnull)componentsTwo;

/**
 *  9.获取两个日期元件之间的日期元件
 */
+ (NSMutableArray * _Nonnull)arrayComponentsWithComponentsOne:(NSDateComponents * _Nonnull)componentsOne
                                       componentsTwo:(NSDateComponents * _Nonnull)componentsTwo;
/**
 *  10.字符串转日期元件 字符串格式为：yy-MM-dd
 */
+ (NSDateComponents * _Nonnull)dateComponentsWithString:(NSString * _Nonnull)String;

@end

@interface UIView (XLsn0wPickerTimerView)
/**
 *  1.间隔X值
 */
@property (nonatomic, assign) CGFloat x;

/**
 *  2.间隔Y值
 */
@property (nonatomic, assign) CGFloat y;

/**
 *  3.宽度
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  4.高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  5.中心点X值
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  6.中心点Y值
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  7.尺寸大小
 */
@property (nonatomic, assign) CGSize size;

/**
 *  8.起始点
 */
@property (nonatomic, assign) CGPoint origin;

/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;


/**
 *  1.添加边框
 */
- (void)addBorderColor:(UIColor * _Nonnull)color;

/**
 *  2.UIView 的点击事件
 *
 *  @param target   目标
 *  @param action   事件
 */

- (void)addTarget:(id _Nonnull)target
           action:(SEL _Nonnull)action;
@end
