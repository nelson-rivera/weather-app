//
//  ViewController.m
//  WeatherApp
//
//  Created by Nelson Rivera on 2/2/17.
//  Copyright © 2017 Applaudo Studios. All rights reserved.
//

#import "ZipCodeListViewController.h"
#import "Weather.h"

@interface ZipCodeListViewController ()
@property (strong, nonatomic) NSArray *zipCodesList;
@end

@implementation ZipCodeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(showAddZipCodeAlert)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters

- (NSArray *)zipCodeList {
    if (!_zipCodesList) {
        _zipCodesList = [Weather getAllZipCodes];
    }
    
    return _zipCodesList;
}

#pragma mark -

- (void)showAddZipCodeAlert {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"New Weather Zone" message:@"Add a Zip code" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Add"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action) {
                                                   UITextField *zipCodeTextField = alertController.textFields.firstObject;
                                                   NSLog(@"%@", zipCodeTextField.text);
                                                   if (!zipCodeTextField) {
                                                       return;
                                                   }
                                                   
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.zipCodeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zipCodeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Weather *weather = self.zipCodesList[indexPath.row];
    cell.textLabel.text = weather.zip;
    
    return cell;
}



@end
