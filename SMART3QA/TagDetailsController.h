#import <UIKit/UIKit.h>
#import "Tag.h"
#import "SMART3QAAppDelegate.h"

@interface TagDetailsController : UIViewController {
    IBOutlet UILabel *titleLabel, *excerptLabel, *wikiLabel;
    IBOutlet UIScrollView *scrollView;
    SMART3QAAppDelegate *app;
}

- (void)loadTag:(Tag *)tag;

@end