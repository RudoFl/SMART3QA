#import <UIKit/UIKit.h>
#import "User.h"
#import "SMART3QAAppDelegate.h"

@interface UserViewController : UIViewController {
    UILabel *userIdLabel, *reputationLabel, *nameLabel, *locationLabel, *aboutLabel, *urlLabel, *birthdayLabel, *createdLabel;
    UIImageView *avatarView;
    SMART3QAAppDelegate* global;
}

- (void)setup;
- (void)loadUser:(User *)user;

@end