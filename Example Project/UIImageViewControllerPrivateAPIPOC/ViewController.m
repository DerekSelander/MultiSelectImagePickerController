//
//  ViewController.m
//  UIImageViewControllerPrivateAPIPOC
//
//  Created by Derek Selander on 1/7/14.
//  Copyright (c) 2014 Derek Selander. All rights reserved.
//

#import "ViewController.h"
#import "UIImagePickerController+HiddenAPIs.h"
@interface ViewController () <UIImagePickerControllerHiddenAPIDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)presentImagePicker:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    [imagePickerController setAllowsMultipleSelection:YES];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

//*****************************************************************************/
#pragma mark - UIImagePickerControllerHiddenAPIDelegate Methods
//*****************************************************************************/

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfoArray:(NSArray *)infoArray
{
    for (NSDictionary *infoDictionary in infoArray) {
        NSLog(@"%@", infoDictionary);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Cancelled");
}
@end
