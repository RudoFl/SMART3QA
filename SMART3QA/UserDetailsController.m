#import "UserDetailsController.h"
#import "User.h"
#import "SMART3QAAppDelegate.h"
#import "QuestionsViewController.h"

@implementation UserDetailsController

- (void)loadUser:(User *)user
{
    app = (SMART3QAAppDelegate*)[[UIApplication sharedApplication]delegate];
    [app downloadDataForUser:[user getUserId]];
    [self setTitle:[user getName]];
    
    [avatarView setImage:[app resizeImage:[user getAvatar] scaleToSize:CGSizeMake(100, 100)]];
    [profileLabel setText:[user getProfile]];
    [nameLabel setText:[user getName]];
    [aboutLabel setText:[user getAbout]];
    [createdLabel setText:[@"Member for " stringByAppendingString:[app timeSinceDate:[user getCreated]]]];
    [locationButton setTitle:[user getLocation] forState:UIControlStateNormal];
    [locationButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [urlButton setTitle:[NSString stringWithFormat:@" %@", [user getUrl]] forState:UIControlStateNormal];
    [urlButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [userQuestions setTitle:[NSString stringWithFormat:@"Questions by %@",[user getName]] forState:UIControlStateNormal];
    
    CGRect avatarRect = avatarView.frame;
    avatarRect.size.height = avatarRect.size.width;
    avatarView.frame = avatarRect;
    
    thisuser = user;
}

- (IBAction)loadTwitter:(id)sender
{
    [[UIApplication sharedApplication] openURL:[thisuser getTwitterUrl]];
}

- (IBAction)loadGoogle:(id)sender
{
    [[UIApplication sharedApplication] openURL:[thisuser getGoogleUrl]];
}

- (IBAction)loadFacebook:(id)sender
{
    [[UIApplication sharedApplication] openURL:[thisuser getFacebookUrl]];
}

- (IBAction)loadUrl:(id)sender
{
    /*
     this should be
     [[UIApplication sharedApplication] openURL:[thisuser getUrl]];
     */
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [thisuser getUrl]]]];
}

- (IBAction)loadLocation:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", [thisuser getLocation]]]];
}

- (IBAction)showQuestions:(id)sender
{
    QuestionsViewController *questionView = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionsView"];
    [self.navigationController pushViewController:questionView animated:YES];
    [questionView loadQuestionsForUserId:[thisuser getUserId]];
}

@end