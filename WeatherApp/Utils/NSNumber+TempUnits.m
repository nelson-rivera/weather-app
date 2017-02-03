//
//  NSNumber+TempUnits.m
//  WeatherApp
//
//  Created by Nelson Rivera on 2/3/17.
//  Copyright © 2017 Applaudo Studios. All rights reserved.
//

#import "NSNumber+TempUnits.h"

@implementation NSNumber (TempUnits)
- (NSNumber *)farenheitFromKelvin {
    NSNumber *kTemp = self;
    float fTemp = kTemp.floatValue * (9.0/5.0) - 459.67;
    return @(fTemp);
}
@end
