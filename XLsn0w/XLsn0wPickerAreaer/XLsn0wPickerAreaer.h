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

@class XLsn0wPickerAreaer;

@protocol  XLsn0wPickerAreaerDelegate<NSObject>

- (void)pickerAreaer:(XLsn0wPickerAreaer *)pickerAreaer province:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end
@interface XLsn0wPickerAreaer : UIButton

@property(nonatomic, weak) id<XLsn0wPickerAreaerDelegate> delegate ;

- (instancetype)initWithDelegate:(nullable id<XLsn0wPickerAreaerDelegate>)delegate;

@property (nonatomic, strong, nullable) XLsn0wToolbar *toolbar;

- (void)show;
@end
NS_ASSUME_NONNULL_END
