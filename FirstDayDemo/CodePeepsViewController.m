//
//  CodePeepsViewController.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/13/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "CodePeepsViewController.h"
#import "DetailsViewController.h"
#import "Student.h"
#import "TableViewDataSource.h"

@interface CodePeepsViewController () <UITableViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) TableViewDataSource *dataSource;
@property (strong, nonatomic) UIActionSheet *actionSheet;

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

- (IBAction)sortButton:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Sort", nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Sort"]) {
        [self sortStudents];
        [self.tableView reloadData];
    }
}

-(void)sortStudents
{
    NSSortDescriptor *lastNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    self.dataSource.studentArray = [self.dataSource.studentArray sortedArrayUsingDescriptors:@[lastNameSortDescriptor]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.dataSource = [[TableViewDataSource alloc] init];
    self.tableView.dataSource = self.dataSource;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)refresh:(id)sender{
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetails"]) {
        if ([segue.destinationViewController isKindOfClass:[DetailsViewController class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            DetailsViewController *destTVC = segue.destinationViewController;
                Student *student = [self.dataSource.studentArray objectAtIndex:indexPath.row];
                destTVC.studentName = student.name;
        }
    }
}



@end
