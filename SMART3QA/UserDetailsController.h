#import <UIKit/UIKit.h>
#import "User.h"
#import "SMART3QAAppDelegate.h"

@interface UserDetailsController : UIViewController {
    IBOutlet UILabel *userIdLabel, *reputationLabel, *nameLabel, *aboutLabel, *birthdayLabel, *createdLabel, *profileLabel;
    UIButton *twitterButton, *googleButton, *facebookButton;
    IBOutlet UIButton *locationButton, *urlButton, *userQuestions;
    IBOutlet UIImageView *avatarView;
    SMART3QAAppDelegate* app;
    User *thisuser;
}

- (void)loadUser:(User *)user;
- (IBAction)loadTwitter:(id)sender;
- (IBAction)loadGoogle:(id)sender;
- (IBAction)loadFacebook:(id)sender;
- (IBAction)loadUrl:(id)sender;
- (IBAction)loadLocation:(id)sender;
- (IBAction)showQuestions:(id)sender;

@end