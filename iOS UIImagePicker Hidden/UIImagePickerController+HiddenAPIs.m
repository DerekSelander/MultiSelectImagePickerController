//
//  UIImagePickerController+HiddenAPIs.m
//  GCDTutorial
//
//  Created by A Magical Unicorn on A Sunday Night.
//  Copyright (c) 2013 Derek Selander. All rights reserved.
//

#import "UIImagePickerController+HiddenAPIs.h"
#import <objc/runtime.h>

@interface UIImagePickerController ()
- (BOOL)_allowsMultipleSelection;
- (void)_setAllowsMultipleSelection:(BOOL)shouldAllowMultipleSelection;
- (void)_imagePickerDidCompleteWithInfoArray:(id)arg1;
@end

@implementation UIImagePickerController (HiddenAPIs)
@dynamic delegate;

//*****************************************************************************/
#pragma mark - Setup
//*****************************************************************************/

- (void)setupCodeInjectionFun
{
    //Must perform method swizzling to inject into private methods to get the multiple selection protocol; the normal delegate will only provide one choice
    Method originalMeth = class_getInstanceMethod([self class], @selector(_imagePickerDidCompleteWithInfoArray:));
    if (!originalMeth) {
        NSString *errorMessage = [NSString stringWithFormat:@"%s is broken", __PRETTY_FUNCTION__];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hidden API Broken"
                                                        message:errorMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    Method newMeth = class_getInstanceMethod([self class], @selector(newImagePickerDidCompleteWithInfoArray:));
    
    method_exchangeImplementations(originalMeth, newMeth);
}

- (void)newImagePickerDidCompleteWithInfoArray:(NSArray *)infoArray
{
    if ([self.delegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfoArray:)]) {
        [self.delegate performSelector:@selector(imagePickerController:didFinishPickingMediaWithInfoArray:) withObject:infoArray];
    }
    
    //    [self newImagePickerDidCompleteWithInfoArray:infoArray];
    //No need to call the above original method since we got all the info we need.
    //Also, original method does an automatic dismissViewController, which is not wanted
}

//*****************************************************************************/
#pragma mark - Multiple Selection Setter/Getter
//*****************************************************************************/

- (BOOL)allowsMultipleSelection
{
    if ([self respondsToSelector:@selector(_allowsMultipleSelection)]) {
        return [self _allowsMultipleSelection];
    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"%s is broken", __PRETTY_FUNCTION__];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hidden API Broken"
                                                        message:errorMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    return NO;
}

- (void)setAllowsMultipleSelection:(BOOL)allowMultipleSelection
{
    if ([self respondsToSelector:@selector(_setAllowsMultipleSelection:)]) {
        if (allowMultipleSelection) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [self setupCodeInjectionFun];
            });
        }
        [self _setAllowsMultipleSelection:allowMultipleSelection];
    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"%s is broken", __PRETTY_FUNCTION__];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hidden API Broken"
                                                        message:errorMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
