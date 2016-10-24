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

#import "XLsn0wPickerDater.h"

/**
 *  2.返回一个RGBA格式的UIColor对象
 */
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/**
 *  3.返回一个RGB格式的UIColor对象
 */
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

/**
 *  4.弱引用
 */
#define STWeakSelf __weak typeof(self) weakSelf = self;

static CGFloat const PickerViewHeight = 260;
static CGFloat const PickerViewLabelWeight = 30;

@interface XLsn0wPickerDater () <UIPickerViewDataSource, UIPickerViewDelegate>

/** 1.选择器 */
@property (nonatomic, strong, nullable)UIPickerView *pickerView;

/** 3.边线 */
@property (nonatomic, strong, nullable)UIView *lineView;

@property (nonatomic, assign)NSInteger year;
@property (nonatomic, assign)NSInteger month;
@property (nonatomic, assign)NSInteger day;

@end

@implementation XLsn0wPickerDater

#pragma mark - --- init 视图初始化 ---

- (instancetype)initWithXLsn0wDelegate:(nullable id<XLsn0wPickerDaterDelegate>)xlsn0wDelegate {
    self = [self init];
    self.xlsn0wDelegate = xlsn0wDelegate;
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self drawUI];
        [self loadData];
    }
    return self;
}

- (void)drawUI {
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = RGBA(0, 0, 0, 102.0/255);
    [self.layer setOpaque:0.0];
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.lineView];
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData {
    _year  = [NSCalendar currentYear];
    _month = [NSCalendar currentMonth];
    _day   = [NSCalendar currentDay];
    
    [self initTimeIntervalArray];
    [self initSevenDaysArray];
    
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    [self.pickerView selectRow:0 inComponent:1 animated:NO];
}

- (void)initTimeIntervalArray {
    NSString *currentHourStr = @"";
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    currentHourStr = [formatter stringFromDate:[NSDate date]];
    
    NSInteger currentHour =[currentHourStr integerValue];
    
    if (currentHour >= 9 && currentHour <= 16) {
        if (currentHour == 9) {
            self.timeIntervalArray = @[@"09:00-10:00",
                                       @"10:00-11:00",
                                       @"11:00-12:00",
                                       @"12:00-13:00",
                                       @"13:00-14:00",
                                       @"14:00-15:00",
                                       @"15:00-16:00",
                                       @"16:00-17:00"];
        } else if (currentHour == 10) {
            self.timeIntervalArray = @[@"10:00-11:00",
                                       @"11:00-12:00",
                                       @"12:00-13:00",
                                       @"13:00-14:00",
                                       @"14:00-15:00",
                                       @"15:00-16:00",
                                       @"16:00-17:00"];
        } else if (currentHour == 11) {
            self.timeIntervalArray = @[@"11:00-12:00",
                                       @"12:00-13:00",
                                       @"13:00-14:00",
                                       @"14:00-15:00",
                                       @"15:00-16:00",
                                       @"16:00-17:00"];
        } else if (currentHour == 12) {
            self.timeIntervalArray = @[@"12:00-13:00",
                                       @"13:00-14:00",
                                       @"14:00-15:00",
                                       @"15:00-16:00",
                                       @"16:00-17:00"];
        } else if (currentHour == 13) {
            self.timeIntervalArray = @[@"13:00-14:00",
                                       @"14:00-15:00",
                                       @"15:00-16:00",
                                       @"16:00-17:00"];
        } else if (currentHour == 14) {
            self.timeIntervalArray = @[@"14:00-15:00",
                                       @"15:00-16:00",
                                       @"16:00-17:00"];
        } else if (currentHour == 15) {
            self.timeIntervalArray = @[@"15:00-16:00",
                                       @"16:00-17:00"];
        } else if (currentHour == 16) {
            self.timeIntervalArray = @[@"16:00-17:00"];
        }
    } else {
        self.timeIntervalArray = @[@"服务时间在9点-17点"];
    }
}

- (void)initSevenDaysArray {
    //NSString *today = [NSString stringWithFormat:@"%ld-%ld-%ld", self.year, self.month, self.day+0];
    NSString *today1 = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)self.year, (long)self.month, (long)(self.day+1)];
    NSString *today2 = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)self.year, (long)self.month, (long)(self.day+2)];
    NSString *today3 = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)self.year, (long)self.month, (long)(self.day+3)];
    NSString *today4 = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)self.year, (long)self.month, (long)(self.day+4)];
    NSString *today5 = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)self.year, (long)self.month, (long)(self.day+5)];
    NSString *today6 = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)self.year, (long)self.month, (long)(self.day+6)];
    self.sevenDaysArray = @[@"今天", today1, today2, today3, today4, today5, today6];
}

- (void)reInitTimeIntervalArray {
    self.timeIntervalArray = @[@"09:00-10:00",
                               @"10:00-11:00",
                               @"11:00-12:00",
                               @"12:00-13:00",
                               @"13:00-14:00",
                               @"14:00-15:00",
                               @"15:00-16:00",
                               @"16:00-17:00"];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.sevenDaysArray.count;
    } else {
       return self.timeIntervalArray.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return PickerViewLabelWeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    NSString *content = @"";
    if (component == 0) {
        content = [self.sevenDaysArray objectAtIndex:row];
    } else {
        content = [self.timeIntervalArray objectAtIndex:row];
    }
    
    if (!_selectedDay) {
        _selectedDay = [self.sevenDaysArray objectAtIndex:0];
    }
    
    if (!_selectedTime) {
        _selectedTime = [self.timeIntervalArray objectAtIndex:0];
    }
    
    _selectedResult = [NSString stringWithFormat:@"%@ %@", _selectedDay, _selectedTime];

    UILabel *contentLabel = [[UILabel alloc] init];
    [contentLabel setTextAlignment:NSTextAlignmentCenter];
    [contentLabel setFont:[UIFont systemFontOfSize:17]];
    [contentLabel setText:content];
    return contentLabel;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        [pickerView reloadComponent:0];
        if (row == 0) {
            [self initTimeIntervalArray];
        } else {
            [self reInitTimeIntervalArray];
        }
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        if (_selectedDay) {
            _selectedDay = [self.sevenDaysArray objectAtIndex:row];
        } else {
            _selectedDay = [self.sevenDaysArray objectAtIndex:0];
        }
        _selectedTime = [self.timeIntervalArray objectAtIndex:0];
    } else {
        [pickerView reloadComponent:0];
        [pickerView reloadComponent:1];
        
        if (_selectedTime) {
            _selectedTime = [self.timeIntervalArray objectAtIndex:row];
        } else {
            _selectedTime = [self.timeIntervalArray objectAtIndex:0];
        }
    }
    _selectedResult = [NSString stringWithFormat:@"%@ %@", _selectedDay, _selectedTime];
}

#pragma mark - --- event response 事件相应 ---

- (void)selectedOk {

    if ([self.xlsn0wDelegate respondsToSelector:@selector(pickerDater:selectedResult:)]) {
         [self.xlsn0wDelegate pickerDater:self selectedResult:_selectedResult];
    }
   
    [self remove];
}

- (void)selectedCancel {
    [self remove];
}

#pragma mark - --- private methods 私有方法 ---

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y -= PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:1];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
    }];
}

- (void)remove
{
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y += PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y += PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:0];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - --- setters 属性 ---

#pragma mark - --- getters 属性 ---

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        CGFloat pickerW = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat pickerH = PickerViewHeight - 44;
        CGFloat pickerX = 0;
        CGFloat pickerY = CGRectGetHeight([UIScreen mainScreen].bounds)+44;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        [_pickerView setDataSource:self];
        [_pickerView setDelegate:self];
    }
    return _pickerView;
}

- (XLsn0wToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[XLsn0wToolbar alloc]initWithTitle:@"请选择服务日期"
                                 cancelButtonTitle:@"取消"
                                     okButtonTitle:@"确定"
                                         addTarget:self
                                      cancelAction:@selector(selectedCancel)
                                          okAction:@selector(selectedOk)];
        _toolbar.x = 0;
        _toolbar.y = CGRectGetHeight([UIScreen mainScreen].bounds);
        _toolbar.buttonTitleColor = [UIColor whiteColor];
        _toolbar.buttonBackgroundColor = [UIColor blueColor];
    }
    return _toolbar;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
        [_lineView setBackgroundColor:RGB(205, 205, 205)];
    }
    return _lineView;
}

@end

@implementation NSCalendar (ST)

+ (NSDateComponents *)currentDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    return [calendar components:unitFlags fromDate:[NSDate date]];
}

+ (NSInteger)currentMonth
{
    return [NSCalendar currentDateComponents].month;
}

+ (NSInteger)currentYear
{
    return [NSCalendar currentDateComponents].year;
}

+ (NSInteger)currentDay
{
    return [NSCalendar currentDateComponents].day;
}

+ (NSInteger)currnentWeekday
{
    return [NSCalendar currentDateComponents].weekday;
}

+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month
{
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year%400==0 || (year%100!=0 && year%4 == 0)) {
                return 29;
            }else{
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}

+ (NSInteger)getFirstWeekdayWithYear:(NSInteger)year
                               month:(NSInteger)month
{
    NSString *stringDate = [NSString stringWithFormat:@"%ld-%ld-01", (long)year, (long)month];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy-MM-dd"];
    NSDate *date = [formatter dateFromString:stringDate];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    return [components weekday];
}

+ (NSComparisonResult)compareWithComponentsOne:(NSDateComponents *)componentsOne
                                 componentsTwo:(NSDateComponents *)componentsTwo
{
    if (componentsOne.year == componentsTwo.year &&
        componentsOne.month == componentsTwo.month &&
        componentsOne.day   == componentsTwo.day) {
        return NSOrderedSame;
    }else if (componentsOne.year < componentsTwo.year ||
              (componentsOne.year == componentsTwo.year && componentsOne.month < componentsTwo.month) ||
              (componentsOne.year == componentsTwo.year && componentsOne.month == componentsTwo.month && componentsOne.day < componentsTwo.day)) {
        return NSOrderedAscending;
    }else {
        return NSOrderedDescending;
    }
}

+ (NSMutableArray *)arrayComponentsWithComponentsOne:(NSDateComponents *)componentsOne
                                       componentsTwo:(NSDateComponents *)componentsTwo
{
    NSMutableArray *arrayComponents = [NSMutableArray array];
    
    NSString *stringOne = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)componentsOne.year, (long)componentsOne.month, (long)componentsOne.day];
    NSString *stringTwo = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)componentsTwo.year,
                           (long)componentsTwo.month,
                           (long)componentsTwo.day];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    
    NSDate *dateFromString = [dateFormatter dateFromString:stringOne];
    NSDate *dateToString = [dateFormatter dateFromString:stringTwo];
    int timediff = [dateToString timeIntervalSince1970]-[dateFromString timeIntervalSince1970];
    
    NSTimeInterval timeInterval = [dateFromString timeIntervalSinceDate:dateFromString];
    
    for (int i = 0; i <= timediff; i+=86400) {
        timeInterval = i;
        NSDate *date = [dateFromString dateByAddingTimeInterval:timeInterval];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
        [arrayComponents addObject:[calendar components:unitFlags fromDate:date]];
    }
    return arrayComponents;
}

+ (NSDateComponents *)dateComponentsWithString:(NSString *)String
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy-MM-dd"];
    NSDate *date = [formatter dateFromString:String];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    return  [calendar components:unitFlags fromDate:date];
}
@end


