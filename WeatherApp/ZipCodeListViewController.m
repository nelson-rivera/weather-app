//
//  ViewController.m
//  WeatherApp
//
//  Created by Nelson Rivera on 2/2/17.
//  Copyright © 2017 Applaudo Studios. All rights reserved.
//

#import "ZipCodeListViewController.h"
#import "Weather.h"
#import "WeatherAPI.h"
#import "WeatherDetailViewController.h"
#import <MagicalRecord/MagicalRecord.h>

static NSString *const APIKey = @"28b2c96074e5b1ded3c1053c7ab408c4";

@interface ZipCodeListViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *zipCodeList;
@end

@implementation ZipCodeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(showAddZipCodeAlert)];
    
    [WeatherAPI setAPIKey:APIKey];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters

- (NSFetchedResultsController *)zipCodeList {
    if (!_zipCodeList) {
        _zipCodeList = [Weather getAllZipCodesWithDelegate:self];
    }
    
    return _zipCodeList;
}

#pragma mark -

- (void)showAddZipCodeAlert {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"New Weather Zone" message:@"Add a Zip code" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Add"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action) {
                                                   UITextField *zipCodeTextField = alertController.textFields.firstObject;
                                                   NSLog(@"%@", zipCodeTextField.text);
                                                   if (!zipCodeTextField.text) {
                                                       return;
                                                   }
                                                   [self addZip:zipCodeTextField.text];
                                                   
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Add a Zip code";
    }];
    
    [alertController addAction:ok];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -

- (void)addZip:(NSString *)zipCode
{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        Weather *weather = [Weather MR_createEntityInContext:localContext];
        weather.zip = zipCode;
    }];
    [self.zipCodeList performFetch:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.zipCodeList.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zipCodeCell" forIndexPath:indexPath];
    
    Weather *weather = [self.zipCodeList objectAtIndexPath:indexPath];
    cell.textLabel.text = weather.zip;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.allowsSelection = NO;
    Weather *weather = [self.zipCodeList objectAtIndexPath:indexPath];
    NSString *zipCode = weather.zip;
    
    [[WeatherAPI sharedInstance] getWeatherByZipCode:zipCode
                                                   success:^(id responseObject) {
                                                       tableView.allowsSelection = YES;
                                                       
                                                       NSMutableDictionary *mutableResponse = [(NSDictionary *)responseObject mutableCopy];
                                                       NSString *condition = [[[mutableResponse objectForKey:@"weather"] firstObject] objectForKey:@"main"];
                                                       NSString *description =
                                                       [[[mutableResponse objectForKey:@"weather"] firstObject] objectForKey:@"description"];
                                                       [mutableResponse setObject:condition forKey:@"condition"];
                                                       [mutableResponse setObject:description forKey:@"weatherDescription"];
                                                       [mutableResponse setObject:zipCode forKey:@"zip"];
                                                       [self addWeatherToZipCode:mutableResponse];
                                                   }
                                                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                         NSLog(@"Error: %@", error);
                                                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                                         [alertView show];
                                                         tableView.allowsSelection = YES;
                                                     }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Weather *weather = [self.zipCodeList objectAtIndexPath:indexPath];
        [weather deleteZipCode];
    }
}

#pragma mark - NSFetchedResultsController

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

#pragma - Persistence

- (void)addWeatherToZipCode:(NSDictionary *)responseObject {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *_Nonnull localContext) {
        [Weather MR_importFromObject:responseObject inContext:localContext];
    } completion:^(BOOL contextDidSave, NSError *_Nullable error) {
        if (error && !contextDidSave) {
            return;
        }
        Weather *weather = [Weather getWeatherWithZipCode:responseObject[@"zip"]];
        [self performSegueWithIdentifier:@"showZipWeather" sender:weather];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showZipWeather"] &&
        [segue.destinationViewController isKindOfClass:[WeatherDetailViewController class]]) {
        WeatherDetailViewController *vc = segue.destinationViewController;
        vc.weather = sender;
    }
}

@end
