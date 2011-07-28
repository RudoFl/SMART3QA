#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionDetailsController : UIViewController {
    UILabel *titleLabel, *bodyLabel;
}

- (void)setup;
- (void)loadQuestion:(Question *)question;

@end