//
//  AppDelegate.h
//  WeatherApp
//
//  Created by Nelson Rivera on 2/2/17.
//  Copyright © 2017 Applaudo Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

