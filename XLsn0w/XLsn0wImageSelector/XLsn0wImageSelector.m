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

#import "XLsn0wImageSelector.h"

#define ITEM_SIZE (CGSizeMake(self.bounds.size.height - .5,self.bounds.size.height - .5))

#pragma mark-
#pragma mark KSImageCollection

@interface XLsn0wImageSelector () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,XLsn0wImageSelectorCollectionViewCellDelegate, KSImageCollectionFooterHeaderDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout* layout;
@end

@implementation XLsn0wImageSelector

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero collectionViewLayout:self.layout];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:self.layout];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.collectionViewLayout = self.layout;
    [self setupSubviews];
}

- (UICollectionViewFlowLayout*)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 5;
        _layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    }
    return _layout;
}

- (void)setupSubviews{
    
    _images = [[NSMutableArray alloc] init];
    
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    [self registerClass:[XLsn0wImageSelectorCollectionViewCell class] forCellWithReuseIdentifier:@"XLsn0wImageSelectorCollectionViewCell"];
    [self registerClass:[KSImageCollectionFooterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooter];
    [self registerClass:[KSImageCollectionFooterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeader];
}

#pragma mark- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ((!_editing) && _showNone) {
        return MAX(self.images.count, 1);   //非编辑并且显示无图片
    }
    return self.images.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XLsn0wImageSelectorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLsn0wImageSelectorCollectionViewCell" forIndexPath:indexPath];
    cell.xlsn0wDelegate = self;
    if ((!_editing) && _showNone && _images.count == 0) {
        cell.imageObject = [UIImage imageNamed:@"KSImageCollection.bundle/KSImageCollectNone"];
    }else{
        cell.imageObject = _images[indexPath.row];
    }
    cell.editing = _editing;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (_images.count >= _maxCount || (!_editing)) {
        return nil;
    }
    
    KSImageCollectionFooterHeader* footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kind forIndexPath:indexPath];
    footer.delegate = self;
    return footer;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return ITEM_SIZE;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (_images.count >= _maxCount || (!_editing) || _orientation == KSImageCollectionOrientationBack) {
        return CGSizeZero;
    }
    return ITEM_SIZE;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (_images.count >= _maxCount || (!_editing) || _orientation == KSImageCollectionOrientationForward) {
        return CGSizeZero;
    }
    return ITEM_SIZE;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((!_editing) && _showNone && _images.count == 0) {
        return; //点击未添加图片
    }
    
    id imageObj = _images[indexPath.row];
    
    if (self.xlsn0wDelegate && [self.xlsn0wDelegate respondsToSelector:@selector(imageSelector:didSelectImage:atIndex:)]) {
        [self.xlsn0wDelegate imageSelector:self didSelectImage:imageObj atIndex:indexPath.row];
    }
}

- (void)ks_imageCollectionFooterHeaderDidClick{
    if (self.xlsn0wDelegate && [self.xlsn0wDelegate respondsToSelector:@selector(imageSelector:shouldAddImageAtIndex:)]) {
        [self.xlsn0wDelegate imageSelector:self shouldAddImageAtIndex:self.images.count - 1];
    }
}

- (void)xlsn0wImageSelectorCollectionViewCell:(XLsn0wImageSelectorCollectionViewCell *)cell didClickRemoveObject:(id)object atIndex:(NSUInteger)index{
    
    id imageObj = self.images[index];
    
    if (self.xlsn0wDelegate && [self.xlsn0wDelegate respondsToSelector:@selector(imageSelector:willDeleteImage:atIndex:)]) {
        [self.xlsn0wDelegate imageSelector:self willDeleteImage:imageObj atIndex:index];
    }
    
    [self.images removeObjectAtIndex:index];
    [self reloadData];
}


- (void)setImageArray:(NSArray *)array{
    [self.images removeAllObjects];
    [self addImageArray:array];
}
- (void)setImage:(id)image{
    [self.images removeAllObjects];
    [self addImageArray:@[image]];
}
- (void)setImageModelArray:(NSArray *)array property:(NSString *)property{
    [self.images removeAllObjects];
    [self addImageModelArray:array property:property];
}

- (void)addImage:(id)image{
    [self.images addObject:image];
    [self reloadData];
}
- (void)addImageArray:(NSArray *)array{
    [self.images addObjectsFromArray:array];
    [self reloadData];
}
- (void)addImageModelArray:(NSArray *)array property:(NSString *)property{
    [self addImageArray:[array valueForKeyPath:property]];
}

- (void)insertImage:(id)image atIndex:(NSUInteger)index{
    [self.images insertObject:image atIndex:index];

    [self reloadData];
}
- (void)insertImageArray:(NSArray *)array atIndex:(NSUInteger)index{
    [self.images insertObjects:array atIndexes:[NSIndexSet indexSetWithIndex:index]];
    [self reloadData];
}
- (void)insertImageModelArray:(NSArray *)array property:(NSString *)property atIndex:(NSUInteger)index{
    [self.images insertObjects:[array valueForKeyPath:property] atIndexes:[NSIndexSet indexSetWithIndex:index]];
    [self reloadData];
}

- (void)removeAllImages{
    [self.images removeAllObjects];
    
    [self reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

#import "UIImageView+WebCache.h"

@implementation XLsn0wImageSelectorCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectInset(self.bounds, 5, 5);
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100;
        btn.frame = CGRectMake(self.bounds.size.width - 15, 0, 15, 15);
        [btn setBackgroundImage:[UIImage imageNamed:@"KSImageCollection.bundle/KSImageCollectRemove"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(removeImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    return self;
}

- (void)setImageObject:(id)imageObject{
    if (_imageObject != imageObject) {
        _imageObject = imageObject;
        
        if ([_imageObject isKindOfClass:[NSString class]]) {
            
            [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageObject] placeholderImage:[UIImage imageNamed:@"icon_default"]];
            
        }else if ([imageObject isKindOfClass:[UIImage class]]){
            
            _imageView.image = _imageObject;
            
        }else{
            _imageView.image = nil;
        }
    }
}

- (void)setEditing:(BOOL)editing{
    _editing = editing;
    [self.contentView viewWithTag:100].hidden = !editing;
}


- (void)removeImage:(UIButton*)sender{
    
    if (self.xlsn0wDelegate && [self.xlsn0wDelegate respondsToSelector:@selector(xlsn0wImageSelectorCollectionViewCell:didClickRemoveObject:atIndex:)]) {
        [self.xlsn0wDelegate xlsn0wImageSelectorCollectionViewCell:self didClickRemoveObject:_imageObject atIndex:self.indexPath.row];
    }
}

- (NSIndexPath*)indexPath{
    UIView* next = self.superview;
    while (![next isKindOfClass:[UICollectionView class]]) {
        next = next.superview;
    }
    UICollectionView* collectionView = (UICollectionView*)next;
    return [collectionView indexPathForCell:self];
}

@end

@implementation KSImageCollectionFooterHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectInset(self.bounds, 5, 5);
        [btn setBackgroundImage:[UIImage imageNamed:@"KSImageCollection.bundle/KSImageCollectAdd"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)selectImage:(UIButton*)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(ks_imageCollectionFooterHeaderDidClick)]) {
        [_delegate ks_imageCollectionFooterHeaderDidClick];
    }
}

@end
