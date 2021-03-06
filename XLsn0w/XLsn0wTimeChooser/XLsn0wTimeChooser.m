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

#define kTopViewHeight kScaleFrom_iPhone5_Desgin(44)
#define kTimeBroadcastViewHeight kScaleFrom_iPhone5_Desgin(200)
#define kDatePickerHeight (kTopViewHeight + kTimeBroadcastViewHeight)
#define kOKBtnTag 101
#define kCancleBtnTag 100

#import "XLsn0wTimeChooser.h"

#import "Masonry.h"

@interface XLsn0wTimeChooser () <UIGestureRecognizerDelegate> {
    UIView                      *timeBroadcastView;//定时播放显示视图
    MXSCycleScrollView          *yearScrollView;//年份滚动视图
    MXSCycleScrollView          *monthScrollView;//月份滚动视图
    MXSCycleScrollView          *dayScrollView;//日滚动视图
    MXSCycleScrollView          *hourScrollView;//时滚动视图
    MXSCycleScrollView          *minuteScrollView;//分滚动视图
    MXSCycleScrollView          *secondScrollView;//秒滚动视图
    NSString                    *dateTimeStr;
}

@property (nonatomic,assign) NSInteger curYear;//当前年
@property (nonatomic,assign) NSInteger curMonth;//当前月
@property (nonatomic,assign) NSInteger curDay;//当前日
@property (nonatomic,assign) NSInteger curHour;//当前小时
@property (nonatomic,assign) NSInteger curMin;//当前分
@property (nonatomic,assign) NSInteger curSecond;//当前秒

@property (nonatomic, retain) NSDate *defaultDate;

@end

@implementation XLsn0wTimeChooser

- (instancetype)initWithDefaultDatetime:(NSDate *)dateTime {
    self = [super init];
    if (self) {
        self.defaultDate = dateTime;
        if (!self.defaultDate) {
            self.defaultDate = [NSDate date];
        }
        self.datePickerMode = DatePickerDateTimeMode;
        [self setTimeBroadcastView];
    }
    return self;
}

- (instancetype)initWithDatePickerMode:(DatePickerMode)datePickerMode defaultDateTime:(NSDate *)dateTime
{
    self = [super init];
    if (self) {
        self.defaultDate = dateTime;
        if (!self.defaultDate) {
            self.defaultDate = [NSDate date];
        }
        self.datePickerMode = datePickerMode;
        [self setTimeBroadcastView];
    }
    return self;
}

- (void)setMaxYear:(NSInteger)maxYear {
    _maxYear = maxYear;
    [self updateYearScrollView];
}
- (void)setMinYear:(NSInteger)minYear {
    _minYear = minYear;
    [self updateYearScrollView];
}

- (void)updateYearScrollView {
    [yearScrollView reloadData];
    
    [yearScrollView setCurrentSelectPage:(self.curYear-(_minYear+2))];
    [self setAfterScrollShowView:yearScrollView andCurrentPage:1];
}

#pragma mark -custompicker

//设置自定义datepicker界面
- (void)setTimeBroadcastView {
    
    [self setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    [self setBackgroundColor:[UIColor clearColor]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateTimeStr = [dateFormatter stringFromDate:self.defaultDate];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kTopViewHeight)];
    _topView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, kTopViewHeight-0.5, kScreen_Width, 0.5)];
    _line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [_topView addSubview:_line];
    
    _okBtn = [[UIButton alloc] init];
    _okBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_okBtn setBackgroundColor:[UIColor colorWithHexString:@"0x6271f3"]];
    [_okBtn setTitleColor:[UIColor colorWithHexString:@"0xffffff"] forState:UIControlStateNormal];
    [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_okBtn addTarget:self action:@selector(removeXLsn0wChooserTimerEvent:) forControlEvents:UIControlEventTouchUpInside];
    _okBtn.tag = kOKBtnTag;
    _okBtn.layer.masksToBounds = YES;
    _okBtn.layer.cornerRadius = 5;
    [_topView addSubview:_okBtn];
    [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(_topView);
        make.height.mas_equalTo(kTopViewHeight-15);
        make.width.mas_equalTo(kTopViewHeight);
    }];
    
    _cancleBtn = [[UIButton alloc] init];
    _cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_cancleBtn setBackgroundColor:[UIColor colorWithHexString:@"0x6271f3"]];
    [_cancleBtn setTitleColor:[UIColor colorWithHexString:@"0xffffff"] forState:UIControlStateNormal];
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleBtn addTarget:self action:@selector(removeXLsn0wChooserTimerEvent:) forControlEvents:UIControlEventTouchUpInside];
    _cancleBtn.tag = kCancleBtnTag;
    _cancleBtn.layer.masksToBounds = YES;
    _cancleBtn.layer.cornerRadius = 5;
    [_topView addSubview:_cancleBtn];
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(_topView);
        make.height.mas_equalTo(kTopViewHeight-15);
        make.width.mas_equalTo(kTopViewHeight);
    }];
    
    _selectedLabel = [UILabel new];
    [_topView addSubview:_selectedLabel];
    [_selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_topView);
        make.centerY.mas_equalTo(_topView);
        make.height.mas_equalTo(kTopViewHeight-20);
    }];
    _selectedLabel.textColor = [UIColor colorWithHexString:@"0x6271f3"];
    _selectedLabel.text = @"请选择";
    _selectedLabel.font = [UIFont boldSystemFontOfSize:18];
    
    timeBroadcastView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTimeBroadcastViewHeight)];
    timeBroadcastView.backgroundColor = [UIColor redColor];
    timeBroadcastView.layer.cornerRadius = 0;//设置视图圆角
    timeBroadcastView.layer.masksToBounds = YES;
    CGColorRef cgColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0].CGColor;
    timeBroadcastView.layer.borderColor = cgColor;
    timeBroadcastView.layer.borderWidth = 0.0;
    timeBroadcastView.backgroundColor = [UIColor whiteColor];
    [self addSubview:timeBroadcastView];
    UIView *beforeSepLine = [[UIView alloc] initWithFrame:CGRectMake(0, kTopViewHeight + (kTimeBroadcastViewHeight / 5), kScreen_Width, 1.5)];
    [beforeSepLine setBackgroundColor:[UIColor colorWithHexString:@"0xEDEDED"]];
    [timeBroadcastView addSubview:beforeSepLine];
    UIView *middleSepView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopViewHeight + 2 * (kTimeBroadcastViewHeight / 5), kScreen_Width, kTimeBroadcastViewHeight / 5)];
    [middleSepView setBackgroundColor:[UIColor colorWithHexString:@"0xEDEDED"]];
    [timeBroadcastView addSubview:middleSepView];
    middleSepView.layer.borderWidth = 1.5;
    middleSepView.layer.borderColor = [UIColor colorWithHexString:@"0xEDEDED"].CGColor;
    UIView *bottomSepLine = [[UIView alloc] initWithFrame:CGRectMake(0, kTopViewHeight + 4 * (kTimeBroadcastViewHeight / 5), kScreen_Width, 1.5)];
    [bottomSepLine setBackgroundColor:[UIColor colorWithHexString:@"0xEDEDED"]];
    [timeBroadcastView addSubview:bottomSepLine];
    
    if (self.datePickerMode == DatePickerDateMode) {
        [self setYearScrollView];
        [self setMonthScrollView];
        [self setDayScrollView];
    }
    else if (self.datePickerMode == DatePickerTimeMode) {
        [self setHourScrollView];
        [self setMinuteScrollView];
        [self setSecondScrollView];
    }
    else if (self.datePickerMode == DatePickerDateTimeMode) {
        [self setYearScrollView];
        [self setMonthScrollView];
        [self setDayScrollView];
        [self setHourScrollView];
        [self setMinuteScrollView];
        [self setSecondScrollView];
    }
    else if (self.datePickerMode == DatePickerYearMonthMode) {
        [self setYearScrollView];
        [self setMonthScrollView];
    }
    else if (self.datePickerMode == DatePickerMonthDayMode) {
        [self setMonthScrollView];
        [self setDayScrollView];
    }
    else if (self.datePickerMode == DatePickerHourMinuteMode) {
        [self setHourScrollView];
        [self setMinuteScrollView];
    }
    else if (self.datePickerMode == DatePickerDateHourMinuteMode) {
        [self setYearScrollView];
        [self setMonthScrollView];
        [self setDayScrollView];
        [self setHourScrollView];
        [self setMinuteScrollView];
    }
    
    [timeBroadcastView addSubview:_topView];
    [timeBroadcastView setFrame:CGRectMake(0, kScreen_Height-100, kScreen_Width, kDatePickerHeight)];
}
//设置年月日时分的滚动视图
- (void)setYearScrollView
{
    if (self.datePickerMode == DatePickerDateTimeMode) {
        yearScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, kScreen_Width*0.25, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerDateMode) {
        yearScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, kScreen_Width*0.34, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerYearMonthMode) {
        yearScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, kScreen_Width*0.5, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerDateHourMinuteMode) {
        yearScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, kScreen_Width*0.28, kTimeBroadcastViewHeight)];
    }
    
    self.curYear = [self setNowTimeShow:0];
    [yearScrollView setCurrentSelectPage:(self.curYear-(_minYear+2))];
    yearScrollView.delegate = self;
    yearScrollView.datasource = self;
    [self setAfterScrollShowView:yearScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:yearScrollView];
}
//设置年月日时分的滚动视图
- (void)setMonthScrollView
{
    if (self.datePickerMode == DatePickerDateTimeMode) {
        monthScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.25, kTopViewHeight, kScreen_Width*0.15, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerDateMode) {
        monthScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.34, kTopViewHeight, kScreen_Width*0.33, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerMonthDayMode) {
        monthScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0, kTopViewHeight, kScreen_Width*0.5, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerYearMonthMode) {
        monthScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.5, kTopViewHeight, kScreen_Width*0.5, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerDateHourMinuteMode) {
        monthScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.28, kTopViewHeight, kScreen_Width*0.18, kTimeBroadcastViewHeight)];
    }
    
    self.curMonth = [self setNowTimeShow:1];
    [monthScrollView setCurrentSelectPage:(self.curMonth-3)];
    monthScrollView.delegate = self;
    monthScrollView.datasource = self;
    [self setAfterScrollShowView:monthScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:monthScrollView];
}
//设置年月日时分的滚动视图
- (void)setDayScrollView
{
    if (self.datePickerMode == DatePickerDateTimeMode) {
        dayScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.40, kTopViewHeight, kScreen_Width*0.15, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerDateMode) {
        dayScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.67, kTopViewHeight, kScreen_Width*0.33, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerMonthDayMode) {
        dayScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.5, kTopViewHeight, kScreen_Width*0.5, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerDateHourMinuteMode) {
        dayScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.46, kTopViewHeight, kScreen_Width*0.18, kTimeBroadcastViewHeight)];
    }
    
    self.curDay = [self setNowTimeShow:2];
    [dayScrollView setCurrentSelectPage:(self.curDay-3)];
    dayScrollView.delegate = self;
    dayScrollView.datasource = self;
    [self setAfterScrollShowView:dayScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:dayScrollView];
}
//设置年月日时分的滚动视图
- (void)setHourScrollView
{
    if (self.datePickerMode == DatePickerDateTimeMode) {
        hourScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.55, kTopViewHeight, kScreen_Width*0.15, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerTimeMode) {
        hourScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, kScreen_Width*0.34, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerHourMinuteMode) {
        hourScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, kScreen_Width*0.5, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerDateHourMinuteMode) {
        hourScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.64, kTopViewHeight, kScreen_Width*0.18, kTimeBroadcastViewHeight)];
    }
    
    self.curHour = [self setNowTimeShow:3];
    [hourScrollView setCurrentSelectPage:(self.curHour-2)];
    hourScrollView.delegate = self;
    hourScrollView.datasource = self;
    [self setAfterScrollShowView:hourScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:hourScrollView];
}
//设置年月日时分的滚动视图
- (void)setMinuteScrollView
{
    if (self.datePickerMode == DatePickerDateTimeMode) {
        minuteScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.70, kTopViewHeight, kScreen_Width*0.15, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerTimeMode) {
        minuteScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.34, kTopViewHeight, kScreen_Width*0.33, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerHourMinuteMode) {
        minuteScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.5, kTopViewHeight, kScreen_Width*0.5, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerDateHourMinuteMode) {
        minuteScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.82, kTopViewHeight, kScreen_Width*0.18, kTimeBroadcastViewHeight)];
    }
    
    self.curMin = [self setNowTimeShow:4];
    [minuteScrollView setCurrentSelectPage:(self.curMin-2)];
    minuteScrollView.delegate = self;
    minuteScrollView.datasource = self;
    [self setAfterScrollShowView:minuteScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:minuteScrollView];
}
//设置年月日时分的滚动视图
- (void)setSecondScrollView
{
    if (self.datePickerMode == DatePickerDateTimeMode) {
        secondScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.85, kTopViewHeight, kScreen_Width*0.15, kTimeBroadcastViewHeight)];
    } else if (self.datePickerMode == DatePickerTimeMode) {
        secondScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(kScreen_Width*0.67, kTopViewHeight, kScreen_Width*0.33, kTimeBroadcastViewHeight)];
    }
    self.curSecond = [self setNowTimeShow:5];
    [secondScrollView setCurrentSelectPage:(self.curSecond-2)];
    secondScrollView.delegate = self;
    secondScrollView.datasource = self;
    [self setAfterScrollShowView:secondScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:secondScrollView];
}
- (void)setAfterScrollShowView:(MXSCycleScrollView*)scrollview  andCurrentPage:(NSInteger)pageNumber
{
    UILabel *oneLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber];
    [oneLabel setFont:[UIFont systemFontOfSize:14]];
    [oneLabel setTextColor:[UIColor colorWithHexString:@"0xBABABA"]];
    UILabel *twoLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+1];
    [twoLabel setFont:[UIFont systemFontOfSize:16]];
    [twoLabel setTextColor:[UIColor colorWithHexString:@"0x717171"]];
    
    UILabel *currentLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+2];
    [currentLabel setFont:[UIFont systemFontOfSize:18]];
    [currentLabel setTextColor:[UIColor blackColor]];
    
    UILabel *threeLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+3];
    [threeLabel setFont:[UIFont systemFontOfSize:16]];
    [threeLabel setTextColor:[UIColor colorWithHexString:@"0x717171"]];
    
    UILabel *fourLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+4];
    [fourLabel setFont:[UIFont systemFontOfSize:14]];
    [fourLabel setTextColor:[UIColor colorWithHexString:@"0xBABABA"]];
}
#pragma mark mxccyclescrollview delegate
#pragma mark mxccyclescrollview databasesource
- (NSInteger)numberOfPages:(MXSCycleScrollView*)scrollView {
    if (scrollView == yearScrollView) {
        
        if (self.datePickerMode == DatePickerDateMode || self.datePickerMode == DatePickerDateTimeMode) {
            return _maxYear - _minYear + 1;
        }
        
        return 299;
    }
    else if (scrollView == monthScrollView)
    {
        return 12;
    }
    else if (scrollView == dayScrollView)
    {
        
        if (DatePickerMonthDayMode == self.datePickerMode) {
            return 29;
        }
        
        if (self.curMonth == 1 || self.curMonth == 3 || self.curMonth == 5 ||
            self.curMonth == 7 || self.curMonth == 8 || self.curMonth == 10 ||
            self.curMonth == 12) {
            return 31;
        } else if (self.curMonth == 2) {
            if ([self isLeapYear:self.curYear]) {
                return 29;
            } else {
                return 28;
            }
        } else {
            return 30;
        }
    }
    else if (scrollView == hourScrollView)
    {
        return 24;
    }
    else if (scrollView == minuteScrollView)
    {
        return 60;
    }
    return 60;
}

- (UIView *)pageAtIndex:(NSInteger)index andScrollView:(MXSCycleScrollView *)scrollView {
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height/5)];
    contentLabel.tag = index+1;
    if (scrollView == yearScrollView) {
        contentLabel.text = [NSString stringWithFormat:@"%ld年",(long)(_minYear+index)];
    }
    else if (scrollView == monthScrollView)
    {
        contentLabel.text = [NSString stringWithFormat:@"%ld月",(long)(1+index)];
    }
    else if (scrollView == dayScrollView)
    {
        contentLabel.text = [NSString stringWithFormat:@"%ld日",(long)(1+index)];
    }
    else if (scrollView == hourScrollView)
    {
        if (index < 10) {
            contentLabel.text = [NSString stringWithFormat:@"0%ld时",(long)index];
        }
        else
            contentLabel.text = [NSString stringWithFormat:@"%ld时",(long)index];
    }
    else if (scrollView == minuteScrollView)
    {
        if (index < 10) {
            contentLabel.text = [NSString stringWithFormat:@"0%ld分",(long)index];
        }
        else
            contentLabel.text = [NSString stringWithFormat:@"%ld分",(long)index];
    }
    else
        if (index < 10) {
            contentLabel.text = [NSString stringWithFormat:@"0%ld秒",(long)index];
        }
        else
            contentLabel.text = [NSString stringWithFormat:@"%ld秒",(long)index];
    
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.backgroundColor = [UIColor clearColor];
//    contentLabel.textColor = [UIColor redColor];
    return contentLabel;
}
//设置现在时间
- (NSInteger)setNowTimeShow:(NSInteger)timeType
{
    NSDate *now = self.defaultDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:now];
    switch (timeType) {
        case 0:
        {
            NSRange range = NSMakeRange(0, 4);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 1:
        {
            NSRange range = NSMakeRange(4, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 2:
        {
            NSRange range = NSMakeRange(6, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 3:
        {
            NSRange range = NSMakeRange(8, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 4:
        {
            NSRange range = NSMakeRange(10, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 5:
        {
            NSRange range = NSMakeRange(12, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        default:
            break;
    }
    return 0;
}
//选择设置的播报时间
- (void)selectSetBroadcastTime
{
    UILabel *yearLabel = [[(UILabel*)[[yearScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *monthLabel = [[(UILabel*)[[monthScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *dayLabel = [[(UILabel*)[[dayScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *hourLabel = [[(UILabel*)[[hourScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *minuteLabel = [[(UILabel*)[[minuteScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *secondLabel = [[(UILabel*)[[secondScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    
    NSInteger yearInt = yearLabel.tag + _minYear - 1;
    NSInteger monthInt = monthLabel.tag;
    NSInteger dayInt = dayLabel.tag;
    NSInteger hourInt = hourLabel.tag - 1;
    NSInteger minuteInt = minuteLabel.tag - 1;
    NSInteger secondInt = secondLabel.tag - 1;
    NSString *taskDateString = [NSString stringWithFormat:@"%ld%02ld%02ld%02ld%02ld%02ld",(long)yearInt,(long)monthInt,(long)dayInt,(long)hourInt,(long)minuteInt,(long)secondInt];
    NSLog(@"Now----%@",taskDateString);
}

//滚动时上下标签显示(当前时间和是否为有效时间)
- (void)scrollviewDidChangeNumber {
    UILabel *yearLabel = [[(UILabel*)[[yearScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *monthLabel = [[(UILabel*)[[monthScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *dayLabel = [[(UILabel*)[[dayScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *hourLabel = [[(UILabel*)[[hourScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *minuteLabel = [[(UILabel*)[[minuteScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *secondLabel = [[(UILabel*)[[secondScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    
    NSInteger month = monthLabel.tag;
    NSInteger year = yearLabel.tag + _minYear - 1;
    if (month != self.curMonth) {
        self.curMonth = month;
        [dayScrollView reloadData];
        [dayScrollView setCurrentSelectPage:(self.curDay-3)];
        [self setAfterScrollShowView:dayScrollView andCurrentPage:1];
    }
    if (year != self.curYear) {
        self.curYear = year;
        [dayScrollView reloadData];
        [dayScrollView setCurrentSelectPage:(self.curDay-3)];
        [self setAfterScrollShowView:dayScrollView andCurrentPage:1];
    }
    
    self.curMonth = monthLabel.tag;
    self.curDay = dayLabel.tag;
    self.curHour = hourLabel.tag - 1;
    self.curMin = minuteLabel.tag - 1;
    self.curSecond = secondLabel.tag - 1;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *selectTimeString = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:%02ld",(long)self.curYear,(long)self.curMonth,(long)self.curDay,(long)self.curHour,(long)self.curMin,(long)self.curSecond];
    NSDate *selectDate = [dateFormatter dateFromString:selectTimeString];
    NSDate *nowDate = self.defaultDate;
    NSString *nowString = [dateFormatter stringFromDate:nowDate];
    NSDate *nowStrDate = [dateFormatter dateFromString:nowString];
    if (NSOrderedAscending == [selectDate compare:nowStrDate]) {//选择的时间与当前系统时间做比较
        [_okBtn setEnabled:YES];
    }
    else
    {
        [_okBtn setEnabled:YES];
    }
}
//通过日期求星期
- (NSString*)fromDateToWeek:(NSString*)selectDate
{
    NSInteger yearInt = [selectDate substringWithRange:NSMakeRange(0, 4)].integerValue;
    NSInteger monthInt = [selectDate substringWithRange:NSMakeRange(4, 2)].integerValue;
    NSInteger dayInt = [selectDate substringWithRange:NSMakeRange(6, 2)].integerValue;
    int c = 20;//世纪
    NSInteger y = yearInt -1;//年
    NSInteger d = dayInt;
    NSInteger m = monthInt;
    int w =(y+(y/4)+(c/4)-2*c+(26*(m+1)/10)+d-1)%7;
    NSString *weekDay = @"";
    switch (w) {
        case 0:
            weekDay = @"周日";
            break;
        case 1:
            weekDay = @"周一";
            break;
        case 2:
            weekDay = @"周二";
            break;
        case 3:
            weekDay = @"周三";
            break;
        case 4:
            weekDay = @"周四";
            break;
        case 5:
            weekDay = @"周五";
            break;
        case 6:
            weekDay = @"周六";
            break;
        default:
            break;
    }
    return weekDay;
}

- (void)showInSuperview:(UIView *)superview {
    [superview addSubview:self];
    
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [weak setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
        [timeBroadcastView setFrame:CGRectMake(0, kScreen_Height - kDatePickerHeight, kScreen_Width, kDatePickerHeight)];
        
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weak action:@selector(dismiss:)];
        tap.delegate = self;
        [weak addGestureRecognizer:tap];
        
        [timeBroadcastView setFrame:CGRectMake(0, kScreen_Height - kDatePickerHeight, kScreen_Width, kDatePickerHeight)];
    }];
}

- (void)dismissBlock:(DatePickerCompleteAnimationBlock)block {
    typeof(self) __weak weakSelf = self;

    
    [UIView animateWithDuration:0.4f
                          delay:0
         usingSpringWithDamping:0.8f
          initialSpringVelocity:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         [timeBroadcastView removeFromSuperview];
                     }
                     completion:^(BOOL finished) {
                         block(finished);
                         [weakSelf removeFromSuperview];
                     }];
}

-(void)dismiss:(UITapGestureRecognizer *)tap{
    
    if( CGRectContainsPoint(self.frame, [tap locationInView:timeBroadcastView])) {
        NSLog(@"tap");
    } else{
        
        [self dismissBlock:^(BOOL Complete) {
            
        }];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != self) {
        return NO;
    }
    
    return YES;
}

-(void)removeXLsn0wChooserTimerEvent:(UIButton *)selectedButton{
    
    typeof(self) __weak weak = self;
    [self dismissBlock:^(BOOL Complete) {
        if (selectedButton.tag == kOKBtnTag) {
            
            switch (self.datePickerMode) {
                case DatePickerDateMode:
                    dateTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)self.curYear,(long)self.curMonth,(long)self.curDay];
                    break;
                case DatePickerTimeMode:
                    dateTimeStr = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)self.curHour,(long)self.curMin,(long)self.curSecond];
                    break;
                case DatePickerDateTimeMode:
                    dateTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld %02ld:%02ld:%02ld",(long)self.curYear,(long)self.curMonth,(long)self.curDay,(long)self.curHour,(long)self.curMin,(long)self.curSecond];
                    break;
                case DatePickerMonthDayMode:
                    dateTimeStr = [NSString stringWithFormat:@"%ld-%ld",(long)self.curMonth,(long)self.curDay];
                    break;
                case DatePickerYearMonthMode:
                    dateTimeStr = [NSString stringWithFormat:@"%ld-%ld",(long)self.curYear,(long)self.curMonth];
                    break;
                case DatePickerHourMinuteMode:
                    dateTimeStr = [NSString stringWithFormat:@"%02ld:%02ld",(long)self.curHour,(long)self.curMin];
                    break;
                case DatePickerDateHourMinuteMode:
                    dateTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld %02ld:%02ld",(long)self.curYear,(long)self.curMonth,(long)self.curDay,(long)self.curHour,(long)self.curMin];
                    break;
                default:
                    dateTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld %02ld:%02ld:%02ld",(long)self.curYear,(long)self.curMonth,(long)self.curDay,(long)self.curHour,(long)self.curMin,(long)self.curSecond];
                    break;
            }
            
            weak.clickedOkBtn(dateTimeStr);
            [self.xlsn0wDelegate timeChooser:self didSelectTimeString:dateTimeStr];
        } else {
            
        }
    }];
    
    
}

-(BOOL)isLeapYear:(NSInteger)year {
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}

@end

@implementation UIColor (XLsn0wTimeChooser)

- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)canProvideRGBComponents {
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (CGFloat)red {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)blue {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat)white {
    NSAssert(self.colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (UInt32)rgbHex {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return 0;
    
    r = MIN(MAX(self.red, 0.0f), 1.0f);
    g = MIN(MAX(self.green, 0.0f), 1.0f);
    b = MIN(MAX(self.blue, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 16)
    | (((int)roundf(g * 255)) << 8)
    | (((int)roundf(b * 255)));
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r,g,b,a;
    
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            a = components[1];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
            break;
        default:	// We don't know how to handle this model
            return NO;
    }
    
    if (red) *red = r;
    if (green) *green = g;
    if (blue) *blue = b;
    if (alpha) *alpha = a;
    
    return YES;
}


+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha{
    UIColor *color = [UIColor colorWithHexString:stringToConvert];
    return [UIColor colorWithRed:color.red green:color.green blue:color.blue alpha:alpha];
}
@end



@implementation MXSCycleScrollView

@synthesize scrollView = _scrollView;
@synthesize currentPage = _curPage;
@synthesize datasource = _datasource;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width, (self.bounds.size.height/5)*7);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(0, (self.bounds.size.height/5));
        
        [self addSubview:_scrollView];
    }
    return self;
}
//设置初始化页数
- (void)setCurrentSelectPage:(NSInteger)selectPage
{
    _curPage = selectPage;
}

- (void)setDataource:(id<MXSCycleScrollViewDatasource>)datasource
{
    _datasource = datasource;
    [self reloadData];
}

- (void)reloadData
{
    _totalPages = [_datasource numberOfPages:self];
    if (_totalPages == 0) {
        return;
    }
    [self loadData];
}

- (void)loadData
{
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < 7; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        //        v.userInteractionEnabled = YES;
        //        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
        //                                                                                    action:@selector(handleTap:)];
        //        [v addGestureRecognizer:singleTap];
        v.frame = CGRectOffset(v.frame, 0, v.frame.size.height * i );
        [_scrollView addSubview:v];
    }
    
    [_scrollView setContentOffset:CGPointMake( 0, (self.bounds.size.height/5) )];
}

- (void)getDisplayImagesWithCurpage:(NSInteger)page {
    NSInteger pre1 = [self validPageValue:_curPage-1];
    NSInteger pre2 = [self validPageValue:_curPage];
    NSInteger pre3 = [self validPageValue:_curPage+1];
    NSInteger pre4 = [self validPageValue:_curPage+2];
    NSInteger pre5 = [self validPageValue:_curPage+3];
    NSInteger pre = [self validPageValue:_curPage+4];
    NSInteger last = [self validPageValue:_curPage+5];
    
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    [_curViews removeAllObjects];
    
    [_curViews addObject:[_datasource pageAtIndex:pre1 andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:pre2 andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:pre3 andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:pre4 andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:pre5 andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:pre andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:last andScrollView:self]];
}

- (NSInteger)validPageValue:(NSInteger)value {
    
    if(value < 0 ) value = _totalPages + value;
    if(value == _totalPages+1) value = 1;
    if (value == _totalPages+2) value = 2;
    if(value == _totalPages+3) value = 3;
    if (value == _totalPages+4) value = 4;
    if(value == _totalPages) value = 0;
    
    
    return value;
    
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
    
}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 7; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            //            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
            //                                                                                        action:@selector(handleTap:)];
            //            [v addGestureRecognizer:singleTap];
            v.frame = CGRectOffset(v.frame, 0, v.frame.size.height * i);
            [_scrollView addSubview:v];
        }
    }
}

- (void)setAfterScrollShowView:(UIScrollView*)scrollview  andCurrentPage:(NSInteger)pageNumber
{
    UILabel *oneLabel = (UILabel*)[[scrollview subviews] objectAtIndex:pageNumber];
    [oneLabel setFont:[UIFont systemFontOfSize:14]];
    [oneLabel setTextColor:[UIColor colorWithHexString:@"0xBABABA"]];
    UILabel *twoLabel = (UILabel*)[[scrollview subviews] objectAtIndex:pageNumber+1];
    [twoLabel setFont:[UIFont systemFontOfSize:16]];
    [twoLabel setTextColor:[UIColor colorWithHexString:@"0x717171"]];
    
    UILabel *currentLabel = (UILabel*)[[scrollview subviews] objectAtIndex:pageNumber+2];
    [currentLabel setFont:[UIFont systemFontOfSize:18]];
    [currentLabel setTextColor:[UIColor blackColor]];
    
    UILabel *threeLabel = (UILabel*)[[scrollview subviews] objectAtIndex:pageNumber+3];
    [threeLabel setFont:[UIFont systemFontOfSize:16]];
    [threeLabel setTextColor:[UIColor colorWithHexString:@"0x717171"]];
    UILabel *fourLabel = (UILabel*)[[scrollview subviews] objectAtIndex:pageNumber+4];
    [fourLabel setFont:[UIFont systemFontOfSize:14]];
    [fourLabel setTextColor:[UIColor colorWithHexString:@"0xBABABA"]];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int y = aScrollView.contentOffset.y;
    NSInteger page = aScrollView.contentOffset.y/((self.bounds.size.height/5));
    
    if (y>2*(self.bounds.size.height/5)) {
        _curPage = [self validPageValue:_curPage+1];
        [self loadData];
    }
    if (y<=0) {
        _curPage = [self validPageValue:_curPage-1];
        [self loadData];
    }
    //    //往下翻一张
    //    if(x >= (4*self.frame.size.width)) {
    //        _curPage = [self validPageValue:_curPage+1];
    //        [self loadData];
    //    }
    //
    //    //往上翻
    //    if(x <= 0) {
    //
    //    }
    if (page>1 || page <=0) {
        [self setAfterScrollShowView:aScrollView andCurrentPage:1];
    }
    if ([_delegate respondsToSelector:@selector(scrollviewDidChangeNumber)]) {
        [_delegate scrollviewDidChangeNumber];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self setAfterScrollShowView:scrollView andCurrentPage:1];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_scrollView setContentOffset:CGPointMake(0, (self.bounds.size.height/5)) animated:YES];
    [self setAfterScrollShowView:scrollView andCurrentPage:1];
    if ([_delegate respondsToSelector:@selector(scrollviewDidChangeNumber)]) {
        [_delegate scrollviewDidChangeNumber];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self setAfterScrollShowView:scrollView andCurrentPage:1];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_scrollView setContentOffset:CGPointMake(0, (self.bounds.size.height/5)) animated:YES];
    [self setAfterScrollShowView:scrollView andCurrentPage:1];
    if ([_delegate respondsToSelector:@selector(scrollviewDidChangeNumber)]) {
        [_delegate scrollviewDidChangeNumber];
    }
}

@end

