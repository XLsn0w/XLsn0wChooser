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

#import <UIKit/UIKit.h>

@class XLsn0wChooser;

@protocol XLsn0wChooserDelegate <NSObject>

@optional

- (void)xlsn0wChooser:(XLsn0wChooser *)xlsn0wChooser didSelectInfo:(NSDictionary *)Info;

@end
@interface XLsn0wChooser : UIView

@property (nonatomic,strong) NSString *titleText;
@property (nonatomic,strong) NSArray *dataArray;
@property (weak,nonatomic) id<XLsn0wChooserDelegate>delegate;
- (void)reloadAppearance;
- (void)show;
- (void)hidden;
@end

@interface XLsn0wChooserCell : UITableViewCell

@property (strong,nonatomic) UILabel *cellTitleLabel;

@end

@interface UIColor (DPUIColor)

+ (UIColor *) colorWithHexString:(NSString *)hexString;

@end

/*************************************
 
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
 
 *************************************************************/
