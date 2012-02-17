//
//  AddBrithController.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SynthesizeSingleton.h"

@interface AddBrithController : UIViewController <UITextFieldDelegate>

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(AddBrithController)

- (IBAction)kaixinImport:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *nameInputTextField;
@property (retain, nonatomic) IBOutlet UISwitch *genderSwith;

@end
