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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DatePickerAppearance;

@interface XLsn0wCenterDater: UIView

@property (nonatomic, strong, readonly) DatePickerAppearance *appearance;

- (void)reloadAppearance;

- (void)show;
- (void)hide;

@end

/**************************************************************************************************/

@class XLsn0wCenterDater;

typedef NS_ENUM(NSUInteger, DatePickerButtonType) {
    KSDatePickerButtonCancel = 9999,
    KSDatePickerButtonCommit,
};

typedef void (^KSDatePickerResult)(XLsn0wCenterDater* datePicker,NSDate* currentDate,DatePickerButtonType buttonType);


@interface DatePickerAppearance : NSObject

//datePicker
@property (nonatomic, strong) UIColor           * datePickerBackgroundColor;
@property (nonatomic, assign) CGFloat           radius;
@property (nonatomic, strong) UIColor           *maskBackgroundColor;
@property (nonatomic, strong) NSDate            *minimumDate;
@property (nonatomic, strong) NSDate            *maximumDate;
@property (nonatomic, strong, readwrite) NSDate *currentDate;

@property (nonatomic, assign) UIDatePickerMode  datePickerMode;

//headerView
@property (nonatomic, copy) NSString            *headerText;
@property (nonatomic, strong) UIFont            *headerTextFont;
@property (nonatomic, strong) UIColor           *headerTextColor;
@property (nonatomic, assign) NSTextAlignment   headerTextAlignment;
@property (nonatomic, strong) UIColor           *headerBackgroundColor;
@property (nonatomic, assign) CGFloat           headerHeight;

//cancelButton
@property (nonatomic, assign) CGFloat           buttonHeight;  //cancelBtn and commitBtn

@property (nonatomic, copy) NSString            *cancelBtnTitle;
@property (nonatomic, strong) UIFont            *cancelBtnFont;
@property (nonatomic, strong) UIColor           *cancelBtnTitleColor;
@property (nonatomic, strong) UIColor           *cancelBtnBackgroundColor;

//commitButton
@property (nonatomic, copy) NSString            *commitBtnTitle;
@property (nonatomic, strong) UIFont            *commitBtnFont;
@property (nonatomic, strong) UIColor           *commitBtnTitleColor;
@property (nonatomic, strong) UIColor           *commitBtnBackgroundColor;

//line
@property (nonatomic, strong) UIColor           *lineColor;
@property (nonatomic, assign) CGFloat           lineWidth;

@property (nonatomic, copy) KSDatePickerResult  resultCallBack;

@end

/*********************************************
 //x,y 值无效，默认是居中的
 XLsn0wCenterDater* picker = [[XLsn0wCenterDater alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
 
 //配置中心，详情见KSDatePikcerApperance
 
 picker.appearance.radius = 5;
 
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
 
 *****************************************************/

