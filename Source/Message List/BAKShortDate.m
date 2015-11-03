//
//  BAKShortDate.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/17/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKShortDate.h"

@interface BAKShortDate ()

@property (nonatomic) NSDate *date;
@property (nonatomic) NSString *displayString;


@end

@implementation BAKShortDate

- (instancetype)initWithDate:(NSDate *)date {
    self = [super init];
    if (!self) return nil;
    
    _date = date;
    
    return self;
}

- (NSString *)displayString {
    if (!_displayString) {
        self.displayString = [self generateDisplayString];
    }
    return _displayString;
}

- (NSString *)generateDisplayString {
   
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDate *earliest = [self.date earlierDate:date];
    NSDate *latest = (earliest == self.date) ? date : self.date;
    NSDateComponents *components = [calendar components:unitFlags fromDate:earliest toDate:latest options:0];
    
    
    if (components.year >= 1) {
        return [NSString stringWithFormat:@"%@y", @(components.year)];
    }
    else if (components.month >= 2) {
        return [NSString stringWithFormat:@"%@mo", @(components.month)];
    }
    else if (components.month == 1) {
        return [NSString stringWithFormat:@"%@w", @(components.weekOfMonth+4)];
    }
    else if (components.weekOfMonth >= 1) {
        return [NSString stringWithFormat:@"%@w", @(components.weekOfMonth)];
    }
    else if (components.day >= 1) {
        return [NSString stringWithFormat:@"%@d", @(components.day)];
    }
    else if (components.hour >= 1) {
        return [NSString stringWithFormat:@"%@h", @(components.hour)];
    }
    else if (components.minute >= 1) {
        return [NSString stringWithFormat:@"%@m", @(components.minute)];
    }
    else if (components.second >= 3) {
        return [NSString stringWithFormat:@"%@s", @(components.second)];
    }
    else {
        return [NSString stringWithFormat:@"now"];
    }
}

@end

@implementation BAKShortDate (NSCoding)

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) return nil;
    
    self.date = [decoder decodeObjectOfClass:[NSDate class] forKey:@"date"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.date forKey:@"date"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end