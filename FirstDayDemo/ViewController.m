//
//  ViewController.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/13/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *studentArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *student1 = @"Tim";
    NSString *student2 = @"Brad";
    NSString *student3 = @"Clark";
    
    self.studentArray = @[student1, student2, student3];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.studentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.studentArray[indexPath.row];
    
    return cell;
}

@end
