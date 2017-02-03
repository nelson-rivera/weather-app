//
//  WeatherAPI.m
//  WeatherApp
//
//  Created by Nelson Rivera on 2/2/17.
//  Copyright © 2017 Applaudo Studios. All rights reserved.
//

#import "WeatherAPI.h"
#import "Weather.h"
#import <AFNetworking/AFNetworking.h>
#import <MagicalRecord/MagicalRecord.h>

static NSString *const kAPIURL = @"http://api.openweathermap.org/data/2.5/";

@interface WeatherAPI ()

@property (strong, nonatomic) NSString *APIKey;
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation WeatherAPI

static WeatherAPI *shared = nil;

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static WeatherAPI *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Getters

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kAPIURL]];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer new];
    }
    return _sessionManager;
}

- (NSString *)APIKey {
    if (!_APIKey) {
        _APIKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"OWAPIKey"];
    }
    return _APIKey;
}

#pragma mark - Weather API interaction

- (void)getWeatherByZipCode:(NSString *)zipCode
              success:(void (^)(id response))successBlock
              failure:(void (^)(NSError *error))failureBlock {
    
    NSMutableDictionary *params = [self getParametrizedAPIKey];
    [params addEntriesFromDictionary:@{ @"zip" : zipCode}];
    
    if (![self isConnectedToInternet]) {
        Weather *weather = [Weather MR_findFirstByAttribute:@"zip" withValue:zipCode];
        if (!weather || !weather.weatherDescription.length) {
            NSError *error = [[NSError alloc] initWithDomain:@"WeatherApp"
                                                        code:-1
                                                    userInfo:@{NSLocalizedDescriptionKey: @"Failed to load weather data, make sure you have an active internet connection"}];
            failureBlock(error);
            return;
        }
        successBlock((id)weather);
        return;
    }
    
    [self.sessionManager GET:@"weather"
                  parameters:params
                     success:^(NSURLSessionTask * _Nonnull task, id _Nullable responseObject){
                         successBlock(responseObject);
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         failureBlock(error);
                     }];
    
}

#pragma mark - Utils

- (NSMutableDictionary *)getParametrizedAPIKey {
    NSMutableDictionary *parametrizedToken = [NSMutableDictionary new];
    [parametrizedToken setObject:self.APIKey forKey:@"APPID"];
    
    return parametrizedToken;
}

- (BOOL)isConnectedToInternet {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
