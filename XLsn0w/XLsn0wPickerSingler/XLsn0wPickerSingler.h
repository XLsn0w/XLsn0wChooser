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

- (void)pickerSingler:(XLsn0wPickerSingler *)pickerSingler selectedTitle:(NSString *)selectedTitle;

@end

@interface XLsn0wPickerSingler : UIButton

/** 2.工具器 */
@property (nonatomic, strong, nullable) XLsn0wToolbar *toolbar;

/** 1.设置字符串数据数组 */
@property (nonatomic, strong)NSMutableArray<NSString *> *arrayData;
/** 2.设置单位标题 */
@property (nonatomic, strong)NSString *titleUnit;
/** 3.标题 */
@property (nonatomic, strong)NSString *title;

@property(nonatomic, weak)id <XLsn0wPickerSinglerDelegate> delegate;

- (instancetype)initWithArrayData:(NSArray<NSString *>*)arrayData
                        titleUnit:(NSString *)titleUnit
                         delegate:(nullable id)delegate;

- (void)show;
@end
NS_ASSUME_NONNULL_END
