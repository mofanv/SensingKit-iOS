//
//  SKHeadingData.h
//  SensingKit
//
//  Copyright (c) 2017. Kleomenis Katevas
//  Kleomenis Katevas, k.katevas@imperial.ac.uk
//
//  This file is part of SensingKit-iOS library.
//  For more information, please visit https://www.sensingkit.org
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

#import <SensingKit/SensingKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  An instance of SKHeadingData encapsulates measurements related to the Heading sensor.
 */
@interface SKHeadingData : SKSensorData

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithSensorType:(SKSensorType)sensorType
                     withTimestamp:(SKSensorTimestamp *)timestamp NS_UNAVAILABLE;

/**
 *  Returns an SKHeadingData object, initialized with an instance of CLHeading.
 *
 *  @param heading A CLHeading object that contains Heading related data.
 *
 *  @return An SKHeadingData object.
 */
- (instancetype)initWithHeading:(CLHeading *)heading NS_DESIGNATED_INITIALIZER;

/**
 *  A CLHeading object contains data about the device's orientation relative to magnetic and true north.
 */
@property (nonatomic, readonly, copy) CLHeading *heading;

/**
 *  A string with a CSV formatted header that describes the data of the Heading sensor. This method is useful in combination with the csvString instance method of an SKSensorData object.
 *
 *  @return A string with a CSV header.
 */
+ (NSString *)csvHeader;

@end

NS_ASSUME_NONNULL_END
