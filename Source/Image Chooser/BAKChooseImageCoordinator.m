//
//  BAKChooseImageCoordinator.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/4/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKChooseImageCoordinator.h"
#import "BAKAssetFetcher.h"

@import AssetsLibrary;

@interface BAKChooseImageCoordinator () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation BAKChooseImageCoordinator

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (!self) return nil;
    
    _viewController = viewController;
    
    return self;
}

- (void)start {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.viewController presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[BAKAssetFetcher new] fetchDataForPhotoURL:info[UIImagePickerControllerReferenceURL] completion:^(NSData *data){
        if ([self.delegate respondsToSelector:@selector(imageChooser:didChooseImage:data:)]) {
            UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
            [self.delegate imageChooser:self didChooseImage:chosenImage data:data];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [self.delegate imageChooserDidCancel:self];
    }
}

@end
