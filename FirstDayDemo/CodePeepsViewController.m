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

@interface CodePeepsViewController () <UITableViewDelegate, UIActionSheetDelegate, UITextFieldDelegate>
{
    BOOL dummyKeyboardLoading;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) TableViewDataSource *dataSource;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (weak, nonatomic) IBOutlet UITextField *hiddenTextField;
@property (nonatomic) BOOL personClicked;

@end

@implementation CodePeepsViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerForKeyboardNotifications];
    
    dummyKeyboardLoading = YES;
    [self.hiddenTextField becomeFirstResponder];
    
    NSUserDefaults *fetchDefaults = [NSUserDefaults standardUserDefaults];
    BOOL sorted = [fetchDefaults boolForKey:@"sort"];
    
    self.tableView.delegate = self;
    self.dataSource = [[TableViewDataSource alloc] init];
    self.tableView.dataSource = self.dataSource;
    
    if (sorted) {
        [self sortStudents];
    }
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
    
    if (self.personClicked) {
        
        [self.dataSource save];
        
        self.personClicked = NO;
    }
    
}

#pragma mark - sorting

- (IBAction)sortButton:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Sort", nil];
    
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
    
    self.dataSource.studentArray = [[self.dataSource.studentArray sortedArrayUsingDescriptors:@[lastNameSortDescriptor]] mutableCopy];
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"sort"];
    [defaults synchronize];
}

#pragma mark - Keyboard behavior

- (void) keyboardWillShow:(NSNotification *) notification {
    UIWindow *window = nil;
    UIView *keyboardView = nil;
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    for (int i = 0; i < [windows count]; ++i) {
        window = [windows objectAtIndex:i];
        
        for (int j = 0; j < [window.subviews count]; ++j) {
            keyboardView = [window.subviews objectAtIndex:j];
            
            if ([[keyboardView description] hasPrefix:@"<UIKeyboard"] == YES) {
                if (dummyKeyboardLoading) {
                    keyboardView.hidden = YES;
                    keyboardView.userInteractionEnabled = NO;
                } else {
                    keyboardView.hidden = NO;
                    keyboardView.userInteractionEnabled = YES;
                }
                return;
            }
        }
    }
}

- (void) keyboardDidShow:(NSNotification *) notification {
    if (dummyKeyboardLoading) {
        dummyKeyboardLoading = NO;
        [self.hiddenTextField resignFirstResponder];
    }
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)refresh:(id)sender{
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetails"]) {
        if ([segue.destinationViewController isKindOfClass:[DetailsViewController class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            DetailsViewController *destTVC = segue.destinationViewController;
                Student *student = [self.dataSource.studentArray objectAtIndex:indexPath.row];
                destTVC.student= student;
            self.personClicked = YES;
        }
    }
}

#pragma mark - memory warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
