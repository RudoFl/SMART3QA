#import <UIKit/UIKit.h>
#import "Question.h"
#import "SMART3QAAppDelegate.h"

@interface QuestionDetailsController : UIViewController {
    IBOutlet UILabel *titleLabel, *bodyLabel, *tagsLabel;
    IBOutlet UIScrollView *scrollView;
    SMART3QAAppDelegate *app;
}

- (void)loadQuestion:(Question *)question;

@end