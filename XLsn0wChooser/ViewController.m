//
//  ViewController.m
//  XLsn0wChooser
//
//  Created by XLsn0w on 2016/10/10.
//  Copyright © 2016年 XLsn0w. All rights reserved.
//

#import "ViewController.h"

#import "SGPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)show:(id)sender {
    SGPickerView *pickerView = [[SGPickerView alloc] init];
    pickerView.pickerViewType = SGPickerViewTypeCenter;
    [pickerView show];
    pickerView.locationMessage = ^(NSString *str){
        self.title = str;
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
