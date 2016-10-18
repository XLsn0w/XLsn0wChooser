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

typedef enum {
    ShowTypeIsShareStyle = 0,  //9宫格类型的  适合分享按钮
    ShowTypeIsActionSheetStyle  //类似系统的actionsheet的类型
} ShowType;

@interface XLsn0wActionSheet : UIView

//点击按钮block回调
@property (nonatomic,copy) void(^btnClick)(NSInteger);

//头部提示文字
@property (nonatomic,copy) NSString *proStr;

//头部提示文字的字体大小
@property (nonatomic,assign) NSInteger proFont;

//取消按钮的颜色
@property (nonatomic,strong) UIColor *cancelBtnColor;

//取消按钮的字体大小
@property (nonatomic,assign) NSInteger cancelBtnFont;

//除了取消按钮其他按钮的颜色
@property (nonatomic,strong) UIColor *otherBtnColor;

//除了取消按钮其他按钮的字体大小
@property (nonatomic,assign) NSInteger otherBtnFont;

//设置弹窗背景蒙板灰度(0~1)
@property (nonatomic,assign) CGFloat duration;

/**
 *  初始化actionView
 *
 *  @param titleArray 标题数组
 *  @param imageArr   图片数组(如果不需要的话传空数组(@[])进来)
 *  @param protitle   最顶部的标题  不需要的话传@""
 *  @param type       两种弹出类型(枚举)
 *
 *  @return wu
 */

- (id)initWithShareHeadOprationWith:(NSArray *)titleArray andImageArry:(NSArray *)imageArr andProTitle:(NSString *)protitle and:(ShowType)type;

@end

@interface ActionButton : UIButton

@end

@interface VerButton : UIButton

@property (nonatomic,strong) UIView *lineView;

@end


/*
 
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
 
 */






