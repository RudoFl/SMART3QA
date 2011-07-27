#import <UIKit/UIKit.h>

@interface UserViewCell : UITableViewCell {
    UILabel *nameLabel, *locationLabel, *reputationLabel;
    UIImageView *avatar;
}

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *locationLabel;
@property (nonatomic, retain) UILabel *reputationLabel;
@property (nonatomic, retain) UIImageView *avatar;

@end