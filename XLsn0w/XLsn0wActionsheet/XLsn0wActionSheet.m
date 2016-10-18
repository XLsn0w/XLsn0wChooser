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

#import "XLsn0wActionSheet.h"

#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1]
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define ANIMATE_DURATION                        0.25f

#define ActionSheetW [[UIScreen mainScreen] bounds].size.width
#define ActionSheetH [[UIScreen mainScreen] bounds].size.height

@interface XLsn0wActionSheet ()
@property (nonatomic,assign) CGFloat LXActionSheetHeight;
@property (nonatomic,strong) NSArray *shareBtnTitleArray;
@property (nonatomic,strong) NSArray *shareBtnImgArray;

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) UIView *topsheetView;
@property (nonatomic,strong) UIButton *cancelBtn;

//头部提示文字Label
@property (nonatomic,strong) UILabel *proL;

@property (nonatomic,copy) NSString *protext;

@property (nonatomic,assign) ShowType showtype;

@end

@implementation XLsn0wActionSheet

- (id)initWithShareHeadOprationWith:(NSArray *)titleArray andImageArry:(NSArray *)imageArr andProTitle:(NSString *)protitle and:(ShowType)type
{
    self = [super init];
    if (self) {
        self.shareBtnImgArray = imageArr;
        self.shareBtnTitleArray = titleArray;
        _protext = protitle;
        _showtype = type;
        
        self.frame = CGRectMake(0, 0, ActionSheetW, ActionSheetH);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (type == ShowTypeIsShareStyle) {
            [self loadUiConfig];
        }
        else
        {
            [self loadActionSheetUi];
        }
        
    }
    return self;
}

- (void)setCancelBtnColor:(UIColor *)cancelBtnColor
{
    [_cancelBtn setTitleColor:cancelBtnColor forState:UIControlStateNormal];
}
- (void)setProStr:(NSString *)proStr
{
    _proL.text = proStr;
}

- (void)setOtherBtnColor:(UIColor *)otherBtnColor
{
    for (id res in _backGroundView.subviews) {
        if ([res isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)res;
            if (button.tag>=100) {
                [button setTitleColor:otherBtnColor forState:UIControlStateNormal];
            }
        }
    }
}

- (void)setOtherBtnFont:(NSInteger)otherBtnFont
{
    for (id res in _backGroundView.subviews) {
        if ([res isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)res;
            if (button.tag>=100) {
                button.titleLabel.font = [UIFont systemFontOfSize:otherBtnFont];
            }
        }
    }
}

-(void)setProFont:(NSInteger)proFont
{
    _proL.font = [UIFont systemFontOfSize:proFont];
}

- (void)setCancelBtnFont:(NSInteger)cancelBtnFont
{
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:cancelBtnFont];
}

- (void)setDuration:(CGFloat)duration
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:duration];
}

- (void)loadActionSheetUi
{
    [self addSubview:self.backGroundView];
    [_backGroundView addSubview:self.cancelBtn];
    if (_protext.length) {
        [_backGroundView addSubview:self.proL];
    }
    
    for (NSInteger i = 0; i<_shareBtnTitleArray.count; i++) {
        VerButton *button = [VerButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, CGRectGetHeight(_proL.frame)+50*i, CGRectGetWidth(_backGroundView.frame), 50);
        [button setTitle:_shareBtnTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.tag = 100+i;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:button];
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        _backGroundView.frame = CGRectMake(0, ActionSheetH-(_shareBtnTitleArray.count*50+50)-7-(_protext.length==0?0:45), ActionSheetW, _shareBtnTitleArray.count*50+50+7+(_protext.length==0?0:45));
    }];
    
}


- (void)loadUiConfig
{
    [self addSubview:self.backGroundView];
    [_backGroundView addSubview:self.topsheetView];
    [_backGroundView addSubview:self.cancelBtn];
    
    _LXActionSheetHeight = CGRectGetHeight(_proL.frame)+7;
    
    for (NSInteger i = 0; i<_shareBtnImgArray.count; i++)
    {
        ActionButton *button = [ActionButton buttonWithType:UIButtonTypeCustom];
        if (_shareBtnImgArray.count%3 == 0) {
            button.frame = CGRectMake(_backGroundView.bounds.size.width/3*(i%3), _LXActionSheetHeight+(i/3)*76, _backGroundView.bounds.size.width/3, 70);
        }
        else
        {
            button.frame = CGRectMake(_backGroundView.bounds.size.width/4*(i%4), _LXActionSheetHeight+(i/4)*76, _backGroundView.bounds.size.width/4, 70);
        }
        
        [button setTitle:_shareBtnTitleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_shareBtnImgArray[i]] forState:UIControlStateNormal];
        button.tag = 200+i;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topsheetView addSubview:button];
    }
    
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        _backGroundView.frame = CGRectMake(7, ActionSheetH-CGRectGetHeight(_backGroundView.frame), ActionSheetW-14, CGRectGetHeight(_backGroundView.frame));
    }];
    
}

- (void)BtnClick:(UIButton *)btn
{
    [self tappedCancel];
    if (btn.tag<200) {
        _btnClick(btn.tag-100);
    }
    else
    {
        _btnClick(btn.tag-200);
    }
}

- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, ActionSheetH, ActionSheetW, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)noTap
{}

#pragma mark -------- getter
- (UIView *)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        
        if (_showtype == ShowTypeIsShareStyle) {
            if (_shareBtnImgArray.count<5) {
                _backGroundView.frame = CGRectMake(7, ActionSheetH, ActionSheetW-14, 64+(_protext.length==0?0:45)+76+14);
            }else
            {
                NSInteger index;
                if (_shareBtnTitleArray.count%4 ==0) {
                    index =_shareBtnTitleArray.count/4;
                }
                else
                {
                    index = _shareBtnTitleArray.count/4 + 1;
                }
                _backGroundView.frame = CGRectMake(7, ActionSheetH, ActionSheetW-14, 64+(_protext.length==0?0:45)+76*index+14);
            }
        }
        else
        {
            _backGroundView.frame = CGRectMake(0, ActionSheetH, ActionSheetW, _shareBtnTitleArray.count*50+50+7+(_protext.length==0?0:45));
            _backGroundView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        }
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noTap)];
        [_backGroundView addGestureRecognizer:tapGesture];
    }
    return _backGroundView;
}


- (UIView *)topsheetView
{
    if (_topsheetView == nil) {
        _topsheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_backGroundView.frame), CGRectGetHeight(_backGroundView.frame)-64)];
        _topsheetView.backgroundColor = [UIColor whiteColor];
        _topsheetView.layer.cornerRadius = 4;
        _topsheetView.clipsToBounds = YES;
        if (_protext.length) {
            [_topsheetView addSubview:self.proL];
        }
    }
    return _topsheetView;
}

- (UILabel *)proL
{
    if (_proL == nil) {
        _proL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_backGroundView.frame), 45)];
        _proL.text = @"分享至";
        _proL.textColor = [UIColor grayColor];
        _proL.backgroundColor = [UIColor whiteColor];
        _proL.textAlignment = NSTextAlignmentCenter;
    }
    return _proL;
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_showtype == ShowTypeIsShareStyle) {
            _cancelBtn.frame = CGRectMake(0, CGRectGetHeight(_backGroundView.frame)-57, CGRectGetWidth(_backGroundView.frame), 50);
            _cancelBtn.layer.cornerRadius = 4;
            _cancelBtn.clipsToBounds = YES;
        }
        else
        {
            _cancelBtn.frame = CGRectMake(0, CGRectGetHeight(_backGroundView.frame)-50, CGRectGetWidth(_backGroundView.frame), 50);
        }
        
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


@end

@implementation ActionButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor colorWithRed:0.44f green:0.44f blue:0.44f alpha:1.00f] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:0.64f green:0.64f blue:0.64f alpha:1.00f] forState:UIControlStateHighlighted];
        
        
    }
    return self;
}


//取消按钮的高亮状态
- (void)setHighlighted:(BOOL)highlighted
{
}
////重写这个方法（调整标签标题的位置）
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(ZPScreenWidth/3-contentRect.size.width/2, contentRect.size.height-7, contentRect.size.width, 12);
//}
////调整图片位置
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake((ZPScreenWidth/5-44)/2, 7, 44, 44);
//}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2+5;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 10;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end


@implementation VerButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:0.81f green:0.81f blue:0.81f alpha:1.00f];
        [self addSubview:_lineView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _lineView.frame = CGRectMake(0, self.bounds.size.height-0.5, self.bounds.size.width, 0.5);
}

@end









