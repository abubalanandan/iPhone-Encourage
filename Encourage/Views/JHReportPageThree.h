//
//  JHReportPageThree.h
//  Encourage
//
//  Created by kiran vs on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHReportPageThree : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate> {
    
    IBOutlet UIImageView *selectedImageView;
    IBOutlet UITextField *dateTextField, *commentsTextField;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIView *pickerContainerView;
    IBOutlet UIScrollView *containerScrollView;
    IBOutlet UIView *containerView;
}

- (IBAction)selectImage:(id)sender;
- (UIImage *)getImage;
- (NSDictionary *)getData;

@end
