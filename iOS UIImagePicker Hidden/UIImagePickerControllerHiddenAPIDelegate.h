//
//  UIImagePickerControllerHiddenAPIDelegate.h
//  GCDTutorial
//
//  Created by A Magical Unicorn on A Sunday Night.
//  Copyright (c) 2013 Derek Selander. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIImagePickerControllerHiddenAPIDelegate <UIImagePickerControllerDelegate>

@optional
/**
 Your delegate object’s implementation of this method should pass the specified media on to any custom code that needs it, and should then dismiss the picker view. This method is intended to be used if you plan on using the UIImagePickerController hidden APIs category. You can use this as a full replacement of UIImagePickerControllerDelegate since it inherits from the protocol.

 Implementation of this method is optional, but expected.
 
 @param picker The controller object managing the image picker interface.
 @param infoArray An array of dictionaries that contain a dictionary. Each dictionary contains the original image and the edited image, if an image was picked; or a filesystem URL for the movie, if a movie was picked. The dictionary also contains any relevant editing information. The keys for this dictionary are listed in “Editing Information Keys.”
 
    @warning Be conscientous about handling mutliple photos since the memory can quickly fill up!
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfoArray:(NSArray *)infoArray;
@end
