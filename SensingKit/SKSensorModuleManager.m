//
//  SKSensorModuleManager.m
//  SensingKit
//
//  Copyright (c) 2014. Queen Mary University of London
//  Kleomenis Katevas, k.katevas@qmul.ac.uk
//
//  This file is part of SensingKit-iOS library.
//  For more information, please visit http://www.sensingkit.org
//
//  SensingKit-iOS is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  SensingKit-iOS is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with SensingKit-iOS.  If not, see <http://www.gnu.org/licenses/>.
//

#import "SKSensorModuleManager.h"
#import "SKAbstractSensorModule.h"

// SensorModules
#import "SKBattery.h"
#import "SKLocation.h"

#define TOTAL_SENSOR_MODULES 16

@interface SKSensorModuleManager()

@property (nonatomic, strong, readonly) NSMutableArray *sensorModules;

@end


@implementation SKSensorModuleManager

- (instancetype)init
{
    if (self = [super init])
    {
        // init array that holds the sensor modules
        _sensorModules = [[NSMutableArray alloc] initWithCapacity:TOTAL_SENSOR_MODULES];
        
        for (NSInteger i = 0; i < TOTAL_SENSOR_MODULES; i++) {
            [_sensorModules addObject:[NSNull null]];
        }
    }
    return self;
}

#pragma mark Sensor Registration methods

- (void)registerSensorModule:(SKSensorModuleType)moduleType
{
    NSLog(@"Register sensor: %@.", [self getSensorModuleInString:moduleType]);
    
    if ([self isSensorModuleRegistered:moduleType]) {
        
        NSLog(@"SensorModule is already registered.");
        abort();
    }
    
    SKAbstractSensorModule *sensorModule = [self createSensorModule:moduleType];
    [self.sensorModules insertObject:sensorModule atIndex:moduleType];
}

- (void)deregisterSensorModule:(SKSensorModuleType)moduleType
{
    NSLog(@"Deregister sensor: %@.", [self getSensorModuleInString:moduleType]);
    
    if (![self isSensorModuleRegistered:moduleType]) {
        
        NSLog(@"SensorModule is not registered.");
        abort();
    }
    
    if ([self isSensorModuleSensing:moduleType]) {
        
        NSLog(@"SensorModule is currently sensing.");
        abort();
    }
    
    // Clear all Callbacks from that sensor
    [[self getSensorModule:moduleType] unsubscribeAllSensorDataListeners];
    
    // Deregister the SensorModule
    [self.sensorModules removeObjectAtIndex:moduleType];
}

- (BOOL)isSensorModuleRegistered:(SKSensorModuleType)moduleType
{
    return ([self.sensorModules objectAtIndex:moduleType] != [NSNull null]);
}


#pragma mark Continuous Sensing methods

- (void)subscribeSensorDataListenerToSensor:(SKSensorModuleType)moduleType
                                withHandler:(SKSensorDataHandler)handler {
    
    NSLog(@"Subscribe to sensor: %@.", [self getSensorModuleInString:moduleType]);
    
    [[self getSensorModule:moduleType] subscribeSensorDataListener:handler];
}

- (void)unsubscribeSensorDataListenerFromSensor:(SKSensorModuleType)moduleType
                                      ofHandler:(SKSensorDataHandler)handler
{
    NSLog(@"Unsubscribe from sensor: %@.", [self getSensorModuleInString:moduleType]);
    
    [[self getSensorModule:moduleType] unsubscribeSensorDataListener:handler];
}

- (void)unsubscribeAllSensorDataListeners:(SKSensorModuleType)moduleType
{
    NSLog(@"Unsubscribe from all sensors.");
    
    [[self getSensorModule:moduleType] unsubscribeAllSensorDataListeners];
}

- (void)startContinuousSensingWithSensor:(SKSensorModuleType)moduleType
{
    NSLog(@"Start sensing with sensor: %@.", [self getSensorModuleInString:moduleType]);
    
    if ([self isSensorModuleSensing:moduleType]) {
        
        NSLog(@"SensorModule '%@' is already sensing.", [self getSensorModuleInString:moduleType]);
        abort();
    }
    
    // Start Sensing
    [[self getSensorModule:moduleType] startSensing];
}

- (void)stopContinuousSensingWithSensor:(SKSensorModuleType)moduleType
{
    NSLog(@"Stop sensing with sensor: %@.", [self getSensorModuleInString:moduleType]);
    
    if (![self isSensorModuleSensing:moduleType]) {
        
        NSLog(@"SensorModule '%@' is already not sensing.", [self getSensorModuleInString:moduleType]);
        abort();
    }
    
    // Stop Sensing
    [[self getSensorModule:moduleType] stopSensing];
}

- (BOOL)isSensorModuleSensing:(SKSensorModuleType)moduleType
{
    return [[self getSensorModule:moduleType] isSensing];
}


- (SKAbstractSensorModule *)getSensorModule:(SKSensorModuleType)moduleType
{
    if (![self isSensorModuleRegistered:moduleType]) {
        
        NSLog(@"SensorModule '%@' is not registered.", [self getSensorModuleInString:moduleType]);
        abort();
    }
    
    return [self.sensorModules objectAtIndex:moduleType];
}

- (SKAbstractSensorModule *)createSensorModule:(SKSensorModuleType)moduleType
{
    SKAbstractSensorModule *sensorModule;
    
    switch (moduleType) {
            
        case Accelerometer:
            //sensorModule = [[SKAccelerometer alloc] init];
            break;
            
        case Gravity:
            //sensorModule = [[SKAccelerometer alloc] init];
            break;
            
        case LinearAcceleration:
            //sensorModule = [[SKAccelerometer alloc] init];
            break;
            
        case Gyroscope:
            //sensorModule = [[SKAccelerometer alloc] init];
            break;
            
        case Rotation:
            //sensorModule = [[SKAccelerometer alloc] init];
            break;
            
        case Magnetometer:
            //sensorModule = [[SKAccelerometer alloc] init];
            break;
            
        case Battery:
            sensorModule = [[SKBattery alloc] init];
            break;
            
        case Location:
            sensorModule = [[SKLocation alloc] init];
            break;
            
        default:
            NSLog(@"Unknown SensorModule: %li", (long)moduleType);
            abort();
    }
    
    return sensorModule;
}

- (NSString *)getSensorModuleInString:(SKSensorModuleType)moduleType
{
    switch (moduleType) {
            
        case Accelerometer:
            return @"Accelerometer";
            
        case Gravity:
            return @"Gravity";
            
        case LinearAcceleration:
            return @"LinearAcceleration";
            
        case Gyroscope:
            return @"Gyroscope";
            
        case Rotation:
            return @"Rotation";
            
        case Magnetometer:
            return @"Magnetometer";
            
        case Battery:
            return @"Battery";
            
        case Location:
            return @"Location";
            
        default:
            return [NSString stringWithFormat:@"Unknown SensorModule: %li", (long)moduleType];
    }
}

@end
