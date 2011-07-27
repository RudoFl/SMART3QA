#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
#import "Question.h"

@interface QuestionViewController : UIViewController {
    UILabel *idLabel, *acceptedAnswerLabel, *userIdLabel, *titleLabel, *bodyLabel, *createdLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *idLabel;
@property (nonatomic, retain) IBOutlet UILabel *acceptedAnswerLabel;
@property (nonatomic, retain) IBOutlet UILabel *userIdLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *bodyLabel;
@property (nonatomic, retain) IBOutlet UILabel *createdLabel;

- (void)loadQuestion:(Question *)question;

@end