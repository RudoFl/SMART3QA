#import "QuestionViewController.h"
#import "Question.h"

@implementation QuestionViewController

- (void)setup
{   
    self.view.backgroundColor = [UIColor redColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 
                                                          5, 
                                                          200, 
                                                          30)];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:titleLabel];
}

- (void)loadQuestion:(Question *)question
{
    [self setTitle:[question getTitle]];
    [titleLabel setText:[question getTitle]];
}

@end