//
//  BAKAppData.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/31/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface BAKAppData : NSObject

@property (readonly) UIImage *icon;
@property (readonly) NSString *nameAndVersion;
@property (readonly) NSString *name;
@property (readonly) NSString *version;
@property (readonly) NSString *buildNumber;


@end
