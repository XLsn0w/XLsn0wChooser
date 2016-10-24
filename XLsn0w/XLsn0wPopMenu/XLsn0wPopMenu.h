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

@protocol XLsn0wPopMenuDelegate;

@interface XLsn0wPopMenu : UIView

@property (nonatomic, assign) id<XLsn0wPopMenuDelegate> xlsn0wDelegate;

+ (instancetype)popMenuShowWithArray:(NSArray *)showArray; //显示弹出菜单
+ (void)popMenuDismiss;//隐藏弹出菜单

@end

@protocol XLsn0wPopMenuDelegate <NSObject>

@required
- (void)popMenu:(XLsn0wPopMenu *)menu didSelectItem:(id)item selectedIndex:(NSInteger)selectedIndex;

@end

@interface PopMenuCell : UITableViewCell

@property (nonatomic, strong) UILabel *infoLabel;

@end
