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

#import "XLsn0wAlertChooser.h"

//屏幕尺寸
#define KSFullScreen [UIScreen mainScreen].bounds
//AlertViewWidth
#define KSAlertWidth (KSFullScreen.size.width - 2 *40)
//按钮默认高度
#define KSAlertBtnHeight (44)

@interface XLsn0wAlertChooser ()
/** 配置中心 */
//@property (nonatomic, strong) KSAlertAppearance* appearance;

@property (nonatomic, strong) UIWindow* window;

@property (nonatomic, strong) UIView* alertView;

@end

@implementation XLsn0wAlertChooser
{
    UILabel* _titleLabel;
    UILabel* _message1Label;
    
    UIButton* _cancelButton;
    UIButton* _commitButton;
    
    UIView* _horizontalLine;
    UIView* _verticalLine;
    
    NSTimeInterval _druation;
}

- (void)show{
    
    [self.window becomeKeyWindow];
    [self.window makeKeyAndVisible];
    [self.window addSubview:self];
    
    [self setShowAnimation];
}
- (void)dismiss{
    
    [self.window resignKeyWindow];

    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];

    [[UIApplication sharedApplication].delegate.window becomeKeyWindow];

    [self removeFromSuperview];
}

- (instancetype)initWithTitle:(NSString *)title message1:(NSString *)message1 cancelButton:(NSString*)cancelTitle commitButton:(NSString*)commitTitle commitAction:(CommitAction)commitAction druation:(NSTimeInterval)druation{

    if (self = [super init]) {
//        {
//            //初始化配置
//            self.appearance = [[KSAlertAppearance alloc] init];
//        }
        
        {
            //初始化窗体
            self.window = [[UIWindow alloc] initWithFrame:KSFullScreen];
            self.window.windowLevel = UIWindowLevelAlert;
        }
        
        {
            //背景区域
            self.backgroundColor = [XLsn0wAlertChooser appearances].KSAlertMaskViewColor;
            self.frame = KSFullScreen;
            self.userInteractionEnabled = YES;
        }
        
        {
            //显示区域
            self.alertView = [[UIView alloc] init];
            self.alertView.backgroundColor = [XLsn0wAlertChooser appearances].KSAlertViewColor;
            self.alertView.userInteractionEnabled = YES;
            [self addSubview:self.alertView];
        }
        
        {
            //title
            if (title) {
                _titleLabel = [[UILabel alloc] init];
                [self.alertView addSubview:_titleLabel];

                _titleLabel.numberOfLines = 0;
                _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:title attributes:[XLsn0wAlertChooser appearances].KSAlertTitleAttributed];
            }
        }
        
        {
            //message1
            if (message1) {
                _message1Label = [[UILabel alloc] init];
                
                _message1Label.numberOfLines = 0;
                _message1Label.attributedText = [[NSAttributedString alloc] initWithString:message1 attributes:[XLsn0wAlertChooser appearances].KSAlertMessage1Attributed];
                [self.alertView addSubview:_message1Label];
            }
        }
        
        {
            //cancelButton
            if (cancelTitle) {
                _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _cancelButton.backgroundColor = KSColor(240, 240, 240);

                [_cancelButton setAttributedTitle:[[NSAttributedString alloc] initWithString:cancelTitle attributes:[XLsn0wAlertChooser appearances].KSAlertCancelTitleAttributed] forState:UIControlStateNormal];
                [_cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
                [self.alertView addSubview:_cancelButton];
            }
        }

        {
            //commitButton
            if (commitTitle) {
                _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _commitButton.backgroundColor = KSColor(240, 240, 240);
                
                if ([commitTitle isEqualToString:@"删除"]) {
                    [_commitButton setAttributedTitle:[[NSAttributedString alloc] initWithString:commitTitle attributes:[XLsn0wAlertChooser appearances].KSAlertCommitTitleAttributed] forState:UIControlStateNormal];
                }else{
                    [_commitButton setAttributedTitle:[[NSAttributedString alloc] initWithString:commitTitle attributes:[XLsn0wAlertChooser appearances].KSAlertCustomTitleAttributed] forState:UIControlStateNormal];
                }
                
                [_commitButton handleControlEvent:UIControlEventTouchUpInside withBlock:commitAction];
                [_commitButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
                [self.alertView addSubview:_commitButton];
            }
        }
        
        {
            //水平分割线
            if (cancelTitle || commitTitle) {
                _horizontalLine = [[UIView alloc] init];
                _horizontalLine.backgroundColor = [XLsn0wAlertChooser appearances].horizontalLineColor;
                [self.alertView addSubview:_horizontalLine];
            }
            //垂直分割线
            if (commitTitle) {
                _verticalLine = [[UIView alloc] init];
                _verticalLine.backgroundColor = [XLsn0wAlertChooser appearances].verticalLineColor;
                [self.alertView addSubview:_verticalLine];
            }
        }
        
        {
            //alertView
            self.alertView.layer.cornerRadius = [XLsn0wAlertChooser appearances].KSAlertViewCornerRadius;
            self.alertView.layer.masksToBounds = YES;
        }
        
        {
            //保存变量
            _druation = druation;
        }
    }
    return self;
}

- (void)layoutSubviews{
    
    CGFloat topMargin = [XLsn0wAlertChooser appearances].KSAlertViewPadding.top;
    CGFloat leftMargin = [XLsn0wAlertChooser appearances].KSAlertViewPadding.left;
    CGFloat rightMargin = [XLsn0wAlertChooser appearances].KSAlertViewPadding.right;
    CGFloat height = 0;
    
    if (_titleLabel) {
        CGFloat titleX = leftMargin;
        CGFloat titleY = topMargin;
        CGFloat titleW = KSAlertWidth - leftMargin - rightMargin;
        CGFloat titleH = _titleLabel.frame.size.height;
        _titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
        [_titleLabel sizeToFit];
        _titleLabel.center = CGPointMake(KSAlertWidth / 2, _titleLabel.center.y);
        
        height = CGRectGetMaxY(_titleLabel.frame) + 30;
        
    }
    
    if (_message1Label) {
        CGFloat message1X = leftMargin;
        CGFloat message1Y = CGRectGetMaxY(_titleLabel.frame) + [XLsn0wAlertChooser appearances].KSAlertMessage1TopMargin;
        CGFloat message1W = KSAlertWidth - leftMargin - rightMargin;
        CGFloat message1H = _message1Label.frame.size.height;
        _message1Label.frame = CGRectMake(message1X, message1Y, message1W, message1H);
        [_message1Label sizeToFit];
        _message1Label.center = CGPointMake(KSAlertWidth / 2, _message1Label.center.y);
        
        height = CGRectGetMaxY(_message1Label.frame) + 30;
    }
    
    if (_cancelButton && (!_commitButton)) {
        CGFloat cancelBtnX = 0;
        CGFloat cancelBtnY = height;
        CGFloat cancelBtnW = KSAlertWidth;
        CGFloat cancelBtnH = KSAlertBtnHeight;
        _cancelButton.frame = CGRectMake(cancelBtnX, cancelBtnY, cancelBtnW, cancelBtnH);
    }
    
    if ((!_cancelButton) && _commitButton) {
        CGFloat commitBtnX = 0;
        CGFloat commitBtnY = height;
        CGFloat commitBtnW = KSAlertWidth;
        CGFloat commitBtnH = KSAlertBtnHeight;
        _commitButton.frame = CGRectMake(commitBtnX, commitBtnY, commitBtnW, commitBtnH);
    }
    
    if (_cancelButton && _commitButton) {
        
        CGFloat cancelBtnX = 0;
        CGFloat cancelBtnY = height;
        CGFloat cancelBtnW = KSAlertWidth / 2;
        CGFloat cancelBtnH = KSAlertBtnHeight;
        _cancelButton.frame = CGRectMake(cancelBtnX, cancelBtnY, cancelBtnW, cancelBtnH);
        
        CGFloat commitBtnX = cancelBtnW;
        CGFloat commitBtnY = cancelBtnY;
        CGFloat commitBtnW = cancelBtnW;
        CGFloat commitBtnH = KSAlertBtnHeight;
        _commitButton.frame = CGRectMake(commitBtnX, commitBtnY, commitBtnW, commitBtnH);
        
        CGFloat verticalX = cancelBtnW;
        CGFloat verticalY = height + 13;
        CGFloat verticalW = 0.5;
        CGFloat verticalH = KSAlertBtnHeight - 26;
        _verticalLine.frame = CGRectMake(verticalX, verticalY, verticalW, verticalH);
    }
    
    if (_cancelButton || _commitButton) {
        CGFloat horizontalX = 0;
        CGFloat horizontalY = height;
        CGFloat horizontalW = KSAlertWidth;
        CGFloat horizontalH = 0.5;
        _horizontalLine.frame = CGRectMake(horizontalX, horizontalY, horizontalW, horizontalH);
        
        height += KSAlertBtnHeight;
    }
    
    self.alertView.frame = CGRectMake(0, 0, KSAlertWidth, height);
    self.alertView.center = self.center;

}

+ (KSAlertAppearance *)appearances{
    
    static KSAlertAppearance* appearance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         appearance = [[KSAlertAppearance alloc] init];
    });
    
    return appearance;
}

- (void)setShowAnimation{
    switch ([XLsn0wAlertChooser appearances].KSAlertAnimationStyle) {
        case KSAlertAnimationStyleDefault:
        {
            CGPoint startPoint = CGPointMake(self.center.x, -_alertView.frame.size.height);
            _alertView.layer.position=startPoint;
            
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                _alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
                if (_druation) {
                    [UIView animateWithDuration:.25 delay:_druation options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.alpha = 0;
                    } completion:^(BOOL finished) {
                        [self dismiss];
                    }];
                }
            }];
        }
            break;
    }
}

+ (void)showWithTitle:(NSString*)title message1:(NSString*)message1 druation:(NSTimeInterval)druation{
    
    XLsn0wAlertChooser* alertView = [[XLsn0wAlertChooser alloc] initWithTitle:title message1:message1 cancelButton:nil commitButton:nil commitAction:NULL druation:druation];
    
    [alertView show];
    
}


+ (void)showWithTitle:(NSString*)title message1:(NSString*)message1 cancelButton:(NSString*)cancelTitle{
    
    XLsn0wAlertChooser* alertView = [[XLsn0wAlertChooser alloc] initWithTitle:title message1:message1 cancelButton:cancelTitle commitButton:nil commitAction:NULL  druation:0];
    
    [alertView show];
}

+ (void)showWithTitle:(NSString*)title message1:(NSString*)message1 cancelButton:(NSString*)cancelTitle customButton:(NSString*)commitTitle commitAction:(CommitAction)commitAction{
    
    XLsn0wAlertChooser* alertView = [[XLsn0wAlertChooser alloc] initWithTitle:title message1:message1 cancelButton:cancelTitle commitButton:commitTitle commitAction:commitAction druation:0];
    
    [alertView show];
}

+ (void)showWithTitle:(NSString *)title message1:(NSString *)message1 cancelButton:(NSString *)cancelTitle commitType:(KSAlertViewButtonType )type commitAction:(CommitAction)commitAction{
    
    NSString* commitTitle = (type == 0)?@"确定":@"删除";
    
    XLsn0wAlertChooser* alertView = [[XLsn0wAlertChooser alloc] initWithTitle:title message1:message1 cancelButton:cancelTitle commitButton:commitTitle commitAction:commitAction druation:0];
    
    [alertView show];
}

@end


@implementation UIButton (block)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(CommitAction)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

- (void)callActionBlock:(id)sender {
    CommitAction block = (CommitAction)objc_getAssociatedObject(self, &overviewKey);
    
    if (block) {
        __weak typeof(self) weakSelf = self;
        block(weakSelf);
    }
}

@end

/**************************************************************************************************/

@implementation KSAlertAppearance

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /** alertView*/
        self.KSAlertMaskViewColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.KSAlertViewPadding = UIEdgeInsetsMake(30, 20, 30, 20);
        self.KSAlertViewColor = [UIColor whiteColor];
        self.KSAlertViewCornerRadius = 4.;
        
        /** title*/
        NSMutableParagraphStyle* titleStyle = [[NSMutableParagraphStyle alloc] init];
        titleStyle.lineSpacing = 5;
        titleStyle.alignment = NSTextAlignmentCenter;
        
        self.KSAlertTitleAttributed = @{
                                        NSFontAttributeName:[UIFont systemFontOfSize:17],
                                        NSForegroundColorAttributeName:KSColor(45, 43, 51),
                                        NSParagraphStyleAttributeName:titleStyle,
                                        };
        
        /** message1*/
        NSMutableParagraphStyle* message1Style = [[NSMutableParagraphStyle alloc] init];
        message1Style.lineSpacing = 5;
        message1Style.alignment = NSTextAlignmentCenter;
        
        self.KSAlertMessage1Attributed = @{
                                           NSFontAttributeName:[UIFont systemFontOfSize:17],
                                           NSForegroundColorAttributeName:KSColor(155, 155, 155),
                                           NSParagraphStyleAttributeName:message1Style
                                           };
        self.KSAlertMessage1TopMargin  = 15.;
        
        /** line*/
        self.horizontalLineColor = [UIColor clearColor];
        self.verticalLineColor = KSColor(159,157,166);
        
        /** cancelTitle*/
        self.KSAlertCancelTitleAttributed = @{
                                              NSFontAttributeName:[UIFont systemFontOfSize:17],
                                              NSForegroundColorAttributeName:KSColor(159,157,166)
                                              };
        
        /** customTitle*/
        self.KSAlertCustomTitleAttributed = @{
                                              NSFontAttributeName:[UIFont systemFontOfSize:17],
                                              NSForegroundColorAttributeName:KSColor(0, 145, 255)
                                              };
        
        /** deleteTitle*/
        self.KSAlertCommitTitleAttributed = @{
                                              NSFontAttributeName:[UIFont systemFontOfSize:17],
                                              NSForegroundColorAttributeName:KSColor(255, 100, 0)
                                              };
        /** Animation*/
        self.KSAlertAnimationStyle = KSAlertAnimationStyleDefault;
        
    }
    return self;
}
@end
