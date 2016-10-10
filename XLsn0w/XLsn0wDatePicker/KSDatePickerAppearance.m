//
//  KSDatePickerAppearance.m
//  Bespeak
//
//  Created by kong on 16/3/4.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "KSDatePickerAppearance.h"
static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define AdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define AdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
#define AdapationLabelFont(n) n*([[UIScreen mainScreen]bounds].size.width/375.0f)
@implementation KSDatePickerAppearance

- (instancetype)init
{
    if (self = [super init]) {
        
        [self defultValue];
        
    }
    return self;
}

- (void)defultValue
{
    _datePickerBackgroundColor = [UIColor whiteColor];
    _radius = 0.;
    _maskBackgroundColor = [UIColor blackColor];
    
    _currentDate = [NSDate date];
    
    _datePickerMode = UIDatePickerModeDate;
    
    _headerText = @"快速选择";
    _headerTextColor = [UIColor whiteColor];
    _headerTextFont = [UIFont boldSystemFontOfSize:15];
    _headerBackgroundColor = [UIColor colorWithHexString:@"#e85352"];
    _headerTextAlignment = NSTextAlignmentCenter;
    _headerHeight =AdaptationH(44) ;
    
    _buttonHeight = AdaptationH(44);
    
    _commitBtnTitle = @"确定";
    _commitBtnFont = [UIFont boldSystemFontOfSize:AdapationLabelFont(15)];
    _commitBtnTitleColor = [UIColor whiteColor];
    _commitBtnBackgroundColor = [UIColor colorWithHexString:@"#e85352"];
    
    _cancelBtnTitle = @"取消";
    _cancelBtnFont = [UIFont boldSystemFontOfSize:AdapationLabelFont(15)];
    _cancelBtnTitleColor = [UIColor whiteColor];
    _cancelBtnBackgroundColor = [UIColor colorWithHexString:@"#e85352"];
    
    _lineColor = [UIColor whiteColor];
    _lineWidth =AdaptationH(1);
    
}
@end
