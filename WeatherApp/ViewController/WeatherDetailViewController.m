//
//  WeatherDetaileViewController.m
//  WeatherApp
//
//  Created by Nelson Rivera on 2/3/17.
//  Copyright © 2017 Applaudo Studios. All rights reserved.
//

#import "WeatherDetailViewController.h"
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
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setupUI {
    self.zipCodeLabel.text = self.weather.zip;
    self.cityLabel.text = self.weather.name;
    self.descriptionLabel.text = self.weather.weatherDescription;
    self.tempLabel.text = [self fromKelvinToFarenheit:self.weather.temp];
    self.tempMaxLabel.text = [self fromKelvinToFarenheit:self.weather.tempMax];
    self.tempMinLabel.text = [self fromKelvinToFarenheit:self.weather.tempMin];
}

#pragma mark - temp units conversion

- (NSString *)fromKelvinToFarenheit:(NSNumber *)kTemp {
    float fTemp = kTemp.floatValue * (9.0/5.0) - 459.67;
    return [NSString stringWithFormat:@"%.0f°F", fTemp];
}


@end
