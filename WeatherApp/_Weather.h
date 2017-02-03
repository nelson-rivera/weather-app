// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Weather.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface WeatherID : NSManagedObjectID {}
@end

@interface _Weather : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) WeatherID *objectID;

@property (nonatomic, strong, nullable) NSNumber* humidity;

@property (atomic) float humidityValue;
- (float)humidityValue;
- (void)setHumidityValue:(float)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSNumber* temp;

@property (atomic) float tempValue;
- (float)tempValue;
- (void)setTempValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* tempMax;

@property (atomic) float tempMaxValue;
- (float)tempMaxValue;
- (void)setTempMaxValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* tempMin;

@property (atomic) float tempMinValue;
- (float)tempMinValue;
- (void)setTempMinValue:(float)value_;

@property (nonatomic, strong, nullable) NSString* weatherDescription;

@property (nonatomic, strong, nullable) NSString* zip;

@end

@interface _Weather (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveHumidity;
- (void)setPrimitiveHumidity:(nullable NSNumber*)value;

- (float)primitiveHumidityValue;
- (void)setPrimitiveHumidityValue:(float)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable NSNumber*)primitiveTemp;
- (void)setPrimitiveTemp:(nullable NSNumber*)value;

- (float)primitiveTempValue;
- (void)setPrimitiveTempValue:(float)value_;

- (nullable NSNumber*)primitiveTempMax;
- (void)setPrimitiveTempMax:(nullable NSNumber*)value;

- (float)primitiveTempMaxValue;
- (void)setPrimitiveTempMaxValue:(float)value_;

- (nullable NSNumber*)primitiveTempMin;
- (void)setPrimitiveTempMin:(nullable NSNumber*)value;

- (float)primitiveTempMinValue;
- (void)setPrimitiveTempMinValue:(float)value_;

- (nullable NSString*)primitiveWeatherDescription;
- (void)setPrimitiveWeatherDescription:(nullable NSString*)value;

- (nullable NSString*)primitiveZip;
- (void)setPrimitiveZip:(nullable NSString*)value;

@end

@interface WeatherAttributes: NSObject 
+ (NSString *)humidity;
+ (NSString *)name;
+ (NSString *)temp;
+ (NSString *)tempMax;
+ (NSString *)tempMin;
+ (NSString *)weatherDescription;
+ (NSString *)zip;
@end

NS_ASSUME_NONNULL_END
