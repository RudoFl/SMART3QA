#import "QuestionDetailsController.h"
#import "UserDetailsController.h"
#import "Question.h"

@implementation QuestionDetailsController

- (void)viewDidLoad
{   
    [super viewDidLoad];
    app = (SMART3QAAppDelegate *)[[UIApplication sharedApplication] delegate];
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
    
    [tagsLabel setText:[app getTagsForQuestion:question]];
    
    NSString *userName = [[app getUserForId:[question getUserId]] getName];
    NSString *date = [app stringFromDate:[question getCreated]];
    NSString *userButtonTitle = [[userName stringByAppendingString:@", "] stringByAppendingString:date];
    [userButton setTitle:userButtonTitle forState:UIControlStateNormal];
    [userButton setTitle:userButtonTitle forState:UIControlStateSelected];
    
    thisquestion = question;
    
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, bodyLabel.frame.origin.y + bodyLabel.frame.size.height)];
    [titleBar addSubview:titleLabel];
    [titleBar addSubview:tagsImage];
    [titleBar addSubview:tagsLabel];
    
    [userButton.imageView setImage:[app resizeImage:[UIImage imageNamed:@"tags.png"] scaleToSize:CGSizeMake(14, 14)]];
    [userButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];  
}

- (IBAction)viewUser:(id)sender
{
    UserDetailsController *userView = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetails"];
    [self.navigationController pushViewController:userView animated:YES];
    User *user = [app getUserForId:[thisquestion getUserId]];
    [userView loadUser:user];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end