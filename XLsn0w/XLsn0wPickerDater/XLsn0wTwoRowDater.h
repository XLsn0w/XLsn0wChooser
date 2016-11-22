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

#import "XLsn0wToolbar.h"

NS_ASSUME_NONNULL_BEGIN

@class XLsn0wTwoRowDater;

@protocol XLsn0wTwoRowDaterDelegate<NSObject>

- (void)twoRowDater:(XLsn0wTwoRowDater *)twoRowDater selectedResult:(NSString *)selectedResult;

@end

@interface XLsn0wTwoRowDater : UIButton

@property(nonatomic, weak) id<XLsn0wTwoRowDaterDelegate> xlsn0wDelegate;

/** 2.工具器 */
@property (nonatomic, strong, nullable) XLsn0wToolbar *toolbar;

@property (nonatomic, copy) NSString *selectedDay;
@property (nonatomic, copy) NSString *selectedTime;
@property (nonatomic, copy) NSString *selectedResult;

@property (nonatomic, strong) NSArray *timeIntervalArray;
@property (nonatomic, strong) NSArray *sevenDaysArray;

- (void)initTimeIntervalArray;
- (void)reInitTimeIntervalArray;
- (void)initSevenDaysArray;

- (instancetype)initWithXLsn0wDelegate:(nullable id<XLsn0wTwoRowDaterDelegate>)xlsn0wDelegate;

- (void)show;
@end
NS_ASSUME_NONNULL_END

@interface NSCalendar (ST)

/**
 *  1.当前的日期数据元件模型
 *
 *  @return <#return value description#>
 */
+ (nullable NSDateComponents *)currentDateComponents;

/**
 *  2.当前年
 *
 *  @return <#return value description#>
 */
+ (NSInteger)currentYear;

/**
 *  3.当前月
 *
 *  @return <#return value description#>
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
+ (nullable NSMutableArray *)arrayComponentsWithComponentsOne:(nullable NSDateComponents *)componentsOne
                                       componentsTwo:(nullable NSDateComponents *)componentsTwo;
/**
 *  10.字符串转日期元件 字符串格式为：yy-MM-dd
 */
+ (NSDateComponents * _Nonnull)dateComponentsWithString:(NSString * _Nonnull)String;

@end
