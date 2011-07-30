#import <UIKit/UIKit.h>
#import "Tag.h"

@interface TagViewCell : UITableViewCell {
    UILabel *nameLabel, *questionCountLabel;
    UIImageView *tagImage, *tableDividerImage;
}

- (void)loadTag:(Tag *)tag;

@end