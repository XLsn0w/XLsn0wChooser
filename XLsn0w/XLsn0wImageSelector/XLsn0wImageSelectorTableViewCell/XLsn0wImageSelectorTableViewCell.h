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

@class XLsn0wImageSelectorTableViewCell;

@protocol XLsn0wImageSelectorTableViewCellDelegate <NSObject>

- (void)xlsn0wImageSelectorTableViewCell:(XLsn0wImageSelectorTableViewCell *)cell willDeleteAtIndexPath:(NSIndexPath*)indexPath;
- (void)xlsn0wImageSelectorTableViewCell:(XLsn0wImageSelectorTableViewCell *)cell didSelectAtIndexPath:(NSIndexPath*)indexPath;
- (void)xlsn0wImageSelectorTableViewCell:(XLsn0wImageSelectorTableViewCell *)cell shouldAddImageAtIndexPath:(NSIndexPath*)indexPath;

@end


@interface XLsn0wImageSelectorTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray* imageArray;

@property (nonatomic,weak) id<XLsn0wImageSelectorTableViewCellDelegate> xlsn0wDelegate;

@end
