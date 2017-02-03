#import "Weather.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Weather ()

// Private interface goes here.

@end

@implementation Weather

+ (NSArray *)getAllZipCodes {
    NSArray *zipCodesSorted = [Weather MR_findAllSortedBy:@"zip"
                                                ascending:YES];
    
    return zipCodesSorted;
}

@end
