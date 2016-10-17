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

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreen_Width/320))

#import <UIKit/UIKit.h>
#import "MXSCycleScrollView.h"

typedef enum {
    DatePickerDateMode,
    DatePickerTimeMode,
    DatePickerDateTimeMode,
    DatePickerYearMonthMode,
    DatePickerMonthDayMode,
    DatePickerHourMinuteMode,
    DatePickerDateHourMinuteMode
} DatePickerMode;

typedef void(^DatePickerCompleteAnimationBlock)(BOOL Complete);
typedef void(^ClickedOkBtn)(NSString *dateTimeStr);

@interface XLsn0wChooserTimer : UIView <MXSCycleScrollViewDatasource,MXSCycleScrollViewDelegate>
@property (nonatomic,strong) ClickedOkBtn clickedOkBtn;

@property (nonatomic,assign) DatePickerMode datePickerMode;

@property (nonatomic,assign) NSInteger maxYear;
@property (nonatomic,assign) NSInteger minYear;

-(instancetype)initWithDefaultDatetime:(NSDate*)dateTime;
-(instancetype)initWithDatePickerMode:(DatePickerMode)datePickerMode defaultDateTime:(NSDate*)dateTime;
-(void) showHcdDateTimePicker;

@end

/*
 
 #import "XLsn0wChooserTimer.h"
 
 #define kBasePadding 15
 #define kScreenWidth [UIScreen mainScreen].bounds.size.width
 #define kScreenHeight [UIScreen mainScreen].bounds.size.height
 
 @interface ViewController (){
 XLsn0wChooserTimer * dateTimePickerView;
 }
 
 @property (nonatomic, strong) UILabel *timeLbl;
 
 @end
 
 @implementation ViewController
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 // Do any additional setup after loading the view, typically from a nib.
 
 self.timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 20)];
 self.timeLbl.textAlignment = NSTextAlignmentCenter;
 self.timeLbl.font = [UIFont systemFontOfSize:14];
 [self.view addSubview:self.timeLbl];
 
 UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(kBasePadding, 100, kScreenWidth - 2*kBasePadding, 40)];
 btn1.layer.cornerRadius = 4;
 btn1.backgroundColor = [UIColor grayColor];
 [btn1 setTitle:@"YYYY-MM-DD HH:mm:ss" forState:UIControlStateNormal];
 btn1.tag = 1;
 [btn1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:btn1];
 
 UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(kBasePadding, CGRectGetMaxY(btn1.frame) + kBasePadding, kScreenWidth - 2*kBasePadding, 40)];
 btn2.layer.cornerRadius = 4;
 btn2.backgroundColor = [UIColor grayColor];
 [btn2 setTitle:@"YYYY-MM-DD" forState:UIControlStateNormal];
 btn2.tag = 2;
 [btn2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:btn2];
 
 UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(kBasePadding, CGRectGetMaxY(btn2.frame) + kBasePadding, kScreenWidth - 2*kBasePadding, 40)];
 btn3.layer.cornerRadius = 4;
 btn3.backgroundColor = [UIColor grayColor];
 [btn3 setTitle:@"HH:mm:ss" forState:UIControlStateNormal];
 btn3.tag = 3;
 [btn3 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:btn3];
 
 UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(kBasePadding, CGRectGetMaxY(btn3.frame) + kBasePadding, kScreenWidth - 2*kBasePadding, 40)];
 btn4.layer.cornerRadius = 4;
 btn4.backgroundColor = [UIColor grayColor];
 [btn4 setTitle:@"YYYY-MM" forState:UIControlStateNormal];
 btn4.tag = 4;
 [btn4 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:btn4];
 
 UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(kBasePadding, CGRectGetMaxY(btn4.frame) + kBasePadding, kScreenWidth - 2*kBasePadding, 40)];
 btn5.layer.cornerRadius = 4;
 btn5.backgroundColor = [UIColor grayColor];
 [btn5 setTitle:@"MM-DD" forState:UIControlStateNormal];
 btn5.tag = 5;
 [btn5 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:btn5];
 
 UIButton *btn6 = [[UIButton alloc]initWithFrame:CGRectMake(kBasePadding, CGRectGetMaxY(btn5.frame) + kBasePadding, kScreenWidth - 2*kBasePadding, 40)];
 btn6.layer.cornerRadius = 4;
 btn6.backgroundColor = [UIColor grayColor];
 [btn6 setTitle:@"HH:mm" forState:UIControlStateNormal];
 btn6.tag = 6;
 [btn6 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:btn6];
 
 UIButton *btn7 = [[UIButton alloc]initWithFrame:CGRectMake(kBasePadding, CGRectGetMaxY(btn6.frame) + kBasePadding, kScreenWidth - 2*kBasePadding, 40)];
 btn7.layer.cornerRadius = 4;
 btn7.backgroundColor = [UIColor grayColor];
 [btn7 setTitle:@"YYYY-MM-DD HH:mm" forState:UIControlStateNormal];
 btn7.tag = 7;
 [btn7 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:btn7];
 
 }
 
 - (void)btnClicked:(UIButton *)btn {
 NSInteger tag = btn.tag;
 
 __block ViewController *weakSelf = self;
 
 switch (tag) {
 case 1:
 dateTimePickerView = [[XLsn0wChooserTimer alloc] initWithDatePickerMode:DatePickerDateTimeMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
 [dateTimePickerView setMinYear:1990];
 [dateTimePickerView setMaxYear:2016];
 dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
 NSLog(@"%@", datetimeStr);
 weakSelf.timeLbl.text = datetimeStr;
 };
 break;
 case 2:
 dateTimePickerView = [[XLsn0wChooserTimer alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
 [dateTimePickerView setMinYear:1990];
 [dateTimePickerView setMaxYear:2016];
 dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
 NSLog(@"%@", datetimeStr);
 weakSelf.timeLbl.text = datetimeStr;
 };
 break;
 case 3:
 dateTimePickerView = [[XLsn0wChooserTimer alloc] initWithDatePickerMode:DatePickerTimeMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
 dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
 NSLog(@"%@", datetimeStr);
 weakSelf.timeLbl.text = datetimeStr;
 };
 break;
 case 4:
 dateTimePickerView = [[XLsn0wChooserTimer alloc] initWithDatePickerMode:DatePickerYearMonthMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
 dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
 NSLog(@"%@", datetimeStr);
 weakSelf.timeLbl.text = datetimeStr;
 };
 break;
 case 5:
 dateTimePickerView = [[XLsn0wChooserTimer alloc] initWithDatePickerMode:DatePickerMonthDayMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
 dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
 NSLog(@"%@", datetimeStr);
 weakSelf.timeLbl.text = datetimeStr;
 };
 break;
 case 6:
 dateTimePickerView = [[XLsn0wChooserTimer alloc] initWithDatePickerMode:DatePickerHourMinuteMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
 dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
 NSLog(@"%@", datetimeStr);
 weakSelf.timeLbl.text = datetimeStr;
 };
 break;
 case 7:
 dateTimePickerView = [[XLsn0wChooserTimer alloc] initWithDatePickerMode:DatePickerDateHourMinuteMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
 dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
 NSLog(@"%@", datetimeStr);
 weakSelf.timeLbl.text = datetimeStr;
 };
 break;
 default:
 break;
 }
 
 if (dateTimePickerView) {
 [self.view addSubview:dateTimePickerView];
 [dateTimePickerView showHcdDateTimePicker];
 }
 }

 */
