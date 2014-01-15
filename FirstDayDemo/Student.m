//
//  Student.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/13/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.image = [aDecoder decodeObjectForKey:@"image"];
    self.twitter = [aDecoder decodeObjectForKey:@"twitter"];
    self.github = [aDecoder decodeObjectForKey:@"github"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.twitter forKey:@"twitter"];
    [aCoder encodeObject:self.github forKey:@"github"];
}


@end
