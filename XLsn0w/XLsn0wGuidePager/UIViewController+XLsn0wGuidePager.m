//
//  UIViewController+KSGuid.m
//  test
//
//  Created by kong on 16/7/21.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "UIViewController+XLsn0wGuidePager.h"
#import <objc/runtime.h>

#define CollectionView_Tag 15
#define RemoveBtn_tag 16
#define Control_tag 17

#define FIRST_IN_KEY @"FIRST_IN_KEY"

@interface KSGuidViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, strong) UIImageView* imageView;
@end
@implementation KSGuidViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_imageView];
    }
    return self;
}
- (void)setImageName:(NSString *)imageName{
    if (_imageName != imageName) {
        _imageName = [imageName copy];
    }
    _imageView.image = [UIImage imageNamed:imageName];
}
@end

/************************以上是KSGuidViewCell,以下才是UIViewController+KSGuid******************************/

@implementation UIViewController (XLsn0wGuidePager)

#pragma mark- 
#pragma mark 这里是退出的按钮
- (UIButton*)removeBtn{
    //移除按钮样式
    UIButton* removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeButton addTarget:self action:@selector(removeXLsn0wGuidePager:) forControlEvents:UIControlEventTouchUpInside];
    removeButton.hidden = (self.imageArray.count != 1);
    removeButton.tag = RemoveBtn_tag;      //注意这里的tag
    
    //***********************这里面可以自定义*******************************//
    CGFloat btnW = 128;
    CGFloat btnH = 35;
    CGFloat btnX = CGRectGetMidX(self.view.frame) - btnW / 2;
    CGFloat btnY = CGRectGetMaxY(self.view.frame) * 0.83;
    removeButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    removeButton.layer.cornerRadius = 4;
    removeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    removeButton.layer.borderWidth = 1.;
    
    [removeButton setTitle:@"进入主页" forState:UIControlStateNormal];
    [removeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    removeButton.titleLabel.font = [UIFont systemFontOfSize:18.];
     //********************自定义结束**********************************//
   
    return removeButton;
}

#pragma mark-
#pragma mark 这里填充图片的名称
- (NSArray<NSString*>*)imageArray {
    return ImageArray;
}

/*
 * 默认关闭引导页 如需开启 在子类里面重写词方法 return YES;即可显示
 */
- (BOOL)isShowXLsn0wGuidePager {
    return NO;
}

+ (void)load{
    
    NSString* versoin = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString* versionCache = [[NSUserDefaults standardUserDefaults] objectForKey:FIRST_IN_KEY];
    //启动时候首先判断是不是第一次
    
    if ([versoin isEqualToString:versionCache]) {
        return;
    }
    
    
    
    //以下代码只在程序安装初次运行时候执行
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method1 = class_getInstanceMethod(self.class, @selector(viewDidLoad));
        Method method2 = class_getInstanceMethod(self.class, @selector(guidViewDidLoad));
        
        BOOL didAddMethod =
        class_addMethod(self.class,
                        @selector(viewDidLoad),
                        method_getImplementation(method2),
                        method_getTypeEncoding(method2));
        
        if (didAddMethod) {
            class_replaceMethod(self.class,
                                @selector(guidViewDidLoad),
                                method_getImplementation(method1),
                                method_getTypeEncoding(method1));
        } else {
            method_exchangeImplementations(method1, method2);
        }
    });
}

- (void)guidViewDidLoad{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //这里的代码只在程序安装初次打开，并且在第一个控制器里面执行
        //判断是否显示, 初始化视图
        if ([self isShowXLsn0wGuidePager] == YES) {
            [self setupSubViews];
        }
        
    });

    //这是调用工程里面的viewDidLoad
    [self guidViewDidLoad];
}

#pragma mark- 
#pragma mark 初始化视图

- (void)setupSubViews{
    
    //界面样式
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    UICollectionView* collectionView = [[UICollectionView alloc]
                      initWithFrame:self.view.bounds
                      collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[KSGuidViewCell class] forCellWithReuseIdentifier:@"KSGuidViewCell"];
    
    collectionView.tag = CollectionView_Tag;
    [self.view addSubview:collectionView];
    
    [self.view addSubview:self.removeBtn];
    
    UIPageControl * control = [[UIPageControl  alloc] init];
    
    CGFloat controlW = 170;
    CGFloat controlH = 20;
    CGFloat controlX = CGRectGetMidX(self.view.frame) - controlW / 2;
    CGFloat controlY = CGRectGetMaxY(self.view.frame) - 38;
    control.frame = CGRectMake(controlX, controlY, controlW, controlH);
    
    control.pageIndicatorTintColor = pageTintColor;
    control.currentPageIndicatorTintColor = currentTintColor;
    
    control.tag = Control_tag;
    [self.view addSubview:control];
}

#pragma mark-
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

#define randomColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KSGuidViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KSGuidViewCell" forIndexPath:indexPath];
    cell.imageName = self.imageArray[indexPath.row];

    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSUInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
    [self.view viewWithTag:RemoveBtn_tag].hidden = (index != self.imageArray.count - 1);
    
    UIPageControl *pageControl =[self.view viewWithTag:Control_tag];
    pageControl.currentPage = index;
    pageControl.numberOfPages = ImageArray.count;
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
}

- (void)removeXLsn0wGuidePager:(UIButton *)removeButton {
    
    NSString* versoin = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    [[NSUserDefaults standardUserDefaults] setObject:versoin forKey:FIRST_IN_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[self.view viewWithTag:Control_tag] removeFromSuperview];
    [[self.view viewWithTag:RemoveBtn_tag] removeFromSuperview];
    [[self.view viewWithTag:CollectionView_Tag] removeFromSuperview];
}


@end


