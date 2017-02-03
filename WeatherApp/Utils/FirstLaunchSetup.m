//
//  FirstLaunchSetup.m
//  WeatherApp
//
//  Created by Nelson Rivera on 2/3/17.
//  Copyright © 2017 Applaudo Studios. All rights reserved.
//

#import "FirstLaunchSetup.h"
#import "Weather.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation FirstLaunchSetup

+ (void)firstLaunchSetup
{
    BOOL initialSetupDone = [[NSUserDefaults standardUserDefaults] boolForKey:@"initialSetupDone"];
    
    if (!initialSetupDone) {
        NSArray *zipCodes = @[ @"90210", @"20151", @"02108" ];
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            for (NSString *zipCode in zipCodes) {
                Weather *weather = [Weather MR_createEntityInContext:localContext];
                weather.zip = zipCode;
            }
        }];
        
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"initialSetupDone"];
    }
}

@end
