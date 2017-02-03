#import "_Weather.h"

@interface Weather : _Weather

+ (NSFetchedResultsController *)getAllZipCodesWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (void)deleteZipCode;
@end
