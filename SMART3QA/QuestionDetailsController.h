#import <UIKit/UIKit.h>
#import "Question.h"
#import "SMART3QAAppDelegate.h"

@interface QuestionDetailsController : UIViewController {
    IBOutlet UILabel *titleLabel, *bodyLabel, *tagsLabel;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView *titleBar, *tagsImage;
    IBOutlet UIButton *userButton;
    Question *thisquestion;
    SMART3QAAppDelegate *app;
}

- (IBAction)viewUser:(id)sender;
- (IBAction)viewComments:(id)sender;

- (void)loadQuestion:(Question *)question;

@end