//
//  DetailsScrollView.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/17/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "DetailsScrollView.h"

@implementation DetailsScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.superview touchesBegan:touches withEvent:event];
}

@end
