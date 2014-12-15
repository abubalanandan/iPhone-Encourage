//
//  JHBaseViewController.m
//  Encourage
//
//  Created by Abu on 23/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseViewController.h"

@interface JHBaseViewController ()

@end

@implementation JHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

- (void)keyboardDidShow:(NSNotification *)notification
{
    self.keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (self.activeField == nil) {
        return;
    }
    if (CGRectGetMaxY(self.activeField.frame) < CGRectGetMinY(self.keyboardFrame)) {
        return;
    }
    
    CGPoint actualOrigin = [self.view.window convertPoint:self.activeField.frame.origin fromView:[self.activeField superview]];
    
    CGFloat keyboardOffset =  actualOrigin.y + CGRectGetHeight(self.activeField.frame) - CGRectGetMinY(self.keyboardFrame);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    rect.origin.y -= keyboardOffset;
  //  rect.size.height += keyboardOffset;
    
    self.view.frame = rect;
    
    [UIView commitAnimations];

}

- (void)keyboardWillHide:(NSNotification *)notification{
       
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        CGRect rect = self.view.frame;
        CGFloat keyboardOffset = -rect.origin.y;
        rect.origin.y += keyboardOffset;
        //rect.size.height -=keyboardOffset;
        
        self.view.frame = rect;
        
        [UIView commitAnimations];
}

#pragma mark
#pragma mark -- TextField delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.activeField = textField;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.activeField = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
