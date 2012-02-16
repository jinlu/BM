
#import <UIKit/UIKit.h>
#import "Kaixin.h"

@interface UsersInfoViewController : UIViewController<KaixinRequestDelegate> {
    
    UIImageView * imageView;
    UILabel* nameLabel;
    UILabel* uidLabel;
    UILabel* genderLabel;

}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *uidLabel;
@property (nonatomic, retain) IBOutlet UILabel *genderLabel;

@end
