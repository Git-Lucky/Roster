//
//  TableViewDataSource.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/14/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "TableViewDataSource.h"
#import "Student.h"

@interface TableViewDataSource ()

@property (strong,nonatomic) NSArray *plistData;

@end

@implementation TableViewDataSource

-(id)init
{
    
    if (self = [super init])
    {
        self.studentArray = [NSMutableArray new];
        
        self.plistData = [self convertPlist];
        [self parsePlistArray];
    }
    return self;
}

-(void)parsePlistArray
{
    for (NSDictionary* dict in self.plistData) {
        Student *student = [[Student alloc] init];
        student.name = [dict objectForKey:@"name"];
        
        [self.studentArray addObject:student];
    }
}

-(NSArray *)convertPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:path];
    
    return plistArray;

}

- (NSString *)documentsDirectoryPath
{
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [documentsURL path];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    Student *student = self.studentArray[indexPath.row];
    cell.textLabel.text = student.name;
    NSData *data = [NSData dataWithContentsOfFile:[[self documentsDirectoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", student.name]]];
    if (data) {
        cell.imageView.image = [UIImage imageWithData:data];
    }
    
    cell.imageView.layer.cornerRadius = 22;
    cell.imageView.layer.masksToBounds = YES;
    
    return cell;
}

@end
