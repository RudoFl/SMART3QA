#import <UIKit/UIKit.h>
#import "Question.h"
#import "SMART3QAAppDelegate.h"

@interface QuestionDetailsController : UIViewController {
    UILabel *titleLabel, *bodyLabel;
    SMART3QAAppDelegate *app;
}

- (void)setup;
- (void)loadQuestion:(Question *)question;

@end