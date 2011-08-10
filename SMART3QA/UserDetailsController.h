#import <UIKit/UIKit.h>
#import "User.h"
#import "SMART3QAAppDelegate.h"

@interface UserDetailsController : UIViewController
<UITableViewDelegate, UITableViewDataSource> {
    SMART3QAAppDelegate* app;
    User *thisuser;
    
    NSDictionary *userData;
    NSArray *sortedKeys;
}

- (void)loadUser:(User *)user;
- (IBAction)showQuestions:(id)sender;


@end