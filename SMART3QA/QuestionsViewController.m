#import "QuestionsViewController.h"
#import "Question.h"
#import "QuestionViewCell.h"
#import "QuestionDetailsController.h"

@implementation QuestionsViewController

- (void)viewDidLoad
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [super viewDidLoad];
    app = (SMART3QAAppDelegate*) [[UIApplication sharedApplication] delegate];
    questions = [app getQuestions];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    QuestionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[QuestionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell loadQuestion:[questions objectAtIndex:[indexPath row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionDetailsController *questionView = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionDetails"];
    [self.navigationController pushViewController:questionView animated:YES];
    [questionView loadQuestion:[questions objectAtIndex:[indexPath row]]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)loadQuestionsForUserId:(NSInteger)userId
{
    questions = [app getQuestionsForUser:userId];
}


- (void)loadQuestionsForTagId:(NSInteger)tagId
{    
    questions = [app getQuestionsForTag:tagId];
}

@end
