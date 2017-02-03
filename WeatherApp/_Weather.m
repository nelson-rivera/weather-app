// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Weather.m instead.

#import "_Weather.h"

@implementation WeatherID
@end

@implementation _Weather

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Weather" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Weather";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Weather" inManagedObjectContext:moc_];
}

- (WeatherID*)objectID {
	return (WeatherID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"humidityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"humidity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"tempValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"temp"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"tempMaxValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tempMax"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"tempMinValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tempMin"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic humidity;

- (float)humidityValue {
	NSNumber *result = [self humidity];
	return [result floatValue];
}

- (void)setHumidityValue:(float)value_ {
	[self setHumidity:@(value_)];
}

- (float)primitiveHumidityValue {
	NSNumber *result = [self primitiveHumidity];
	return [result floatValue];
}

- (void)setPrimitiveHumidityValue:(float)value_ {
	[self setPrimitiveHumidity:@(value_)];
}

@dynamic name;

@dynamic temp;

- (float)tempValue {
	NSNumber *result = [self temp];
	return [result floatValue];
}

- (void)setTempValue:(float)value_ {
	[self setTemp:@(value_)];
}

- (float)primitiveTempValue {
	NSNumber *result = [self primitiveTemp];
	return [result floatValue];
}

- (void)setPrimitiveTempValue:(float)value_ {
	[self setPrimitiveTemp:@(value_)];
}

@dynamic tempMax;

- (float)tempMaxValue {
	NSNumber *result = [self tempMax];
	return [result floatValue];
}

- (void)setTempMaxValue:(float)value_ {
	[self setTempMax:@(value_)];
}

- (float)primitiveTempMaxValue {
	NSNumber *result = [self primitiveTempMax];
	return [result floatValue];
}

- (void)setPrimitiveTempMaxValue:(float)value_ {
	[self setPrimitiveTempMax:@(value_)];
}

@dynamic tempMin;

- (float)tempMinValue {
	NSNumber *result = [self tempMin];
	return [result floatValue];
}

- (void)setTempMinValue:(float)value_ {
	[self setTempMin:@(value_)];
}

- (float)primitiveTempMinValue {
	NSNumber *result = [self primitiveTempMin];
	return [result floatValue];
}

- (void)setPrimitiveTempMinValue:(float)value_ {
	[self setPrimitiveTempMin:@(value_)];
}

@dynamic weatherDescription;

@dynamic zip;

@end

@implementation WeatherAttributes 
+ (NSString *)humidity {
	return @"humidity";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)temp {
	return @"temp";
}
+ (NSString *)tempMax {
	return @"tempMax";
}
+ (NSString *)tempMin {
	return @"tempMin";
}
+ (NSString *)weatherDescription {
	return @"weatherDescription";
}
+ (NSString *)zip {
	return @"zip";
}
@end

