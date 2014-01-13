//
//  ViewController.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/13/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "ViewController.h"
#import "DetailsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *studentArray;
@property (strong, nonatomic) NSArray *instructorArray;
@property (strong, nonatomic) NSArray *sectionCount;
@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *student1 = @"Tim";
    NSString *student2 = @"Gus";
    NSString *student3 = @"Clark";
    
    NSString *instructor1 = @"Brad";
    NSString *instructor2 = @"Clem";
    
    self.studentArray = @[student1, student2, student3];
    self.instructorArray = @[instructor1, instructor2];
    self.list = @[@"Students", @"Instructors"];
    
    self.sectionCount = @[self.studentArray, self.instructorArray];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
//    [self.refreshControl targetForAction:@selector(refresh:) withSender:self];
}

- (void)refresh:(id)sender{
    
    NSLog(@"Hi");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self.studentArray count];
    } else {
        return [self.instructorArray count];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, -2, tableView.frame.size.width, 30)];
    [label setFont:[UIFont boldSystemFontOfSize:18]];
    NSString *string =[self.list objectAtIndex:section];
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor lightGrayColor]];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    int count = [self.sectionCount count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.studentArray[indexPath.row];
    } else {
        cell.textLabel.text = self.instructorArray[indexPath.row];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetails"]) {
        if ([segue.destinationViewController isKindOfClass:[DetailsViewController class]]) {
            NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
            DetailsViewController *destTVC = segue.destinationViewController;
            if (indexPath.section == 0) {
                destTVC.studentName = [self.studentArray objectAtIndex:indexPath.row];
            } else {
                destTVC.instructorName = [self.instructorArray objectAtIndex:indexPath.row];
            }
            destTVC.section = indexPath.section;
        }
    }
}


@end
