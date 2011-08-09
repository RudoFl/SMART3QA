#import "CommentViewController.h"
#import "SMART3QAAppDelegate.h"
#import "UserDetailsController.h"

@implementation CommentViewController

- (void)loadComments:(NSArray *) comments
{
    app = (SMART3QAAppDelegate *)[[UIApplication sharedApplication]delegate];
    [self setTitle:@"Comments"];
    CGRect commentRect = CGRectMake(0, 0, 320, 0);
    for(NSDictionary *comment in comments)
    {
        UIView *commentView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UIImageView *tableDividerImage = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 640, 1)];
        tableDividerImage.image = [UIImage imageNamed:@"tabledivider.png"];
        [commentView addSubview:tableDividerImage];
        
        UIButton *answerUserButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [answerUserButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        answerUserButton.frame = CGRectMake(0, 2, 320, 14);
        NSString *userName = [[app getUserForId:[[comment objectForKey:@"user_id"] intValue]] getName];
        NSString *date = @"";
        NSString *userButtonTitle = @"";
        if([comment objectForKey:@"created"] == [NSNull null])
        {
            userButtonTitle = userName;
        }
        else
        {
            date = [comment objectForKey:@"created"];
            userButtonTitle = [[userName stringByAppendingString:@", "] stringByAppendingString:date];
        }
        [answerUserButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [answerUserButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [answerUserButton setImage:[UIImage imageNamed:@"users.png"] forState:UIControlStateNormal];
        [answerUserButton setImage:[UIImage imageNamed:@"users.png"] forState:UIControlStateSelected];
        [answerUserButton setTitle:userButtonTitle forState:UIControlStateNormal];
        [answerUserButton setTitle:userButtonTitle forState:UIControlStateSelected];
        [answerUserButton addTarget:self action:@selector(viewUser:) forControlEvents:UIControlEventTouchUpInside];
        answerUserButton.tag = [[comment objectForKey:@"user_id"] intValue];
        [commentView addSubview:answerUserButton];
        
        UILabel *commentBodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [commentBodyLabel setFont:[UIFont systemFontOfSize:14]];
        [commentBodyLabel setLineBreakMode:UILineBreakModeWordWrap];
        CGSize labelsize = [[comment objectForKey:@"body"] sizeWithFont:commentBodyLabel.font 
                                              constrainedToSize:CGSizeMake(310, 9999) 
                                                  lineBreakMode:commentBodyLabel.lineBreakMode];
        commentBodyLabel.frame = CGRectMake(5, answerUserButton.frame.origin.y + answerUserButton.frame.size.height + 5, 310, labelsize.height);
        [commentBodyLabel setNumberOfLines:labelsize.height / commentBodyLabel.font.lineHeight];
        [commentBodyLabel setText:[comment objectForKey:@"body"]];
        [commentView addSubview:commentBodyLabel];
        
        commentRect.size.height = commentBodyLabel.frame.origin.y + commentBodyLabel.frame.size.height + 5;
        commentView.frame = commentRect;
        [scrollView addSubview:commentView];
        commentRect.origin.y += commentRect.size.height;
    }
    
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, commentRect.origin.y)];
}

- (IBAction)viewUser:(id)sender;
{
    UserDetailsController *userView = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetails"];
    [self.navigationController pushViewController:userView animated:YES];
    User *user = [app getUserForId:((UIControl*)sender).tag];
    [userView loadUser:user];
}

@end