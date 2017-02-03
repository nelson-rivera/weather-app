//
//  WeatherDetaileViewController.m
//  WeatherApp
//
//  Created by Nelson Rivera on 2/3/17.
//  Copyright © 2017 Applaudo Studios. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "NSNumber+TempUnits.h"
#import "Weather.h"

@interface WeatherDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *zipCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMinLabel;
@end

@implementation WeatherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - Setup

- (void)setupUI {
    self.zipCodeLabel.text = self.weather.zip;
    self.cityLabel.text = self.weather.name;
    self.descriptionLabel.text = self.weather.weatherDescription;
    self.tempLabel.text = [NSString stringWithFormat:@"%.0f°F", ceil([self.weather.temp farenheitFromKelvin].floatValue)];
    self.tempMaxLabel.text = [NSString stringWithFormat:@"%.0f°F", ceil([self.weather.tempMax farenheitFromKelvin].floatValue)];
    self.tempMinLabel.text = [NSString stringWithFormat:@"%.0f°F", ceil([self.weather.tempMin farenheitFromKelvin].floatValue)];
}


@end
