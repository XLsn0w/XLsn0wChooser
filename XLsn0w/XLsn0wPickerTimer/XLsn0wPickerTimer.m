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

#import "XLsn0wPickerTimer.h"

/** 1.统一的较小间距 5*/
CGFloat const STMarginSmall = 5;

/** 2.统一的间距 10*/
CGFloat const STMargin = 10;

/** 3.统一的较大间距 16*/
CGFloat const STMarginBig = 16;

/** 4.导航栏的最大的Y值 64*/
CGFloat const STNavigationBarY = 64;

/** 5.控件的系统高度 44*/
CGFloat const STControlSystemHeight = 44;

/** 6.控件的普通高度 36*/
CGFloat const STControlNormalHeight = 36;


@interface XLsn0wPickerTimer () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign)NSInteger year;
@property (nonatomic, assign)NSInteger month;
@property (nonatomic, assign)NSInteger day;

@end

@implementation XLsn0wPickerTimer

#pragma mark - --- init 视图初始化 ---

- (void)overrideInit {
    self.title = @"请选择日期";
    
    _yearLeast = 1900;
    _yearSum   = 200;
    _heightPickerComponent = 28;
    
    _year  = [NSCalendar currentYear];
    _month = [NSCalendar currentMonth];
    _day   = [NSCalendar currentDay];
    
    [self.pickerView setDataSource:self];
    [self.pickerView setDelegate:self];
    
    [self.pickerView selectRow:(_year - _yearLeast) inComponent:0 animated:NO];
    [self.pickerView selectRow:(_month - 1) inComponent:1 animated:NO];
    [self.pickerView selectRow:(_day - 1) inComponent:2 animated:NO];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearSum;
    }else if(component == 1) {
        return 12;
    }else {
        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.yearLeast;
        NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;
        return  [NSCalendar getDaysWithYear:yearSelected month:monthSelected];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            break;
        case 1:
            [pickerView reloadComponent:2];
        default:
            break;
    }
    
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    NSString *text;
    if (component == 0) {
        text =  [NSString stringWithFormat:@"%ld", (long)(row + 1900)];
    }else if (component == 1){
        text =  [NSString stringWithFormat:@"%ld", (long)(row + 1)];
    }else{
        text = [NSString stringWithFormat:@"%ld", (long)(row + 1)];
    }

    UILabel *contentLabel = [[UILabel alloc]init];
    [contentLabel setTextAlignment:NSTextAlignmentCenter];
    [contentLabel setFont:[UIFont systemFontOfSize:17]];
    [contentLabel setText:text];
    
    return contentLabel;
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk {
    if ([self.xlsn0wDelegate respondsToSelector:@selector(pickerTimer:year:month:day:)]) {
        [self.xlsn0wDelegate pickerTimer:self year:self.year month:self.month day:self.day];
    }
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData {
    self.year  = [self.pickerView selectedRowInComponent:0] + self.yearLeast;
    self.month = [self.pickerView selectedRowInComponent:1] + 1;
    self.day   = [self.pickerView selectedRowInComponent:2] + 1;
}

#pragma mark - --- setters 属性 ---

- (void)setYearLeast:(NSInteger)yearLeast {
    _yearLeast = yearLeast;
}

- (void)setYearSum:(NSInteger)yearSum {
    _yearSum = yearSum;
}
#pragma mark - --- getters 属性 ---


@end

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

@implementation XLsn0wPickerButton

#pragma mark - --- init 视图初始化 ---
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupDefault];
        [self overrideInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        [self setupDefault];
        [self overrideInit];
    }
    return self;
}

- (void)setupDefault {
    // 1.设置数据的默认值
    _title             = nil;
    _font              = [UIFont systemFontOfSize:15];
    _titleColor        = [UIColor whiteColor];
    _borderButtonColor = RGB(205, 205, 205);
    _heightPicker      = 240;
    _xlsn0wPickerButtonLocation = XLsn0wPickerButtonLocationBottom;
    
    // 2.设置自身的属性
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = RGBA(0, 0, 0, 102.0/255);
    self.layer.opacity = 0.0;
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.添加子视图
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.pickerView];
    [self.contentView addSubview:self.buttonLeft];
    [self.contentView addSubview:self.buttonRight];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.lineViewDown];
}

//子类可重写此方法
- (void)overrideInit {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.xlsn0wPickerButtonLocation == XLsn0wPickerButtonLocationBottom) {
    }else {
        self.buttonLeft.y = self.lineViewDown.bottom + STMarginSmall;
        self.buttonRight.y = self.lineViewDown.bottom + STMarginSmall;
    }
}

#pragma mark - --- event response 事件相应 ---

- (void)selectedOk {
    [self remove];
}

- (void)selectedCancel {
    [self remove];
}

#pragma mark - --- private methods 私有方法 ---

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    if (self.xlsn0wPickerButtonLocation == XLsn0wPickerButtonLocationBottom) {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y -= self.contentView.height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
        }];
    }else {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y -= (ScreenHeight+self.contentView.height)/2;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)remove {
    if (self.xlsn0wPickerButtonLocation == XLsn0wPickerButtonLocationBottom) {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += self.contentView.height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += (ScreenHeight+self.contentView.height)/2;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

#pragma mark - --- setters 属性 ---

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.labelTitle setText:title];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self.buttonLeft.titleLabel setFont:font];
    [self.buttonRight.titleLabel setFont:font];
    [self.labelTitle setFont:font];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self.labelTitle setTextColor:titleColor];
    [self.buttonLeft setTitleColor:titleColor forState:UIControlStateNormal];
    [self.buttonRight setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setBorderButtonColor:(UIColor *)borderButtonColor {
    _borderButtonColor = borderButtonColor;
    [self.buttonLeft addBorderColor:borderButtonColor];
    [self.buttonRight addBorderColor:borderButtonColor];
}

- (void)setHeightPicker:(CGFloat)heightPicker {
    _heightPicker = heightPicker;
    self.contentView.height = heightPicker;
}

- (void)setXlsn0wPickerButtonLocation:(XLsn0wPickerButtonLocation)xlsn0wPickerButtonLocation {
    _xlsn0wPickerButtonLocation = xlsn0wPickerButtonLocation;
    if (xlsn0wPickerButtonLocation == XLsn0wPickerButtonLocationCenter) {
        self.contentView.height += STControlSystemHeight;
    }
}

#pragma mark - --- getters 属性 ---
- (UIView *)contentView {
    if (!_contentView) {
        CGFloat contentX = 0;
        CGFloat contentY = ScreenHeight;
        CGFloat contentW = ScreenWidth;
        CGFloat contentH = self.heightPicker;
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return _contentView;
}

- (UIView *)lineView {
    if (!_lineView) {
        CGFloat lineX = 0;
        CGFloat lineY = STControlSystemHeight;
        CGFloat lineW = self.contentView.width;
        CGFloat lineH = 0.5;
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        [_lineView setBackgroundColor:self.borderButtonColor];
    }
    return _lineView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        CGFloat pickerW = self.contentView.width;
        CGFloat pickerH = self.contentView.height - self.lineView.bottom;
        CGFloat pickerX = 0;
        CGFloat pickerY = self.lineView.bottom;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _pickerView;
}

- (UIButton *)buttonLeft {
    if (!_buttonLeft) {
        CGFloat leftW = STControlSystemHeight+10;
        CGFloat leftH = self.lineView.top - STMargin;
        CGFloat leftX = STMarginBig;
        CGFloat leftY = (self.lineView.top - leftH) / 2;
        _buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(leftX, leftY, leftW, leftH)];
        [_buttonLeft setTitle:@"取消" forState:UIControlStateNormal];
        [_buttonLeft setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_buttonLeft addBorderColor:self.borderButtonColor];
        _buttonLeft.backgroundColor = [UIColor blueColor];
        [_buttonLeft.titleLabel setFont:self.font];
        [_buttonLeft addTarget:self action:@selector(selectedCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonLeft;
}

- (UIButton *)buttonRight {
    if (!_buttonRight) {
        CGFloat rightW = self.buttonLeft.width;
        CGFloat rightH = self.buttonLeft.height;
        CGFloat rightX = self.contentView.width - rightW - self.buttonLeft.x;
        CGFloat rightY = self.buttonLeft.y;
        _buttonRight = [[UIButton alloc]initWithFrame:CGRectMake(rightX, rightY, rightW, rightH)];
        [_buttonRight setTitle:@"确定" forState:UIControlStateNormal];
        [_buttonRight setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_buttonRight addBorderColor:self.borderButtonColor];
        _buttonRight.backgroundColor = [UIColor blueColor];
        [_buttonRight.titleLabel setFont:self.font];
        [_buttonRight addTarget:self action:@selector(selectedOk) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonRight;
}

- (UILabel *)labelTitle {
    if (!_labelTitle) {
        CGFloat titleX = self.buttonLeft.right + STMarginSmall;
        CGFloat titleY = 0;
        CGFloat titleW = self.contentView.width - titleX * 2;
        CGFloat titleH = self.lineView.top;
        _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        [_labelTitle setTextAlignment:NSTextAlignmentCenter];
        [_labelTitle setTextColor:[UIColor blackColor]];
        [_labelTitle setFont:self.font];
        _labelTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _labelTitle;
}

- (UIView *)lineViewDown {
    if (!_lineViewDown) {
        CGFloat lineX = 0;
        CGFloat lineY = self.pickerView.bottom;
        CGFloat lineW = self.contentView.width;
        CGFloat lineH = 0.5;
        _lineViewDown = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        [_lineViewDown setBackgroundColor:self.borderButtonColor];
    }
    return _lineViewDown;
}
@end



@implementation NSCalendar (XLsn0wPickerTimerCalendar)

+ (NSDateComponents *)currentDateComponents {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    return [calendar components:unitFlags fromDate:[NSDate date]];
}

+ (NSInteger)currentMonth {
    return [NSCalendar currentDateComponents].month;
}

+ (NSInteger)currentYear {
    return [NSCalendar currentDateComponents].year;
}

+ (NSInteger)currentDay {
    return [NSCalendar currentDateComponents].day;
}

+ (NSInteger)currnentWeekday {
    return [NSCalendar currentDateComponents].weekday;
}

+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month {
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
                               month:(NSInteger)month {
    NSString *stringDate = [NSString stringWithFormat:@"%ld-%ld-01", (long)year, (long)month];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy-MM-dd"];
    NSDate *date = [formatter dateFromString:stringDate];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    return [components weekday];
}

+ (NSComparisonResult)compareWithComponentsOne:(NSDateComponents *)componentsOne
                                 componentsTwo:(NSDateComponents *)componentsTwo {
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
                                       componentsTwo:(NSDateComponents *)componentsTwo {
    NSMutableArray *arrayComponents = [NSMutableArray array];
    
    NSString *stringOne = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)componentsOne.year, (long)componentsOne.month, (long)componentsOne.day];
    NSString *stringTwo = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)componentsTwo.year, (long)componentsTwo.month, (long)componentsTwo.day];
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

+ (NSDateComponents *)dateComponentsWithString:(NSString *)String {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy-MM-dd"];
    NSDate *date = [formatter dateFromString:String];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    return  [calendar components:unitFlags fromDate:date];
}

@end

@implementation UIView (XLsn0wPickerTimerView)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (UIView * (^)(CGFloat x))setX
{
    return ^(CGFloat x) {
        self.x = x;
        return self;
    };
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (UIView *(^)(UIColor *color)) setColor
{
    return ^ (UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(CGRect frame)) setFrame
{
    return ^ (CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGSize size)) setSize
{
    return ^ (CGSize size) {
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        return self;
    };
}

- (UIView *(^)(CGPoint point)) setCenter
{
    return ^ (CGPoint point) {
        self.center = point;
        return self;
    };
}

- (UIView *(^)(NSInteger tag)) setTag
{
    return ^ (NSInteger tag) {
        self.tag = tag;
        return self;
    };
}

- (void)addTarget:(id)target
           action:(SEL)action;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target
                                                                         action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)addBorderColor:(UIColor *)color{
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:0.5];
    [self.layer setCornerRadius:4];
}

@end

