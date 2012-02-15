//
//  UploadPhotoViewController.m
//  testUI
//
//  Created by Feng Cheng on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UploadPhotoViewController.h"
#import "CommonData.h"


@implementation UploadPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _requestResponse = nil;
        selectedAlbums = -1;
    }
    return self;
}

- (void)dealloc
{
    [_requestResponse release];
    
    [super dealloc];
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
    // Do any additional setup after loading the view from its nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 30)];
    [btn setBackgroundImage:[[UIImage imageNamed:@"backbutton.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0,6, 0, 0);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:btn] autorelease];
    [btn release];
    
    self.navigationItem.title = @"上传照片";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [_albumsButton release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
- (IBAction)createAlbum:(id)sender
{
	UIAlertView *alert = [ [UIAlertView alloc] initWithTitle:@"新专辑名字" message:@"\n" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消",nil];		
	
	UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(10,50,260,25)];
	
	[textField setBackgroundColor:[UIColor clearColor]];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.font = [UIFont systemFontOfSize:16];
	textField.tag = 100;
	
	[alert addSubview:textField];
	[textField release];
	
    NSString * systemVersion = [[UIDevice currentDevice] systemVersion];
    if([systemVersion rangeOfString:@"4"].length == 0)
    {
        alert.transform = CGAffineTransformTranslate(alert.transform, 0, 100);
    }
	
	[textField becomeFirstResponder];
//	alert.tag = row;
	[alert show];
	[alert release];
}
*/

- (IBAction)getAlbums:(id)sender
{
    NSString * UIDString = [NSString stringWithFormat:@"%d", [[CommonData sharedData] uid]];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:
								 UIDString,@"uid",
    							 nil];
    [[[CommonData sharedData] kaixin] requestWithSeparateURL:@"https://api.kaixin001.com/album/show.json" params:params andHttpMethod:@"GET" andDelegate:self];
}
 
 - (void)didSelectAlbumAtIndexPath:(NSIndexPath *)indexPath
 {
     selectedAlbums = [indexPath row];
     NSString * albumeButtonString = [NSString stringWithFormat:@"专辑：%@", [[_requestResponse objectAtIndex:selectedAlbums] objectForKey:@"title"]];
     [_albumsButton setTitle:albumeButtonString forState:UIControlStateNormal];    
 }
 
// - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
// {
//     NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
// 
//     if (buttonIndex == 0)
//     {
//         UITextField* textField = (UITextField*)[alertView viewWithTag:100];
//         
//         if (textField != nil)
//         {
//             if( [textField.text length] == 0 )
//             {
//                 UIAlertView *alert = [ [UIAlertView alloc] initWithTitle:@"名字不能为空" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];		
//                 alert.tag = alertView.tag;
//                 [alert show];
//                 [alert release];
//                 return;
//             }
//             
//             NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                          @"photos.createAlbum",@"method",
//                                          textField.text,@"title",
//                                          nil];
//             [[[CommonData sharedData] kaixin] requestWithParams:params andDelegate:self];
//         }
//     }
//     
//     [pool release];
// }


- (IBAction)upload:(id)sender
{
    if (selectedAlbums != -1)
    {
        NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     _imageView.image,@"pic",
                                     nil];
        
        NSString *albumid = [[_requestResponse objectAtIndex:selectedAlbums] objectForKey:@"albumid"];//要上传的相册id
        [params setObject:albumid forKey:@"albumid"];
    	
        [[[CommonData sharedData] kaixin] requestWithSeparateURL:@"https://api.kaixin001.com/photo/upload.json" params:params andHttpMethod:@"POST" andDelegate:self];

    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择专辑" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
	}
}

- (void)request:(KaixinRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"received response");
}

- (void)request:(KaixinRequest *)request didLoad:(id)result
{
    NSString * method = [request url].lastPathComponent;
    if ([method isEqualToString:@"show.json"])
    {
        if ([result count] > 0)
        {
            [_requestResponse release];
            _requestResponse = [result objectForKey:@"data"];
            [_requestResponse retain];
            
            AlbumListViewController *albumListViewController = [[AlbumListViewController alloc]
                                                                    initWithNibName:@"AlbumListViewController" bundle:nil];
            
            [albumListViewController setData:_requestResponse delegate:self];
            
            [[self navigationController] pushViewController:albumListViewController animated:YES];
            
            [albumListViewController release];        
        }
    }
    else if ([method isEqualToString:@"upload.json"])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"上传成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)request:(KaixinRequest *)request didFailWithError:(NSError *)error
{
    NSString * msg = [[error userInfo] objectForKey:@"error"];
    
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
