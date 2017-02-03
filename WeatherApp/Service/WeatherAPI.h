//
//  WeatherAPI.h
//  WeatherApp
//
//  Created by Nelson Rivera on 2/2/17.
//  Copyright © 2017 Applaudo Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherAPI : NSObject

+ (WeatherAPI *)sharedInstance;
- (void)getWeatherByZipCode:(NSString *)zipCode
                    success:(void (^)(id response))successBlock
                      failure:(void (^)(NSError *error))errorBlock;

@end
