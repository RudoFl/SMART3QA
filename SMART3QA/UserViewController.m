#import "UserViewController.h"
#import "User.h"
#import "SMART3QAAppDelegate.h"

@implementation UserViewController

@synthesize nameLabel, locationLabel, aboutLabel, urlLabel, birthdayLabel, createdLabel, avatarView, global;

- (void)setup
{   
    global = (SMART3QAAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 100)];
    [self.view addSubview:avatarView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatarView.frame.origin.x + avatarView.frame.size.width + 10, 
                                                          5, 
                                                          200, 
                                                          30)];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:nameLabel];
    
    createdLabel = [[UILabel alloc]initWithFrame:CGRectMake(avatarView.frame.origin.x + avatarView.frame.size.width + 10,
                                                            nameLabel.frame.origin.y + nameLabel.frame.size.height,
                                                            200, 
                                                            20)];
    [createdLabel setFont:[UIFont systemFontOfSize:16]];
    [createdLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:createdLabel];
    
    UIImageView *locationImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location.png"]];
    locationImage.frame = CGRectMake(avatarView.frame.origin.x + avatarView.frame.size.width + 10, 
                                     createdLabel.frame.origin.y + createdLabel.frame.size.height, 
                                     locationImage.frame.size.width, 
                                     locationImage.frame.size.height);
    [self.view addSubview:locationImage];
                    
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationImage.frame.origin.x + locationImage.frame.size.width + 5, 
                                                              createdLabel.frame.origin.y + createdLabel.frame.size.height, 
                                                              200, 
                                                              20)];
    [locationLabel setFont:[UIFont systemFontOfSize:16]];
    [locationLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:locationLabel];
    
    UIImageView *twitterImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twitter.png"]];
    twitterImage.frame = CGRectMake(avatarView.frame.origin.x + avatarView.frame.size.width + 10, 
                                     locationImage.frame.origin.y + locationImage.frame.size.height + 5, 
                                     twitterImage.frame.size.width, 
                                     twitterImage.frame.size.height);
    [self.view addSubview:twitterImage];
    
    UIImageView *facebookImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facebook.png"]];
    facebookImage.frame = CGRectMake(twitterImage.frame.origin.x + twitterImage.frame.size.width + 10, 
                                     locationImage.frame.origin.y + locationImage.frame.size.height + 5, 
                                     facebookImage.frame.size.width, 
                                     facebookImage.frame.size.height);
    [self.view addSubview:facebookImage];
    
    UIImageView *googleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"google.png"]];
    googleImage.frame = CGRectMake(facebookImage.frame.origin.x + facebookImage.frame.size.width + 10, 
                                     locationImage.frame.origin.y + locationImage.frame.size.height + 5, 
                                     googleImage.frame.size.width, 
                                     googleImage.frame.size.height);
    [self.view addSubview:googleImage];
}

- (void)loadUser:(User *)user
{
    [self setTitle:[user getName]];
    [nameLabel setText:[user getName]];
    [createdLabel setText:[global stringFromDate:[user getCreated]]];
    [locationLabel setText:[user getLocation]];
    [avatarView setImage:[global resizeImage:[user getAvatar] scaleToSize:CGSizeMake(100, 100)]];
}

@end