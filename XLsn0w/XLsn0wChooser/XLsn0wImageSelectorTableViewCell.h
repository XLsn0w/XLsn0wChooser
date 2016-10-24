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

/***********************************************
 
 XLsn0wImageSelectorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XLsn0wImageSelectorTableViewCell"];
 cell.imageArray = self.dataSource[indexPath.row];
 cell.xlsn0wDelegate = self;
 return cell;
 
 
 #pragma mark - <XLsn0wImageSelectorTableViewCellDelegate>
 
 
 - (void)xlsn0wImageSelectorTableViewCell:(XLsn0wImageSelectorTableViewCell *)cell shouldAddImageAtIndexPath:(NSIndexPath *)indexPath{
 NSLog(@"删除图片:%@",indexPath);
 [self.dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
 }
 
 - (void)xlsn0wImageSelectorTableViewCell:(XLsn0wImageSelectorTableViewCell *)cell didSelectAtIndexPath:(NSIndexPath *)indexPath{
 NSLog(@"点击图片:%@",indexPath);
 }
 
 - (void)xlsn0wImageSelectorTableViewCell:(XLsn0wImageSelectorTableViewCell *)cell willDeleteAtIndexPath:(NSIndexPath *)indexPath{
 NSLog(@"添加图片:%@",indexPath);
 }

 ***************************************************/
