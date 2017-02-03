#import "Weather.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Weather ()

// Private interface goes here.

@end

@implementation Weather

+ (NSFetchedResultsController *)getAllZipCodesWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate {
    return [Weather MR_fetchAllSortedBy:@"zip" ascending:YES withPredicate:nil groupBy:nil delegate:delegate];
}

- (void)deleteZipCode {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        [self MR_deleteEntityInContext:localContext];
    }];
}

@end
