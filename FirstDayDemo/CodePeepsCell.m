//
//  CodePeepsCell.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/16/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "CodePeepsCell.h"

@implementation CodePeepsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStudent:(Student *)student
{
    // When setter is called, sets student name
    _student = student;
    
    self.textLabel.text = _student.name;
    
    if (self.student.image) {
        self.imageView.image = self.student.image;
    }
    else if (self.student.imagePath) {
        self.imageView.image = [UIImage imageWithContentsOfFile:self.student.imagePath];
    } else {
        self.imageView.image = nil;
    }
    
    self.imageView.layer.cornerRadius = 22;
    self.imageView.layer.masksToBounds = YES;

}


@end
