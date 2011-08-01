#import <UIKit/UIKit.h>
#import "Tag.h"
#import "SMART3QAAppDelegate.h"

@interface TagDetailsController : UIViewController {
    UILabel *titleLabel, *excertLabel;
    SMART3QAAppDelegate *app;
}

- (void)setup;
- (void)loadTag:(Tag *)tag;

@end