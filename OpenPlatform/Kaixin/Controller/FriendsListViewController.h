

#import <UIKit/UIKit.h>
#import "Kaixin.h"

@interface FriendInfoCell : UITableViewCell {
    UIImageView *photoImageView;
    UILabel *nameLabel;
    UILabel *genderLabel;
    UILabel *statusLabel;
}

@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *genderLabel;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;

@end

@interface FriendsListViewController : UIViewController<KaixinRequestDelegate, UITableViewDelegate, UITableViewDataSource> {
    UITableView * friendTableView;
    
    IBOutlet FriendInfoCell *friendInfoCell;
    
    id _requestResponse;
}

@property (nonatomic, retain) IBOutlet UITableView * friendTableView;

@end
