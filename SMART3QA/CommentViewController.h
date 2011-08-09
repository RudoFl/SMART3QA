#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h"

@interface CommentViewController : UIViewController {
    IBOutlet UIScrollView *scrollView;
    SMART3QAAppDelegate *app;
}

- (void)loadComments:(NSArray *) comments;
- (IBAction)viewUser:(id)sender;

@end