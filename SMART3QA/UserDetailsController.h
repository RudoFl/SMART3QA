#import <UIKit/UIKit.h>
#import "User.h"
#import "SMART3QAAppDelegate.h"

@interface UserDetailsController : UIViewController {
    UILabel *userIdLabel, *reputationLabel, *nameLabel, *locationLabel, *aboutLabel, *urlLabel, *birthdayLabel, *createdLabel;
    UIImageView *avatarView;
    SMART3QAAppDelegate* app;
}

- (void)setup;
- (void)loadUser:(User *)user;

@end