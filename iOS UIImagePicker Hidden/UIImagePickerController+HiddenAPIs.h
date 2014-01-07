//
//  UIImagePickerController+HiddenAPIs.h
//  GCDTutorial
//
//  Created by A Magical Unicorn on A Sunday Night.
//  Copyright (c) 2013 Derek Selander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImagePickerControllerHiddenAPIDelegate.h"

@interface UIImagePickerController (HiddenAPIs)
- (BOOL)allowsMultipleSelection;

/**
 Call this method on a fresh UIImagePickerController instance to hook into one of the private
 APIs methods and watch for when the imagePicker completes. This method can use method swizzling
 */
- (void)setAllowsMultipleSelection:(BOOL)allowMultipleSelection;
@property (nonatomic, assign) id<UIImagePickerControllerHiddenAPIDelegate, UINavigationControllerDelegate> delegate;
@end
