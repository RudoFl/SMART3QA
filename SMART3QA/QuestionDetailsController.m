#import "QuestionDetailsController.h"
#import "CommentViewController.h"
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
    [self setTitle:@"Question"];
    [titleLabel setText:[question getTitle]];
    [bodyLabel setText:[question getBody]];
    CGSize labelsize = [[question getBody] sizeWithFont:bodyLabel.font 
                                      constrainedToSize:CGSizeMake(bodyLabel.frame.size.width, 9999) 
                                          lineBreakMode:bodyLabel.lineBreakMode];
    CGRect bodyRect = bodyLabel.frame;
    bodyRect.size.height = labelsize.height;
    bodyLabel.frame = bodyRect;
    [bodyLabel setNumberOfLines:labelsize.height / bodyLabel.font.lineHeight];
    
    UIButton *bodyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bodyButton.frame = bodyLabel.frame;
    [bodyButton addTarget:self action:@selector(viewComments:) forControlEvents:UIControlEventTouchUpInside];
    bodyButton.tag = -1;
    [scrollView addSubview:bodyButton];
    
    [tagsLabel setText:[app getTagsForQuestion:question]];
    
    NSString *userName = [[app getUserForId:[question getUserId]] getName];
    NSString *date = [app stringFromDate:[question getCreated]];
    NSString *userButtonTitle = [[userName stringByAppendingString:@", "] stringByAppendingString:date];
    [userButton setTitle:userButtonTitle forState:UIControlStateNormal];
    [userButton setTitle:userButtonTitle forState:UIControlStateSelected];
    [userButton addTarget:self action:@selector(viewUser:) forControlEvents:UIControlEventTouchUpInside];
    userButton.tag = [question getUserId];
    
    CGRect answerRect = CGRectMake(0, bodyRect.origin.y + bodyRect.size.height + 5, 320, 0);
    NSInteger index = 0;
    for(NSDictionary *answer in [question getAnswers])
    {
        UIView *answerView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UIImageView *tableDividerImage = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 640, 1)];
        tableDividerImage.image = [UIImage imageNamed:@"tabledivider.png"];
        [answerView addSubview:tableDividerImage];
        
        UIButton *answerUserButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [answerUserButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        answerUserButton.frame = CGRectMake(0, 2, userButton.frame.size.width, userButton.frame.size.height);
        userName = [[app getUserForId:[[answer objectForKey:@"user_id"] intValue]] getName];
        if([answer objectForKey:@"created"] == [NSNull null])
        {
            date = @"";
            userButtonTitle = userName;
        }
        else
        {
            date = [answer objectForKey:@"created"];
            userButtonTitle = [[userName stringByAppendingString:@", "] stringByAppendingString:date];
        }
        [answerUserButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [answerUserButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [answerUserButton setImage:[UIImage imageNamed:@"users.png"] forState:UIControlStateNormal];
        [answerUserButton setImage:[UIImage imageNamed:@"users.png"] forState:UIControlStateSelected];
        [answerUserButton setTitle:userButtonTitle forState:UIControlStateNormal];
        [answerUserButton setTitle:userButtonTitle forState:UIControlStateSelected];
        [answerUserButton addTarget:self action:@selector(viewUser:) forControlEvents:UIControlEventTouchUpInside];
        answerUserButton.tag = [[answer objectForKey:@"user_id"] intValue];
        [answerView addSubview:answerUserButton];
                
        UILabel *answerBodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [answerBodyLabel setFont:bodyLabel.font];
        [answerBodyLabel setLineBreakMode:[bodyLabel lineBreakMode]];
        labelsize = [[answer objectForKey:@"body"] sizeWithFont:answerBodyLabel.font 
                                   constrainedToSize:CGSizeMake(310, 9999) 
                                       lineBreakMode:answerBodyLabel.lineBreakMode];
        answerBodyLabel.frame = CGRectMake(5, answerUserButton.frame.origin.y + answerUserButton.frame.size.height + 5, 310, labelsize.height);
        [answerBodyLabel setNumberOfLines:labelsize.height / answerBodyLabel.font.lineHeight];
        [answerBodyLabel setText:[answer objectForKey:@"body"]];
        [answerView addSubview:answerBodyLabel];
        
        UIButton *answerBodyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        answerBodyButton.frame = answerBodyLabel.frame;
        [answerBodyButton addTarget:self action:@selector(viewComments:) forControlEvents:UIControlEventTouchUpInside];
        answerBodyButton.tag = index;
        [answerView addSubview:answerBodyButton];
        
        answerRect.size.height = answerBodyLabel.frame.origin.y + answerBodyLabel.frame.size.height + 5;
        answerView.frame = answerRect;
        [scrollView addSubview:answerView];
        answerRect.origin.y += answerRect.size.height;
        
        index++;
    }
    
    thisquestion = question;
    
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, answerRect.origin.y)];
    [titleBar addSubview:titleLabel];
    [titleBar addSubview:tagsImage];
    [titleBar addSubview:tagsLabel];
    
    [userButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
}

- (IBAction)viewUser:(id)sender;
{
    UserDetailsController *userView = [[UserDetailsController alloc] initWithNibName:@"UserDetailsView" bundle:nil];
    [self.navigationController pushViewController:userView animated:YES];
    User *user = [app getUserForId:((UIControl*)sender).tag];
    [userView loadUser:user];
}

- (IBAction)viewComments:(id)sender
{
    CommentViewController *commentView = [[CommentViewController alloc] initWithNibName:@"CommentView" bundle:nil];
    [self.navigationController pushViewController:commentView animated:YES];
    NSInteger tag = ((UIControl*)sender).tag;
    if(tag == -1)
        [commentView loadComments:[thisquestion getComments]];
    else
    {
        NSDictionary *answer = [[thisquestion getAnswers] objectAtIndex:tag];
        [commentView loadComments:[answer objectForKey:@"comments"]];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end