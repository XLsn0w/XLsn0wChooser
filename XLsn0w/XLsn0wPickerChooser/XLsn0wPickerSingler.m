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

#import "XLsn0wPickerSingler.h"

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

static CGFloat const PickerViewHeight = 240;
static CGFloat const PickerViewLabelWeight = 200;

@interface XLsn0wPickerSingler () <UIPickerViewDataSource, UIPickerViewDelegate>

/** 1.选择器 */
@property (nonatomic, strong, nullable) UIPickerView *pickerView;

/** 3.边线 */
@property (nonatomic, strong, nullable) UIView *lineView;
/** 4.选中的字符串 */
@property (nonatomic, strong, nullable) NSString *selectedTitle;

@property (nonatomic, assign) NSInteger selectedRow;

@end

@implementation XLsn0wPickerSingler

#pragma mark - --- init 视图初始化 ---

- (instancetype)initWithArrayData:(NSArray<NSString *>*)arrayData
                        unitTitle:(NSString *)unitTitle
                   xlsn0wDelegate:(nullable id<XLsn0wPickerSinglerDelegate>)xlsn0wDelegate {
    self.arrayData = arrayData.mutableCopy;
    self.unitTitle = unitTitle;
    
    self = [self init];
    self.xlsn0wDelegate = xlsn0wDelegate;
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = RGBA(0, 0, 0, 102.0/255);
    [self.layer setOpaque:0.0];
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.lineView];
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 1;
    }else if (component == 1){
        return self.arrayData.count;
    }else {
        return 1;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 36;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return ([UIScreen mainScreen].bounds.size.width-PickerViewLabelWeight)/2;
    }else if (component == 1){
        return PickerViewLabelWeight;
    }else {
        return ([UIScreen mainScreen].bounds.size.width-PickerViewLabelWeight)/2;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedTitle = self.arrayData[row];
    _selectedRow = row;
    [self.toolbar setTitle:[NSString stringWithFormat:@"%@ %@", self.selectedTitle, self.unitTitle]];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    if (component == 0) {
        return nil;
    }else if (component == 1){
        UILabel *label = [[UILabel alloc]init];
        [label setText:self.arrayData[row]];
        [label setTextAlignment:NSTextAlignmentCenter];
        return label;
    }else {
        UILabel *label = [[UILabel alloc]init];
        [label setText:self.unitTitle];
        [label setTextAlignment:NSTextAlignmentLeft];
        return label;
    }
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk {
    [self.xlsn0wDelegate pickerSingler:self selectedTitle:self.selectedTitle selectedRow:_selectedRow];
    [self remove];
}

- (void)selectedCancel
{
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

- (void)setArrayData:(NSMutableArray<NSString *> *)arrayData
{
    _arrayData = arrayData;
    _selectedTitle = arrayData.firstObject;
    [self.pickerView reloadAllComponents];
}

- (void)setUnitTitle:(NSString *)unitTitle {
    _unitTitle = unitTitle;
    [self.pickerView reloadAllComponents];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.toolbar.title = title;
}
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
        _toolbar = [[XLsn0wToolbar alloc]initWithTitle:@"请选择"
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
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 0.5)];
        [_lineView setBackgroundColor:RGB(205, 205, 205)];
    }
    return _lineView;
}

@end

