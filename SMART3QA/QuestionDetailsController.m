#import "QuestionDetailsController.h"
#import "Question.h"

@implementation QuestionDetailsController

- (void)setup
{   
    self.view.backgroundColor = [UIColor whiteColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 30)];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:titleLabel];
    
    bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x,
                                                            titleLabel.frame.origin.y + titleLabel.frame.size.height + 5,
                                                                310,
                                                                0)];
    [bodyLabel setFont:[UIFont systemFontOfSize:12]];
    [bodyLabel setBackgroundColor:[UIColor clearColor]];
    [bodyLabel setLineBreakMode:UILineBreakModeWordWrap];
    [self.view addSubview:bodyLabel];
}

- (void)loadQuestion:(Question *)question
{
    [self setTitle:[question getTitle]];
    [titleLabel setText:[question getTitle]];
    [bodyLabel setText:[question getBody]];
    CGSize labelsize = [[question getBody] sizeWithFont:bodyLabel.font 
                                      constrainedToSize:CGSizeMake(310, 9999) 
                                          lineBreakMode:titleLabel.lineBreakMode];
    CGRect bodyRect = bodyLabel.frame;
    bodyRect.size.height = labelsize.height;
    bodyLabel.frame = bodyRect;
    [bodyLabel setNumberOfLines:labelsize.height / bodyLabel.font.lineHeight];
}

@end