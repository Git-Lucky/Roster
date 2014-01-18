//
//  DetailsViewController.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/13/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>
#import "DetailsViewController.h"
#import "TableViewDataSource.h"

@interface DetailsViewController () <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UITextField *twitterTextField;
@property (weak, nonatomic) IBOutlet UITextField *githubTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation DetailsViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self loadStudentData];
    
    self.imageButton.layer.cornerRadius = 100;
    self.imageButton.imageView.layer.cornerRadius = 50;
    self.imageButton.layer.masksToBounds = YES;
    self.imageButton.backgroundColor = [UIColor lightGrayColor];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSData *data = [NSData dataWithContentsOfFile:[[self documentsDirectoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.student.name]]];
    if (data) {
        self.student.image = [UIImage imageWithData:data];
        [self.imageButton setBackgroundImage:self.student.image forState:UIControlStateNormal];
    }
    if (self.student.imagePath) {
        [self.imageButton setTitle:@"" forState:UIControlStateNormal];
    }
    if (self.imageButton.imageView.image) {
        self.imageButton.adjustsImageWhenHighlighted = NO;
        //        [self.imageButton setUserInteractionEnabled:NO];
    }
}

#pragma mark - photo Picker

- (IBAction)startPicker:(id)sender {
    
    if (!self.student.imagePath) {
    
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIActionSheet *mySheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
            [mySheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
        } else {
            UIActionSheet *mySheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", nil];
            [mySheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Photo Library"]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        return;
    }
    [self presentViewController:imagePicker animated:YES completion:^{
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    self.student.image = editedImage;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)loadStudentData
{
    self.title = self.student.name;
    self.githubTextField.text = self.student.github;
    self.twitterTextField.text = self.student.twitter;
}

- (NSString *)documentsDirectoryPath
{
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [documentsURL path];
}

#pragma mark - delagate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.student.twitter = self.twitterTextField.text;
    self.student.github = self.githubTextField.text;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.twitterTextField resignFirstResponder];
    [self.githubTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Scrolling and Keyboard

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.myScrollView.contentInset = contentInsets;
    self.myScrollView.scrollIndicatorInsets = contentInsets;
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.myScrollView.contentInset = UIEdgeInsetsZero;
    [self.myScrollView setContentOffset:CGPointMake(0, -60) animated:YES];
//    self.myScrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - memory warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
