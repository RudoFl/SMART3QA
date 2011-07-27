#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h";

@interface QuestionViewCell : UITableViewCell {
    UILabel *nameLabel, *locationLabel, *answerCountLabel;
    UIImageView *questionImage;
    UIImageView *avatar;
    SMART3QAAppDelegate* app;
}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *userIdLabel;
@property (nonatomic, retain) UILabel *answerCountLabel;
@property (nonatomic, retain) UIImageView *questionImage;
@property (nonatomic, retain) SMART3QAAppDelegate* app;

@end