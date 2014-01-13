//
//  CodePeepsViewController.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/13/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "CodePeepsViewController.h"
#import "DetailsViewController.h"

@interface CodePeepsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *studentArray;
@property (strong, nonatomic) NSArray *instructorArray;
@property (strong, nonatomic) NSArray *sectionCount;
@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end

@implementation CodePeepsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)refresh:(id)sender{
    NSLog(@"Hi");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int count = [self.sectionCount count];
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.studentArray count];
    } else {
        return [self.instructorArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.studentArray[indexPath.row];
    } else {
        cell.textLabel.text = self.instructorArray[indexPath.row];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont boldSystemFontOfSize:18]];
    NSString *string =[self.list objectAtIndex:section];
    [label setText:string];
    label.backgroundColor = [UIColor lightGrayColor];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetails"]) {
        if ([segue.destinationViewController isKindOfClass:[DetailsViewController class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
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
