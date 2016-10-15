//
//  KSDatePicker.m
//  Bespeak
//
//  Created by kong on 16/3/4.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "KSDatePicker.h"
static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define AdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define AdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
#define AdapationLabelFont(n) n*([[UIScreen mainScreen]bounds].size.width/375.0f)
@implementation KSDatePicker
{
    
    UILabel     *_headerView;
    UIButton    *_cancelBtn;
    UIButton    *_commitBtn;
    UIView      *_horizonLine;
    UIView      *_verticalLine;
    
    UIButton    *_maskView;
    //中间的视图
    UIView *_middleView;
    //快速选择的三个按钮
    UIButton *_weakButton;
    UIButton *_monthButton;
    UIButton *_threeMonthButton;
    UIView *_currentDataSuperView;
    //显示的label
    UILabel *_currentDataLabel;
    
}

- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    {
        _maskView = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    {
        _appearance = [KSDatePickerAppearance new];
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
    {
        _middleView=[[UIView alloc]init];
        _middleView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_middleView];
    }
    {
        _weakButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _weakButton.tag=KSDatePickerWeakButtonTag;
        _weakButton.layer.borderColor=[UIColor colorWithHexString:@"#e85352"].CGColor;
        _weakButton.layer.borderWidth=1;
        [_weakButton setTitleColor:[UIColor colorWithHexString:@"#e85352"] forState:UIControlStateNormal];
        [_weakButton setTitle:@"一周" forState:UIControlStateNormal];
        _weakButton.layer.masksToBounds=YES;
        _weakButton.layer.cornerRadius=4;
        _weakButton.titleLabel.font=[UIFont systemFontOfSize:AdapationLabelFont(14)];
        [_weakButton addTarget:self action:@selector(footViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_middleView addSubview:_weakButton];
    }
    {
        _monthButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _monthButton.tag=KSDatePickerMonthButtonTag;
        _monthButton.layer.borderColor=[UIColor colorWithHexString:@"#e85352"].CGColor;
        _monthButton.layer.borderWidth=1;
        [_monthButton setTitleColor:[UIColor colorWithHexString:@"#e85352"] forState:UIControlStateNormal];
        [_monthButton setTitle:@"一个月" forState:UIControlStateNormal];
        _monthButton.layer.masksToBounds=YES;
        _monthButton.layer.cornerRadius=4;
        _monthButton.titleLabel.font=[UIFont systemFontOfSize:AdapationLabelFont(14)];
        [_monthButton addTarget:self action:@selector(footViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_middleView addSubview:_monthButton];
    }
    {
        _threeMonthButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _threeMonthButton.tag=KSDatePickerThreeMonthButtonTag;
        _threeMonthButton.layer.borderColor=[UIColor colorWithHexString:@"#e85352"].CGColor;
        _threeMonthButton.layer.borderWidth=1;
        [_threeMonthButton setTitleColor:[UIColor colorWithHexString:@"#e85352"] forState:UIControlStateNormal];
        [_threeMonthButton setTitle:@"三个月" forState:UIControlStateNormal];
        _threeMonthButton.layer.masksToBounds=YES;
        _threeMonthButton.layer.cornerRadius=4;
        _threeMonthButton.titleLabel.font=[UIFont systemFontOfSize:AdapationLabelFont(14)];
        [_threeMonthButton addTarget:self action:@selector(footViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_middleView addSubview:_threeMonthButton];
    }
    {
        _currentDataSuperView=[[UIView alloc]init];
        _currentDataSuperView.backgroundColor=[UIColor colorWithHexString:@"#ececec"];
        
        [_middleView addSubview:_currentDataSuperView];
    }
    {
        _currentDataLabel=[[UILabel alloc]init];
        _currentDataLabel.textColor=[UIColor colorWithHexString:@"#e85453"];
        _currentDataLabel.textAlignment=NSTextAlignmentCenter;
        _currentDataLabel.font=[UIFont boldSystemFontOfSize:AdapationLabelFont(18)];
       
        _currentDataLabel.text=_currentText;
        [_currentDataSuperView addSubview:_currentDataLabel];
    }
    [self reloadAppearance];
    
}
- (void)reloadAppearance
{
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

- (void)layoutSubviews
{
    CGFloat supWidth = self.frame.size.width;
    CGFloat supHeight = self.frame.size.height;
    CGFloat btnW=(supWidth-AdaptationW(40))/3;
    
    
    {
        _headerView.frame = CGRectMake(0, 0, supWidth, _appearance.headerHeight);
    }
    {
        _middleView.frame= CGRectMake(0, _appearance.headerHeight, supWidth, AdaptationH(106));

    }
    {
        _weakButton.frame=CGRectMake(AdaptationW(10), AdaptationH(19), btnW, AdaptationH(27));
    }
    {
        _monthButton.frame=CGRectMake(btnW+AdaptationW(20), AdaptationH(19), btnW, AdaptationH(27));
    }
    {
        _threeMonthButton.frame=CGRectMake(btnW*2+AdaptationW(30), AdaptationH(19), btnW, AdaptationH(27));
    }
    {
        _currentDataSuperView.frame=CGRectMake(0, AdaptationH(65), supWidth, AdaptationH(41));
        
    }
    {
        _currentDataLabel.frame=CGRectMake(0, 0, supWidth, AdaptationH(41));
    }
    {
        _datePicker.frame = CGRectMake(0, _appearance.headerHeight+AdaptationH(90), supWidth, supHeight - _appearance.headerHeight - _appearance.buttonHeight);
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
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[NSDate date]];
        if (button.tag==KSDatePickerWeakButtonTag) {
            components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
            [components setHour:-24*6];
            [components setMinute:0];
            [components setSecond:0];
            NSDate *lastWeek  = [cal dateFromComponents:components];
            _appearance.resultCallBack(self,lastWeek,button.tag);
        }else if (button.tag==KSDatePickerMonthButtonTag){
            components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
            [components setMonth:([components month] - 1)];
            NSDate *lastMonth  = [cal dateFromComponents:components];
            _appearance.resultCallBack(self,lastMonth,button.tag);
        }else if (button.tag==KSDatePickerThreeMonthButtonTag){
            components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
            [components setMonth:([components month] - 3)];
            NSDate *threeMonth  = [cal dateFromComponents:components];
            _appearance.resultCallBack(self,threeMonth,button.tag);
        }else{
            _appearance.resultCallBack(self,_datePicker.date,button.tag);
        }
        
    }
    
    
    [self hidden];
    
}


- (void)show
{
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
- (void)hidden
{   [_maskView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
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
