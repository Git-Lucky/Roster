//
//  DetailsViewController.m
//  FirstDayDemo
//
//  Created by Tim Hise on 1/13/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>
#import "DetailsViewController.h"

@interface DetailsViewController () <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageOutlet;
@property (weak, nonatomic) IBOutlet UITextField *twitterTextField;
@property (weak, nonatomic) IBOutlet UITextField *githubTextField;
@end

@implementation DetailsViewController

- (IBAction)cameraButton:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *mySheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
        [mySheet showFromBarButtonItem:sender animated:YES];
    } else {
        UIActionSheet *mySheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", nil];
        [mySheet showFromBarButtonItem:sender animated:YES];
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
    
    self.imageOutlet.image = editedImage;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    NSData *pngData = UIImagePNGRepresentation(editedImage);
    NSString *pngPath = [[self documentsDirectoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.studentName]];
    [pngData writeToFile:pngPath atomically:YES];
    
    ALAssetsLibrary *assetsLibrary = [ALAssetsLibrary new];
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted) {
        return;
    } else {
        [assetsLibrary writeImageToSavedPhotosAlbum:editedImage.CGImage orientation:UIImageOrientationUp completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            }
        }];
    }
}

- (NSString *)documentsDirectoryPath
{
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [documentsURL path];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    self.title = self.studentName;
    NSData *data = [NSData dataWithContentsOfFile:[[self documentsDirectoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.studentName]]];
    if (data) {
        self.imageOutlet.image = [UIImage imageWithData:data];
    }
    
    self.imageOutlet.layer.cornerRadius = 150;
    self.imageOutlet.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
