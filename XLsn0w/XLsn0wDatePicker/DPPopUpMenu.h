//
//  DPPopUpMenu.h
//  KSDatePickerDemo
//
//  Created by IOS on 16/7/22.
//  Copyright © 2016年 孔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPPopUpMenu;

@protocol DPPopUpMenuDelegate <NSObject>
@optional
- (void)DPPopUpMenuCellDidClick:(DPPopUpMenu *)popUpMeunView withDic:(NSDictionary *)dic;

@end
@interface DPPopUpMenu : UIView
@property (nonatomic,strong) NSString *titleText;
@property (nonatomic,strong) NSArray *dataArray;
@property (weak,nonatomic) id<DPPopUpMenuDelegate>delegate;
- (void)reloadAppearance;
- (void)show;
- (void)hidden;
@end

@interface DPPopUpCell : UITableViewCell

@property (strong,nonatomic) UILabel *myTitleLabel;

@end
