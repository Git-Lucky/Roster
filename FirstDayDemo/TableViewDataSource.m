//
//  TableViewDataSource.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/14/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "TableViewDataSource.h"
#import "Student.h"
#import "CodePeepsCell.h"

@interface TableViewDataSource ()

@property (strong,nonatomic) NSArray *plistData;

@end

@implementation TableViewDataSource

-(id)init
{
    
    if (self = [super init])
    {
        self.studentArray = [self load];
        if (self.studentArray) {
            for (Student *student in self.studentArray){
                NSData *data = [NSData dataWithContentsOfFile:[[self documentsDirectoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",student.name]]];
                if (data) {
                    student.image = [UIImage imageWithData:data];
                }
            }
            
            NSLog(@"Unarchive success");
        } else {
            NSLog(@"No archive, creating new array with archive");
            self.studentArray = [NSMutableArray new];
            self.plistData = [self convertPlist];
            [self parsePlistArray];
            [self convertToArchive];
        }
    }
    return self;
}

- (void)convertToArchive
{
    [self save];
}

-(void)parsePlistArray
{
    for (NSDictionary* dict in self.plistData) {
        Student *student = [[Student alloc] init];
        student.name = [dict objectForKey:@"name"];
        
        NSData *data = [NSData dataWithContentsOfFile:[[self documentsDirectoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",student.name]]];
        
        if (data) {
            student.image = [UIImage imageWithData:data];
        }
        [self.studentArray addObject:student];
    }
}

-(NSArray *)convertPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:path];
        
    return plistArray;

}

- (BOOL)save
{
    return [NSKeyedArchiver archiveRootObject:self.studentArray toFile:[self archivedStudentsPath]];
}

- (NSMutableArray *)load
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivedStudentsPath]];
}


- (NSString *)documentsDirectoryPath
{
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [documentsURL path];

}

- (NSString *)archivedStudentsPath
{
    return [[self documentsDirectoryPath] stringByAppendingPathComponent:@"archive"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.studentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CodePeepsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.student = self.studentArray[indexPath.row];
    
    return cell;
}

@end
