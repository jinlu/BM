//
//  AddBrithController.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddBrithController.h"
#import "KaixinLoginController.h"
#import "AddBrithAdapter.h"
#import "DataItemFactory.h"

@implementation AddBrithController
@synthesize nameInputTextField;
@synthesize genderSwith;

SYNTHESIZE_SINGLETON_FOR_CLASS(AddBrithController)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"添加生日" style:UIBarButtonItemStylePlain target:self action:@selector(addOneBrithDay:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.title = @"添加生日";
    [rightButton release];
}

- (void)viewDidUnload
{
    [self setNameInputTextField:nil];
    [self setGenderSwith:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)kaixinImport:(id)sender 
{
    KaixinLoginController *loginController = [KaixinLoginController sharedInstance];
    [self.navigationController pushViewController:loginController animated:YES];
}

- (void)dealloc 
{
    [nameInputTextField release];
    [genderSwith release];
    [super dealloc];
}

#pragma mark - Text Field
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Add One BrithDay
- (BOOL)addOneBrithDay:(id)sender
{  
    DataItem *dataItem = [DataItemFactory produceDataItem];
    [dataItem setAddressName:nameInputTextField.text];
    [dataItem setAddressBrith:@"随便哪天"];
    [dataItem setAddressGender:YES];
    [AddBrithAdapter dataCenterAddBrith:dataItem];    
    [self.navigationController popToRootViewControllerAnimated:YES];
    return YES;
}

@end
