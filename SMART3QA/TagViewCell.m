#import "TagViewCell.h"

@implementation TagViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        tagImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        tagImage.image = [UIImage imageNamed:@"questioncount.png"];
        [self.contentView addSubview:tagImage];
        
        questionCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [questionCountLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [questionCountLabel setBackgroundColor:[UIColor clearColor]];
        [questionCountLabel setTextAlignment:UITextAlignmentCenter];
        [questionCountLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:questionCountLabel];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:nameLabel];
        
        tableDividerImage = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 39, 640, 1)];
        tableDividerImage.image = [UIImage imageNamed:@"tabledivider.png"];
        [self.contentView addSubview:tableDividerImage];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect countRect = self.contentView.bounds;
    countRect.origin.x = 4;
    countRect.origin.y = 4;
    countRect.size.width = 32;
    countRect.size.height = 32;
    tagImage.frame = countRect;
    questionCountLabel.frame = countRect;
    
    CGRect nameRect = self.contentView.bounds;
    nameRect.origin.x = countRect.origin.x + countRect.size.width + 5;
    nameRect.origin.y = countRect.origin.y;
    nameRect.size.width = 280;
    nameRect.size.height = 30;
    nameLabel.frame = nameRect;
}

- (void)loadTag:(Tag *)tag
{    
    [nameLabel setText:[tag getName]];
    [questionCountLabel setText:[NSString stringWithFormat:@"%d",[tag getQuestionCount]]];
}

@end