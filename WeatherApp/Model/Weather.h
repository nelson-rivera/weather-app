#import "_Weather.h"

@interface Weather : _Weather

+ (NSFetchedResultsController *)getAllZipCodesWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
+ (Weather *)getWeatherWithZipCode:(NSString *)zipCode;
- (void)deleteZipCode;
@end
