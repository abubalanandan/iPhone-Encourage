//
//  JHReportViewController.m
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHReportViewController.h"
#import "DVSwitch.h"

@interface JHReportViewController ()
@property IBOutlet UIView *sliderView;
@property IBOutlet UIImageView *bgView;
@end

@implementation JHReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DVSwitch *sliderSwitch = [DVSwitch switchWithStringsArray:@[@"SICK",@"EMOTIONAL",@"IMAGE",@"MAP"]];
    sliderSwitch.font = [UIFont boldSystemFontOfSize:10];
    [sliderSwitch setFrame:CGRectMake(0, 0, self.sliderView.bounds.size.width, self.sliderView.bounds.size.height)];
    sliderSwitch.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:60.0/255.0 alpha:1];
    sliderSwitch.sliderColor = [UIColor blueColor];
    sliderSwitch.labelTextColorInsideSlider = [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:60.0/255.0 alpha:1];
    sliderSwitch.labelTextColorOutsideSlider = [UIColor whiteColor];
    sliderSwitch.cornerRadius = 0;
    sliderSwitch.sliderOffset = 5;
    [self.sliderView addSubview:sliderSwitch];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
