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
    self.imagePath = [aDecoder decodeObjectForKey:@"imagePath"];
    self.twitter = [aDecoder decodeObjectForKey:@"twitter"];
    self.github = [aDecoder decodeObjectForKey:@"github"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.imagePath forKey:@"image"];
    [aCoder encodeObject:self.twitter forKey:@"twitter"];
    [aCoder encodeObject:self.github forKey:@"github"];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    NSData *pngData = UIImagePNGRepresentation(_image);
    NSString *pngPath = [[self documentsDirectoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.name]];
    [pngData writeToFile:pngPath atomically:YES];
    self.imagePath = pngPath;
}

- (NSString *)documentsDirectoryPath
{
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [documentsURL path];
}

@end
