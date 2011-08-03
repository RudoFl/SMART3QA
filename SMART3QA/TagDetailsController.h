#import <UIKit/UIKit.h>
#import "Tag.h"
#import "SMART3QAAppDelegate.h"

@interface TagDetailsController : UIViewController {
    IBOutlet UILabel *titleLabel, *excerptLabel, *wikiLabel;
    IBOutlet UIScrollView *scrollView;
    Tag *thistag;
    SMART3QAAppDelegate *app;
}

- (void)loadTag:(Tag *)tag;
- (IBAction)showQuestions:(id)sender;

@end