//
//  WeatherAPI.m
//  WeatherApp
//
//  Created by Nelson Rivera on 2/2/17.
//  Copyright © 2017 Applaudo Studios. All rights reserved.
//

#import "WeatherAPI.h"
#import <AFNetworking/AFNetworking.h>
#import <MagicalRecord/MagicalRecord.h>

static NSString *const kAPIURL = @"http://api.openweathermap.org/data/2.5/";

@interface WeatherAPI ()

@property (strong, nonatomic) NSString *APIKey;
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation WeatherAPI

static WeatherAPI *shared = nil;

#pragma mark - Initialization

- (instancetype)initWithAPIKey:(NSString *)APIKey {
    self = [super init];
    if (self) {
        self.APIKey = APIKey;
    }
    
    return self;
}

+ (WeatherAPI *)setAPIKey:(NSString *)APIKey {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] initWithAPIKey:APIKey];
    });
    
    
    return shared;
}

+ (WeatherAPI *)sharedInstance {
    if (shared == nil) {
        NSLog(@"ERROR: Please use setAPIKey before calling this method");
    }
    return shared;
}

#pragma mark - Getters

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kAPIURL]];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer new];
    }
    return _sessionManager;
}

#pragma mark - Weather API interaction

- (void)getWeatherByZipCode:(NSString *)zipCode
              success:(void (^)(id response))successBlock
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failureBlock {
    
    NSMutableDictionary *params = [self getParametrizedAPIKey];
    [params addEntriesFromDictionary:@{ @"zip" : zipCode}];
    
    [self.sessionManager GET:@"weather"
                  parameters:params
                     success:^(NSURLSessionTask * _Nonnull task, id _Nullable responseObject){
                         successBlock(responseObject);
                     }
                     failure:failureBlock];
    
}

- (NSMutableDictionary *)getParametrizedAPIKey {
    NSMutableDictionary *parametrizedToken = [NSMutableDictionary new];
    [parametrizedToken setObject:self.APIKey forKey:@"APPID"];
    
    return parametrizedToken;
}

@end
