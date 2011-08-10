#import "UserDetailsController.h"
#import "User.h"
#import "SMART3QAAppDelegate.h"
#import "QuestionsViewController.h"
#import "ImageViewController.h"
#import "WebViewController.h"

@implementation UserDetailsController

- (void)loadUser:(User *)user
{
    app = (SMART3QAAppDelegate*) [[UIApplication sharedApplication] delegate];
    [app downloadDataForUser:[user getUserId]];
    thisuser = user;
    [self setTitle:@"User"];
    NSArray *general = [[NSArray alloc] initWithObjects:[thisuser getName], [thisuser getAbout], [thisuser getAvatar], nil];
    NSArray *location = [[NSArray alloc] initWithObjects:[thisuser getLocation], nil];
    NSArray *website = [[NSArray alloc] initWithObjects:[thisuser getUrl], nil];
    NSMutableArray *socialnetworks = [NSMutableArray arrayWithCapacity:3];
    if([[NSString stringWithFormat:@"%@", [user getTwitterUrl]] rangeOfString:@"twitter"].location != NSNotFound)
    {
        [socialnetworks addObject:[user getTwitterUrl]];
    }
    if([[NSString stringWithFormat:@"%@", [user getFacebookUrl]] rangeOfString:@"facebook"].location != NSNotFound)
    {
        [socialnetworks addObject:[user getFacebookUrl]];
    }
    if([[NSString stringWithFormat:@"%@", [user getGoogleUrl]] rangeOfString:@"google"].location != NSNotFound)
    {
        [socialnetworks addObject:[user getGoogleUrl]];
    }
    
    userData = [[NSDictionary alloc] initWithObjectsAndKeys:general, @"", location, @"Location", website, @"Website", socialnetworks, @"Social Networks", nil];
    sortedKeys = [[userData allKeys] copy];
    [general release];
    [location release];
    [website release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *questionsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"questions.png"]
                                                                        style:UIBarButtonItemStyleBordered 
                                                                       target:self 
                                                                       action:@selector(showQuestions:)];
    self.navigationItem.rightBarButtonItem = questionsButton;
    [questionsButton release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sortedKeys count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([[userData objectForKey:[sortedKeys objectAtIndex:section]] count] == 0)
        return @"";
    return [sortedKeys objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    if(section == 0)
        return 1;
    NSArray *listData =[userData objectForKey:[sortedKeys objectAtIndex:section]];
    return [listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    NSArray *listData = [userData objectForKey:[sortedKeys objectAtIndex:[indexPath section]]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    NSUInteger row = [indexPath row];
    
    if (cell == nil)
    {
        if([indexPath section] == 0)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
            
            [cell.textLabel setText:[NSString stringWithFormat:@"%@", [thisuser getName]]];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", [thisuser getAbout]]];
            [cell.imageView setImage:[app resizeImage:[thisuser getAvatar] scaleToSize:CGSizeMake(30, 30)]];
        }
        else if([indexPath section] == 3)
        {
            NSString *content = [NSString stringWithFormat:@"%@", [listData objectAtIndex:row]];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
            if([content rangeOfString:@"twitter"].location != NSNotFound)
            {
                [cell.imageView setImage:[UIImage imageNamed:@"twitter.png"]];
                [cell.textLabel setText:@"Twitter"];
            }
            else if([content rangeOfString:@"facebook"].location != NSNotFound)
            {
                [cell.imageView setImage:[UIImage imageNamed:@"facebook.png"]];
                [cell.textLabel setText:@"Facebook"];
            }
            else if([content rangeOfString:@"google"].location != NSNotFound)
            {
                [cell.imageView setImage:[UIImage imageNamed:@"google.png"]];
                [cell.textLabel setText:@"Google"];
            }
        }
        else
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
            [cell.textLabel setText:[NSString stringWithFormat:@"%@", [listData objectAtIndex:row]]];
        }
    }
    return [cell autorelease];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    if(section == 0)
    {
        ImageViewController *imageViewer = [[ImageViewController alloc] initWithNibName:@"ImageView" bundle:nil];
        [self.navigationController pushViewController:imageViewer animated:YES];
        [imageViewer setTitle:[thisuser getName]];
        [imageViewer loadImage:[thisuser getAvatar]];
        [imageViewer release];
    }
    else if(section == 1)
    {
        WebViewController *webView = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        [self.navigationController pushViewController:webView animated:YES];
        [webView loadWebpageFromString:[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", [thisuser getLocation]]];
        [webView release];
    }
    else if(section == 2)
    {
        WebViewController *webView = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        [self.navigationController pushViewController:webView animated:YES];
        [webView loadWebpageFromString:[NSString stringWithFormat:@"%@", [thisuser getUrl]]];
        [webView release];
    }
    else if(section == 3)
    {
        NSArray *listData = [userData objectForKey:[sortedKeys objectAtIndex:3]];
        NSString *url = [listData objectAtIndex:row];
        WebViewController *webView = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        [self.navigationController pushViewController:webView animated:YES];
        [webView loadWebpageFromString:url];
        [webView release];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)showQuestions:(id)sender
{
    QuestionsViewController *questionView = [[QuestionsViewController alloc] initWithNibName:@"QuestionsView" bundle:nil];
    [self.navigationController pushViewController:questionView animated:YES];
    [questionView loadQuestionsForUserId:[thisuser getUserId]];
    [questionView release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end