//
//  MBProgressHUD.h
//  Version 0.8
//  Created by Matej Bukovinski on 2.4.09.
//

// This code is distributed under the terms and conditions of the MIT license.

// Copyright (c) 2013 Matej Bukovinski
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "JHHudController.h"
#import "MBProgressHUD.h"

@implementation JHHudController


static const int  HUD_BG_TAG = 2456;

+ (void)addHUDBackground {
    
    UIView *hudBgView = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].bounds];
    hudBgView.tag = HUD_BG_TAG;
    hudBgView.alpha = 1.0;
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:hudBgView];
}

+ (void)removeHUDBackground {
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    for (UIView *view in [window subviews]) {
        
        if (view.tag == HUD_BG_TAG) {
            
            [view removeFromSuperview];
        }
    }
}

+ (void)displayHUDWithMessage:(NSString *)message {
    
    [self addHUDBackground];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
	hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = message;
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
    [window addSubview:hud];
    [hud show:YES];
}

+ (void)hideAllHUDs {
    
    [self removeHUDBackground];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
}

+ (void)displayHUDWithTitle:(NSString *)title withMessage:(NSString *)message time:(NSTimeInterval)timeInterval {
    
    [self addHUDBackground];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
	hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.detailsLabelText = message;
    hud.labelFont = [UIFont systemFontOfSize:12.0];
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
    [self removeHUDBackground];
    [window addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:timeInterval];
}

@end
