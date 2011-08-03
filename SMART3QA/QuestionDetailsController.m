#import "QuestionDetailsController.h"
#import "Question.h"

@implementation QuestionDetailsController

- (void)viewDidLoad
{   
    [super viewDidLoad];
    app = (SMART3QAAppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)loadQuestion:(Question *)question
{
    [app downloadDataForQuestion:[question getQuestionId]];
    [self setTitle:[question getTitle]];
    [titleLabel setText:[question getTitle]];
    [bodyLabel setText:[question getBody]];
    CGSize labelsize = [[question getBody] sizeWithFont:bodyLabel.font 
                                      constrainedToSize:CGSizeMake(bodyLabel.frame.size.width, 9999) 
                                          lineBreakMode:titleLabel.lineBreakMode];
    CGRect bodyRect = bodyLabel.frame;
    bodyRect.size.height = labelsize.height;
    bodyLabel.frame = bodyRect;
    [bodyLabel setNumberOfLines:labelsize.height / bodyLabel.font.lineHeight];
    
    NSString *tagString = @"";
    for(int i = 0; i < [[question getTags] count]; i++)
    {
        NSString *tagId = [[question getTags]objectAtIndex:i];
        NSString *tagName = [[app getTagForId:[tagId intValue]] getName];
        tagString = [tagString stringByAppendingString:tagName];
        tagString = [tagString stringByAppendingString:@" "];
    }
    [tagsLabel setText:tagString];
    
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, bodyLabel.frame.origin.y + bodyLabel.frame.size.height)];
}

@end