#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h"

@interface UserViewCell : UITableViewCell {
    UILabel *nameLabel, *locationLabel, *reputationLabel;
    UIImageView *avatar, *tableDividerImage;
    SMART3QAAppDelegate *app;
}

- (void)loadUser:(User *)user;

@end