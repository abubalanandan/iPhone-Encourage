//
//  JHReportViewController.m
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHReportViewController.h"
#import "DVSwitch.h"
#import "JHReportPageOne.h"
#import "JHReportPageTwo.h"
#import "JHReportPageThree.h"
#import "JHReportPageFour.h"

@interface JHReportViewController ()
@property IBOutlet UIView *sliderView;
@property IBOutlet UIImageView *bgView;
@property IBOutlet UIScrollView *containerScrollView;

@property DVSwitch *sliderSwitch;
@end

@implementation JHReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _sliderSwitch = [DVSwitch switchWithStringsArray:@[@"SICK",@"EMOTIONAL",@"IMAGE",@"MAP"]];
    _sliderSwitch.font = [UIFont boldSystemFontOfSize:10];
    [_sliderSwitch setFrame:CGRectMake(0, 0, self.sliderView.bounds.size.width, self.sliderView.bounds.size.height)];
    _sliderSwitch.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:60.0/255.0 alpha:1];
    _sliderSwitch.sliderColor = [UIColor blueColor];
    _sliderSwitch.labelTextColorInsideSlider = [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:60.0/255.0 alpha:1];
    _sliderSwitch.labelTextColorOutsideSlider = [UIColor whiteColor];
    _sliderSwitch.cornerRadius = 0;
    _sliderSwitch.sliderOffset = 5;
    [_sliderSwitch setWillBePressedHandler:^(NSUInteger index) {
        [self scrollToSelectedIndex:index];
    }];
    [self.sliderView addSubview:_sliderSwitch];
    
    [self addPagesToContainer];
}

#pragma mark -
#pragma mark - DVSwitch Methods

- (void)changeSegmentedControlToIndex:(int)index {
    [_sliderSwitch forceSelectedIndex:index animated:YES];
}

#pragma mark -
#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int newPageNumber = floor(scrollView.contentOffset.x/320.0);
    [self changeSegmentedControlToIndex:newPageNumber];
}

- (void)addPagesToContainer {
    
    JHReportPageOne *pageOne = [[JHReportPageOne alloc] init];
    JHReportPageTwo *pageTwo = [[JHReportPageTwo alloc] init];
    JHReportPageThree *pageThree = [[JHReportPageThree alloc] init];
    JHReportPageFour *pageFour = [[JHReportPageFour alloc] init];
    
    [self addChildViewController:pageOne];
    [self addChildViewController:pageTwo];
    [self addChildViewController:pageThree];
    [self addChildViewController:pageFour];
    
    [self.containerScrollView setContentSize:CGSizeMake(1280, 428)];
    [self.containerScrollView addSubview:[self setFrameForView:pageOne.view atIndex:0]];
    [self.containerScrollView addSubview:[self setFrameForView:pageTwo.view atIndex:1]];
    [self.containerScrollView addSubview:[self setFrameForView:pageThree.view atIndex:2]];
    [self.containerScrollView addSubview:[self setFrameForView:pageFour.view atIndex:3]];
    
    self.containerScrollView.pagingEnabled = YES;
}

- (void)scrollToSelectedIndex:(NSUInteger)index {
    [self.containerScrollView setContentOffset:CGPointMake(index * 320, 0) animated:YES];
}

- (UIView *)setFrameForView:(UIView *)view atIndex:(int)index {
    
    view.frame = CGRectMake(index * 320, 0, 320, 428);
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
