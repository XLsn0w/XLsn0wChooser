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

#import "XLsn0wCenterDater.h"

@interface XLsn0wCenterDater ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UILabel      *headerView;
@property (nonatomic, strong) UIButton     *cancelBtn;
@property (nonatomic, strong) UIButton     *commitBtn;
@property (nonatomic, strong) UIView       *horizonLine;
@property (nonatomic, strong) UIView       *verticalLine;
@property (nonatomic, strong) UIButton     *maskView;

@end

@implementation XLsn0wCenterDater

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    {
        _maskView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_maskView addTarget:self action:@selector(hide) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    {
        _appearance = [DatePickerAppearance new];
    }
    
    {
        _datePicker = [[UIDatePicker alloc] init];
        [self addSubview:_datePicker];
    }
    
    {
        _headerView = [[UILabel alloc] init];
        [self addSubview:_headerView];
    }
    
    {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.tag = KSDatePickerButtonCancel;
        [self addSubview:_cancelBtn];
        [_cancelBtn addTarget:self action:@selector(footViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.tag = KSDatePickerButtonCommit;
        [self addSubview:_commitBtn];
        [_commitBtn addTarget:self action:@selector(footViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        _horizonLine = [[UIView alloc] init];
        [self addSubview:_horizonLine];
        
        _verticalLine = [[UIView alloc] init];
        [self addSubview:_verticalLine];
    }
   
    [self reloadAppearance];
    
}

- (void)reloadAppearance {
    {
        _maskView.frame = [UIScreen mainScreen].bounds;
        _maskView.backgroundColor = _appearance.maskBackgroundColor;
    }
    
    {
        self.backgroundColor = _appearance.datePickerBackgroundColor;
        if (_appearance.radius > 0) {
            self.layer.cornerRadius = _appearance.radius;
            self.layer.masksToBounds = YES;
        }
    }
    
    {
        _datePicker.datePickerMode = _appearance.datePickerMode;
        _datePicker.minimumDate = _appearance.minimumDate;
        _datePicker.maximumDate = _appearance.maximumDate;
        _datePicker.date = _appearance.currentDate;
    }
    
    {
        _headerView.text = _appearance.headerText;
        _headerView.font = _appearance.headerTextFont;
        _headerView.textColor = _appearance.headerTextColor;
        _headerView.textAlignment = _appearance.headerTextAlignment;
        _headerView.backgroundColor = _appearance.headerBackgroundColor;
    }
    
    {
        _cancelBtn.titleLabel.font = _appearance.cancelBtnFont;
        [_cancelBtn setBackgroundColor:_appearance.cancelBtnBackgroundColor];
        [_cancelBtn setTitle:_appearance.cancelBtnTitle forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:_appearance.cancelBtnTitleColor forState:UIControlStateNormal];
    }
    
    {
        _commitBtn.titleLabel.font = _appearance.commitBtnFont;
        [_commitBtn setBackgroundColor:_appearance.commitBtnBackgroundColor];
        [_commitBtn setTitle:_appearance.commitBtnTitle forState:UIControlStateNormal];
        [_commitBtn setTitleColor:_appearance.commitBtnTitleColor forState:UIControlStateNormal];

    }
    
    {
        _horizonLine.backgroundColor = _appearance.lineColor;
        
        _verticalLine.backgroundColor = _appearance.lineColor;
    }
}

- (void)layoutSubviews {
    CGFloat supWidth = self.frame.size.width;
    CGFloat supHeight = self.frame.size.height;
    
    {
        _datePicker.frame = CGRectMake(0, _appearance.headerHeight, supWidth, supHeight - _appearance.headerHeight - _appearance.buttonHeight);
    }
    
    {
        _headerView.frame = CGRectMake(0, 0, supWidth, _appearance.headerHeight);
    }
    
    {
        _cancelBtn.frame = CGRectMake(0 * supWidth / 2 ,supHeight - _appearance.buttonHeight , supWidth / 2, _appearance.buttonHeight);
        
        _commitBtn.frame = CGRectMake(1 * supWidth / 2, supHeight - _appearance.buttonHeight, supWidth / 2, _appearance.buttonHeight);
    }
    
    {
        _horizonLine.frame = CGRectMake(0, supHeight - _appearance.buttonHeight, supWidth, _appearance.lineWidth);
        
        _verticalLine.frame = CGRectMake(supWidth / 2., supHeight - _appearance.buttonHeight, _appearance.lineWidth, _appearance.buttonHeight);
    }
}

- (void)footViewButtonClick:(UIButton*)button
{
    if (_appearance.resultCallBack) {
        _appearance.resultCallBack(self,_datePicker.date,button.tag);
    }
    
    [self hide];
    
}


- (void)show {
    [self reloadAppearance];
    
    [self animationWithView:self duration:0.3];
    _maskView.alpha= 0;
    [UIView animateWithDuration:0.25 animations:^{
        _maskView.alpha = 0.5;
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_maskView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
}

- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        [_maskView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration { 
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [view.layer addAnimation:animation forKey:nil];
}

@end

/**************************************************************************************************/

@implementation DatePickerAppearance

- (instancetype)init {
    if (self = [super init]) {
        [self defultValue];
    }
    return self;
}

- (void)defultValue {
    _datePickerBackgroundColor = [UIColor whiteColor];
    _radius = 0.;
    _maskBackgroundColor = [UIColor blackColor];
    
    _currentDate = [NSDate date];
    
    _datePickerMode = UIDatePickerModeDate;
    
    _headerText = @"请选择日期";
    _headerTextColor = [UIColor whiteColor];
    _headerTextFont = [UIFont systemFontOfSize:15];
    _headerBackgroundColor = [UIColor colorWithRed:45/255. green:54/255. blue:62/255. alpha:1];
    _headerTextAlignment = NSTextAlignmentCenter;
    _headerHeight = 44.;
    
    _buttonHeight = 44.;
    
    _commitBtnTitle = @"确定";
    _commitBtnFont = [UIFont boldSystemFontOfSize:15];
    _commitBtnTitleColor = [UIColor whiteColor];
    _commitBtnBackgroundColor = [UIColor blueColor];
    
    _cancelBtnTitle = @"取消";
    _cancelBtnFont = [UIFont boldSystemFontOfSize:15];
    _cancelBtnTitleColor = [UIColor whiteColor];
    _cancelBtnBackgroundColor = [UIColor blueColor];
    
    _lineColor = [UIColor colorWithRed:205/255. green:205/255. blue:205/255. alpha:1.];
    _lineWidth = 0.5;
    
}

@end
