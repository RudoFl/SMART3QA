#import <UIKit/UIKit.h>
#import "User.h"
#import "SMART3QAAppDelegate.h"

@interface UserViewController : UIViewController {
    UILabel *userIdLabel, *reputationLabel, *nameLabel, *locationLabel, *aboutLabel, *urlLabel, *birthdayLabel, *createdLabel;
    UIImageView *avatarView;
    SMART3QAAppDelegate* global;
}

@property (nonatomic, retain) UILabel *userIdLabel;
@property (nonatomic, retain) UILabel *reputationLabel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *locationLabel;
@property (nonatomic, retain) UILabel *aboutLabel;
@property (nonatomic, retain) UILabel *urlLabel;
@property (nonatomic, retain) UILabel *birthdayLabel;
@property (nonatomic, retain) UILabel *createdLabel;
@property (nonatomic, retain) UIImageView* avatarView;
@property (nonatomic, retain) SMART3QAAppDelegate* global;

- (void)setup;
- (void)loadUser:(User *)user;

@end