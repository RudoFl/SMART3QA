#import "QuestionViewController.h"
#import "Question.h"

@implementation QuestionViewController

@synthesize idLabel, acceptedAnswerLabel, userIdLabel, titleLabel, bodyLabel, createdLabel;

- (void)loadQuestion:(Question *)question
{
    //[idLabel setText:[NSString stringWithFormat:@"%d", [question getQuestionId]]];
    //[acceptedAnswerLabel setText:[NSString stringWithFormat:@"%d", [question getAcceptedAnswer]]];
    [userIdLabel setText:[NSString stringWithFormat:@"%d", [question getUserId]]];
    [titleLabel setText:[question getTitle]];
    //[bodyLabel setText:[question getBody]];
    //[createdLabel setText:[question getCreated]];
}

@end