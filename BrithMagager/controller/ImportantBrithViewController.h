//
//  FirstViewController.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddBrithController.h"
#import "ImportantBrithModel.h"

@interface ImportantBrithViewController : UIViewController <ImportantBrithDelegate>
{
    ImportantBrithModel *importantBrithModel;
}
@end
