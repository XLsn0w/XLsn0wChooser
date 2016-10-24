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

@class XLsn0wPickerSingler;

@protocol  XLsn0wPickerSinglerDelegate<NSObject>

- (void)pickerSingler:(XLsn0wPickerSingler *)pickerSingler selectedTitle:(NSString *)selectedTitle selectedRow:(NSInteger)selectedRow;

@end

@interface XLsn0wPickerSingler : UIButton

/** 2.工具器 */
@property (nonatomic, strong, nullable) XLsn0wToolbar *toolbar;

/** 1.设置字符串数据数组 */
@property (nonatomic, strong)NSMutableArray<NSString *> *arrayData;
/** 2.设置单位标题 */
@property (nonatomic, strong)NSString *unitTitle;
/** 3.标题 */
@property (nonatomic, strong)NSString *title;

@property(nonatomic, weak) id<XLsn0wPickerSinglerDelegate> xlsn0wDelegate;

- (instancetype)initWithArrayData:(NSArray<NSString *>*)arrayData
                        unitTitle:(NSString *)unitTitle
                   xlsn0wDelegate:(nullable id<XLsn0wPickerSinglerDelegate>)xlsn0wDelegate;

- (void)show;
@end
NS_ASSUME_NONNULL_END
