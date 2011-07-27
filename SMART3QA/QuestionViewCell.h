#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h"

@interface QuestionViewCell : UITableViewCell
{
    UILabel *titleLabel, *userLabel, *answerCountLabel, *createdLabel;
    UIImageView *questionImage, *tableDividerImage;
    SMART3QAAppDelegate *app;
}

- (void)loadQuestion:(Question *)question;

@end