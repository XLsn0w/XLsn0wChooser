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

#import "XLsn0wImageSelectorTableViewCell.h"

#import "XLsn0wImageSelector.h"

@interface XLsn0wImageSelectorTableViewCell ()<XLsn0wImageSelectorDelegate>

@property (nonatomic, strong) XLsn0wImageSelector *xlsn0wImageSelector;

@end

@implementation XLsn0wImageSelectorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.xlsn0wImageSelector = [[XLsn0wImageSelector alloc] init];
        self.xlsn0wImageSelector.xlsn0wDelegate = self;
        self.xlsn0wImageSelector.maxCount = 100;
        self.xlsn0wImageSelector.editing = YES;
        self.xlsn0wImageSelector.orientation = KSImageCollectionOrientationBack;
        [self.contentView addSubview:self.xlsn0wImageSelector];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.xlsn0wImageSelector.frame = self.contentView.bounds;
}

- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    [self.xlsn0wImageSelector setImageArray:imageArray];
}

#pragma mark-
#pragma mark- KSImageCollectionDelegate
- (void)imageSelector:(XLsn0wImageSelector *)imageSelector shouldAddImageAtIndex:(NSUInteger)index{
    //添加图片
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:self.indexPath.row];
    
    if (self.xlsn0wDelegate && [self.xlsn0wDelegate respondsToSelector:@selector(xlsn0wImageSelectorTableViewCell:shouldAddImageAtIndexPath:)]) {
        [self.xlsn0wDelegate xlsn0wImageSelectorTableViewCell:self shouldAddImageAtIndexPath:indexPath];
    }
}
- (void)imageSelector:(XLsn0wImageSelector *)imageSelector didSelectImage:(id)imageObj atIndex:(NSUInteger)index{
    //点击图片
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:self.indexPath.row];

    if (self.xlsn0wDelegate && [self.xlsn0wDelegate respondsToSelector:@selector(xlsn0wImageSelectorTableViewCell:didSelectAtIndexPath:)]) {
        [self.xlsn0wDelegate xlsn0wImageSelectorTableViewCell:self didSelectAtIndexPath:indexPath];
    }
}
- (void)imageSelector:(XLsn0wImageSelector *)imageSelector willDeleteImage:(id)imageObj atIndex:(NSUInteger)index{
    //删除图片
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:self.indexPath.row];

    if (self.xlsn0wDelegate && [self.xlsn0wDelegate respondsToSelector:@selector(xlsn0wImageSelectorTableViewCell:willDeleteAtIndexPath:)]) {
        [self.xlsn0wDelegate xlsn0wImageSelectorTableViewCell:self willDeleteAtIndexPath:indexPath];
    }
}

- (NSIndexPath*)indexPath{
    UIView* superView = self.superview;
    Class class = [UITableView class];
    while (![superView isKindOfClass:class]) {
        superView = superView.superview;
    }

    return [((UITableView*)superView) indexPathForCell:self];
}

@end
