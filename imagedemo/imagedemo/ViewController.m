//
//  ViewController.m
//  imagedemo
//
//  Created by darren cullen on 12/03/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    self.scrollView.contentSize = image.size;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pickPhoto:()sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        if ([mediaTypes containsObject:(NSString *) kUTTypeImage]){
            UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
            pickerVC.delegate = self;
            pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerVC.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
            pickerVC.allowsEditing = YES;
            [self presentViewController:pickerVC animated:YES completion:nil];
        }
        
    }
}

@end
