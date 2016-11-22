//
//  ViewController.m
//  XLsn0wChooser
//
//  Created by XLsn0w on 2016/10/10.
//  Copyright © 2016年 XLsn0w. All rights reserved.
//

#import "ViewController.h"

#import "XLsn0wChooserKit.h"

static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define AdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define AdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
#define AdapationLabelFont(n) n*([[UIScreen mainScreen]bounds].size.width/375.0f)

@interface ViewController () <XLsn0wChooserDelegate, XLsn0wPickerSinglerDelegate, XLsn0wIntervalDaterDelegate, XLsn0wCenterDatePickerDelegate, XLsn0wPickerTimerDelegate>

@property (weak, nonatomic) XLsn0wCenterDatePicker *pikerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)xlsn0wChooser:(XLsn0wChooser *)xlsn0wChooser didSelectInfo:(NSDictionary *)Info{
//    [_typeBtn setTitle:[dic objectForKey:@"name"] forState:0];
    NSLog(@"%@",[Info objectForKey:@"name"]);
}

- (IBAction)show2:(id)sender {

    //x,y 值无效，默认是居中的
    XLsn0wCenterDater* picker = [[XLsn0wCenterDater alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
    
    //配置中心，详情见KSDatePikcerApperance
    
    picker.appearance.radius = 5;
    picker.appearance.cancelBtnTitleColor = [UIColor redColor];
    
    //设置回调
    picker.appearance.resultCallBack = ^void(XLsn0wCenterDater* datePicker,NSDate* currentDate,DatePickerButtonType buttonType){
        
        if (buttonType == KSDatePickerButtonCommit) {
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            [sender setTitle:[formatter stringFromDate:currentDate] forState:UIControlStateNormal];
        }
    };
    // 显示
    [picker show];
}

- (IBAction)show3:(id)sender {
    XLsn0wChooser *men=[[XLsn0wChooser alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"交易类型";
    men.delegate=self;
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"name",@"-1",@"typeID", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"现金",@"name",@"01",@"typeID", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"支付宝",@"name",@"13",@"typeID", nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"卡券",@"name",@"16",@"typeID", nil];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"刷卡",@"name",@"03",@"typeID", nil];
    NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys:@"钱包",@"name",@"15",@"typeID", nil];
    NSDictionary *dic7 = [NSDictionary dictionaryWithObjectsAndKeys:@"微信",@"name",@"12",@"typeID", nil];
    
    men.dataArray = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7, nil];
    [men show];
}
- (IBAction)Jump:(id)sender {
    

}

- (NSArray<NSString *> *)imageArray {
    return  @[@"guid01", @"guid02"];
}


- (BOOL)isShowXLsn0wGuidePager {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)singler:(id)sender {
    XLsn0wPickerSingler *singler = [[XLsn0wPickerSingler alloc] initWithArrayData:@[@"房屋问题", @"报修问题"] unitTitle:@"MB" xlsn0wDelegate:self];
    [singler show];
}


- (IBAction)dater:(id)sender {
    XLsn0wIntervalDater *datePicker = [[XLsn0wIntervalDater alloc] initWithXLsn0wDelegate:self];
    [datePicker show];
}

- (IBAction)actionsheet:(id)sender {
    NSArray *titlearr = @[@"微信朋友圈",@"微信好友",@"微信朋友圈",@"微信好友",@"微信朋友圈",@"微信好友",@"微信朋友圈",@"微信好友",@"微信朋友圈"];
    NSArray *imageArr = @[@"wechatquan",@"wechat",@"tcentQQ",@"tcentkongjian",@"wechatquan",@"wechat",@"wechatquan",@"wechat",@"tcentQQ"];
    
    XLsn0wActionSheet *actionsheet = [[XLsn0wActionSheet alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"测试" and:ShowTypeIsShareStyle];
    [actionsheet setBtnClick:^(NSInteger btnTag) {
        NSLog(@"\n点击第几个====%ld\n当前选中的按钮title====%@",btnTag,titlearr[btnTag]);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
    
    
//    NSArray *titlearr = @[@"微信朋友圈",@"微信好友",@"微信朋友圈",@"微信好友"];
//    
//    XLsn0wActionSheet *actionsheet = [[XLsn0wActionSheet alloc] initWithShareHeadOprationWith:titlearr andImageArry:@[] andProTitle:@"" and:ShowTypeIsActionSheetStyle];
//    [actionsheet setBtnClick:^(NSInteger btnTag) {
//        NSLog(@"\n点击第几行====%ld\n当前选中的按钮title====%@",btnTag,titlearr[btnTag]);
//    }];
//    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
}

- (IBAction)areaer:(id)sender {
}

- (void)pickerSingler:(XLsn0wPickerSingler *)pickerSingler selectedTitle:(NSString *)selectedTitle selectedRow:(NSInteger)selectedRow {
    NSLog(@"selectedTitle===%@", selectedTitle);
    NSLog(@"selectedRow===%ld", selectedRow);
}

- (void)intervalDater:(XLsn0wIntervalDater *)intervalDater selectedResult:(NSString *)selectedResult {
    NSLog(@"selectedResult===%@", selectedResult);
}

- (IBAction)centerDater:(id)sender {
    
    _pikerView = [XLsn0wCenterDatePicker instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = DateTypeOfStart;
    [_pikerView.datePickerView setMinimumDate:[NSDate date]];
    [self.view addSubview:_pikerView];
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    NSLog(@"%d - %@", type, date);
    
    switch (type) {
        case DateTypeOfStart:
         
            
            NSLog(@"date===%@", date);
            
            break;
            
        case DateTypeOfEnd:
             NSLog(@"date===%@", date);
            
            break;
            
        default:
            break;
    }
}

- (IBAction)AlertChooser1:(id)sender {
      [XLsn0wAlertChooser showWithTitle:@"我是标题,我可以为空" message1:@"我是消息,我也可以为空" druation:1.];
}

- (IBAction)AlertChooser2:(id)sender {
    [XLsn0wAlertChooser showWithTitle:@"我是标题,我可以为空" message1:@"我是消息,我也可以为空" cancelButton:@"取消"];
    
}

- (IBAction)AlertChooser3:(id)sender {
    [XLsn0wAlertChooser showWithTitle:@"我是标题,我可以为空" message1:@"我是消息,我也可以为空" cancelButton:@"取消" commitType:KSAlertViewButtonDelete commitAction:^(UIButton *button) {
        NSLog(@"关闭");
    }];
    
}

- (IBAction)AlertChooser4:(id)sender {
    [XLsn0wAlertChooser showWithTitle:@"我是标题,我可以为空" message1:@"我是消息,我也可以为空" cancelButton:@"取消" customButton:@"自定义按钮" commitAction:^(UIButton *button) {
        NSLog(@"关闭");
    }];
}

- (IBAction)XLsn0wChooserTimer:(id)sender {
    XLsn0wTimeChooser *timeChooser = [[XLsn0wTimeChooser alloc] initWithDatePickerMode:(DatePickerDateMode) defaultDateTime:[NSDate date]];
    [timeChooser showInSuperview:self.view];
    
    timeChooser.clickedOkBtn = ^(NSString * datetimeStr){
        NSLog(@"%@", datetimeStr);
    };
}

- (IBAction)XLsn0wImageSelector:(id)sender {
   
}

- (IBAction)pickerTimer:(id)sender {
    XLsn0wPickerTimer *pickerDate = [[XLsn0wPickerTimer alloc] init];
    pickerDate.xlsn0wDelegate = self;
    
    [pickerDate show];
}


- (void)pickerTimer:(XLsn0wPickerTimer *)pickerTimer year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSString *text = [NSString stringWithFormat:@"%ld-%ld-%ld", year, month, day];
    
    NSLog(@"%@", text);
    
}

@end
