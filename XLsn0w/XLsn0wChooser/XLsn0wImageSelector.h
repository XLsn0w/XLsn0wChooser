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

@class XLsn0wImageSelector;

typedef enum : NSUInteger {
    KSImageCollectionOrientationBack = 0,
    KSImageCollectionOrientationForward,
} KSImageCollectionOrientation;

@protocol XLsn0wImageSelectorDelegate <NSObject>

@optional
- (void)imageSelector:(XLsn0wImageSelector *)imageSelector willDeleteImage:(id)imageObj atIndex:(NSUInteger)index;
- (void)imageSelector:(XLsn0wImageSelector *)imageSelector didSelectImage:(id)imageObj atIndex:(NSUInteger)index;
- (void)imageSelector:(XLsn0wImageSelector *)imageSelector shouldAddImageAtIndex:(NSUInteger)index;

@end

@interface XLsn0wImageSelector : UICollectionView

/** 支持UIImage,NSString类型 */
@property (nonatomic,strong,readonly) NSMutableArray* images;

/** 是否可编辑 删除、添加图片 默认NO */
@property (nonatomic,assign) IBInspectable BOOL editing;
/** 是否在非编辑情况下并且在没有图片显示未添加按钮 默认NO*/
@property (nonatomic,assign) IBInspectable BOOL showNone;

/** 最大图片张数 */
@property (nonatomic,assign) IBInspectable NSUInteger maxCount;
/** 添加图片按钮的位置 默认KSImageCollectionOrientationBack*/
@property (nonatomic,assign) KSImageCollectionOrientation orientation;

/** 代理对象*/
@property (nonatomic,weak) id<XLsn0wImageSelectorDelegate> xlsn0wDelegate;

/** 初始化一个图片数组，类型可以为自定义类型，需要指定Image的属性*/
- (void)setImageModelArray:(NSArray*)array property:(NSString*)property;
/** 初始化一个图片，类型可以为UImage,NSString*/
- (void)setImage:(id)image;
/** 初始化一个图片数组，类型可以为UImage,NSString*/
- (void)setImageArray:(NSArray *)array;

/** 添加一个图片数组，类型可以为自定义类型，需要指定Image的属性*/
- (void)addImageModelArray:(NSArray*)array property:(NSString*)property;
/** 添加一个图片，类型可以为UImage,NSString*/
- (void)addImage:(id)image;
/** 添加一个图片数组，类型可以为UImage,NSString*/
- (void)addImageArray:(NSArray *)array;

/** 指定位置插入一个图片数组，类型可以为自定义类型，需要指定Image的属性*/
- (void)insertImageModelArray:(NSArray*)array property:(NSString*)property atIndex:(NSUInteger)index;
/** 指定位置插入一个图片，类型可以为UImage,NSString*/
- (void)insertImage:(id)image atIndex:(NSUInteger)index;
/** 指定位置插入一个图片数组，类型可以为UImage,NSString*/
- (void)insertImageArray:(NSArray *)array atIndex:(NSUInteger)index;

/** 删除所有图片*/
- (void)removeAllImages;

@end

@class XLsn0wImageSelectorCollectionViewCell;

@protocol XLsn0wImageSelectorCollectionViewCellDelegate <NSObject>

- (void)xlsn0wImageSelectorCollectionViewCell:(XLsn0wImageSelectorCollectionViewCell *)cell didClickRemoveObject:(id)object atIndex:(NSUInteger)index;

@end
@interface XLsn0wImageSelectorCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) id imageObject;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic,assign) BOOL editing;

@property (nonatomic,weak) id<XLsn0wImageSelectorCollectionViewCellDelegate> xlsn0wDelegate;

@end

@protocol KSImageCollectionFooterHeaderDelegate <NSObject>

- (void)ks_imageCollectionFooterHeaderDidClick;

@end

@interface KSImageCollectionFooterHeader : UICollectionReusableView

@property (nonatomic,weak) id<KSImageCollectionFooterHeaderDelegate> delegate;

@end
