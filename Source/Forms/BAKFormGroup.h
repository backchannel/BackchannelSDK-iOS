//
//  BAKFormGroup.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKFormField.h"

@interface BAKFormGroup : UIView

- (void)addFormField:(BAKFormField *)formField;

@end
