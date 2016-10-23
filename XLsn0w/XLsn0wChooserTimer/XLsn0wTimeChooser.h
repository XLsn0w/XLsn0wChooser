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

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreen_Width/320))

@class MXSCycleScrollView;

@protocol MXSCycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(MXSCycleScrollView *)csView atIndex:(NSInteger)index;
- (void)scrollviewDidChangeNumber;

@end

@protocol MXSCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages:(MXSCycleScrollView*)scrollView;
- (UIView *)pageAtIndex:(NSInteger)index andScrollView:(MXSCycleScrollView*)scrollView;

@end

@interface MXSCycleScrollView : UIView <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic, weak, setter = setDataource:) id<MXSCycleScrollViewDatasource> datasource;
@property (nonatomic, weak, setter = setDelegate:)  id<MXSCycleScrollViewDelegate> delegate;

- (void)setCurrentSelectPage:(NSInteger)selectPage; //设置初始化页数
- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

@end

/**************************************************************************************************/

typedef enum {
    DatePickerDateMode,
    DatePickerTimeMode,
    DatePickerDateTimeMode,
    DatePickerYearMonthMode,
    DatePickerMonthDayMode,
    DatePickerHourMinuteMode,
    DatePickerDateHourMinuteMode
} DatePickerMode;

typedef void(^DatePickerCompleteAnimationBlock)(BOOL Complete);
typedef void(^ClickedOkBtn)(NSString *dateTimeStr);

@interface XLsn0wTimeChooser : UIView <MXSCycleScrollViewDatasource, MXSCycleScrollViewDelegate>

@property (nonatomic,strong) ClickedOkBtn clickedOkBtn;

@property (nonatomic,assign) DatePickerMode datePickerMode;

@property (nonatomic,assign) NSInteger maxYear;
@property (nonatomic,assign) NSInteger minYear;

- (instancetype)initWithDefaultDatetime:(NSDate*)dateTime;
- (instancetype)initWithDatePickerMode:(DatePickerMode)datePickerMode defaultDateTime:(NSDate*)dateTime;

- (void)showInSuperview:(UIView *)superview;

@end

@interface UIColor (XLsn0wChooserTimer)

@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) BOOL canProvideRGBComponents;
@property (nonatomic, readonly) CGFloat red; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) UInt32 rgbHex;

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;
@end

/***************************************
 
 - (IBAction)XLsn0wChooserTimer:(id)sender {
 XLsn0wTimeChooser *timeChooser = [[XLsn0wTimeChooser alloc] initWithDatePickerMode:(DatePickerDateMode) defaultDateTime:[NSDate date]];
 [timeChooser showInSuperview:self.view];
 
 timeChooser.clickedOkBtn = ^(NSString * datetimeStr){
 NSLog(@"%@", datetimeStr);
 };
 }
 
 ***********************************************************/
