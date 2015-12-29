//
//  APStudent.h
//  Lesson 16 HW 2
//
//  Created by Alex on 28.12.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APStudent : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* lastName;
@property (assign, nonatomic) NSDate* dateOfBirth;
@property (assign, nonatomic) NSInteger age;


@end
