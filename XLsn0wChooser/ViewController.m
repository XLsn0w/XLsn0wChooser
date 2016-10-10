//
//  ViewController.m
//  XLsn0wChooser
//
//  Created by XLsn0w on 2016/10/10.
//  Copyright © 2016年 XLsn0w. All rights reserved.
//

#import "ViewController.h"

#import "KSDatePicker.h"
#import "DPPopUpMenu.h"
static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define AdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define AdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
#define AdapationLabelFont(n) n*([[UIScreen mainScreen]bounds].size.width/375.0f)

@interface ViewController () <DPPopUpMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)DPPopUpMenuCellDidClick:(DPPopUpMenu *)popUpMeunView withDic:(NSDictionary *)dic{
//    [_typeBtn setTitle:[dic objectForKey:@"name"] forState:0];
    NSLog(@"%@",[dic objectForKey:@"name"]);
}

- (IBAction)show2:(id)sender {
    //    //x,y 值无效，默认是居中的
    KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, AdaptationW(300), AdaptationH(379))];
    
    //配置中心，详情见KSDatePikcerApperance
    
    picker.appearance.radius = 5;
    
    //设置回调
    picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
        
        if (buttonType == KSDatePickerButtonCommit || buttonType==KSDatePickerWeakButtonTag || buttonType==KSDatePickerMonthButtonTag || buttonType==KSDatePickerThreeMonthButtonTag) {
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            [sender setTitle:[formatter stringFromDate:currentDate] forState:UIControlStateNormal];
        }
    };
    // 显示
    [picker show];
}

- (IBAction)show3:(id)sender {
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
