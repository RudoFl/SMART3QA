#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionViewController : UIViewController {
    UILabel *titleLabel;
}

- (void)setup;
- (void)loadQuestion:(Question *)question;

@end