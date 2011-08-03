#import <UIKit/UIKit.h>
#import "Tag.h"

@interface TagViewCell : UITableViewCell {
    UILabel *nameLabel, *questionCountLabel, *excerptLabel;
    UIImageView *tagImage, *tableDividerImage;
}

- (void)loadTag:(Tag *)tag;

@end