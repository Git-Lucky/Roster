//
//  Student.h
//  FirstDayDemo
//
//  Created by Tim Hise on 1/13/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject <NSCoding>
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *twitter;
@property (strong, nonatomic) NSString *github;
@property (strong, nonatomic) UIImage *image;
@end
