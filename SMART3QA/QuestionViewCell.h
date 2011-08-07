#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h"

@interface QuestionViewCell : UITableViewCell
{
    UILabel *titleLabel, *answerCountLabel, *tagsLabel;
    UIImageView *questionImage, *tableDividerImage, *tagsImage;
    SMART3QAAppDelegate *app;
}

- (void)loadQuestion:(Question *)question;

@end