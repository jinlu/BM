//
//  AllBrithTableViewCell.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllBrithCellView.h"

@interface AllBrithTableViewCell : UITableViewCell
{
    
}

@property (retain, nonatomic) IBOutlet AllBrithCellView *personView1;
@property (retain, nonatomic) IBOutlet AllBrithCellView *personView2;
@property (retain, nonatomic) IBOutlet AllBrithCellView *personView3;

@end
