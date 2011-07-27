#import "UserViewCell.h"

@implementation UserViewCell

@synthesize nameLabel, locationLabel, reputationLabel, avatar;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        avatar = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:avatar];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:nameLabel];
        
        locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [locationLabel setFont:[UIFont systemFontOfSize:12]];
        [locationLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:locationLabel];
        
        reputationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [reputationLabel setFont:[UIFont systemFontOfSize:12]];
        [reputationLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:reputationLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect contentRect = self.contentView.bounds;
    
    CGRect avatarRect = contentRect;
    avatarRect.origin.x = avatarRect.origin.x + 5;
    avatarRect.origin.y = avatarRect.origin.y + 5;
    avatarRect.size.height = 60;
    avatarRect.size.width = 60;
    avatar.frame = avatarRect;
    
    CGRect nameRect = contentRect;
    nameRect.origin.x = nameRect.origin.x + 70;
    nameRect.origin.y = nameRect.origin.y - 2;
    nameRect.size.height = 30;
    nameRect.size.width = 200;
    nameLabel.frame = nameRect;
    
    CGRect locationRect = contentRect;
    locationRect.origin.x = locationRect.origin.x + 70;
    locationRect.origin.y = locationRect.origin.y + 15;
    locationRect.size.width = 200;
    locationRect.size.height = 30;
    locationLabel.frame = locationRect;
    
    CGRect reputationRect = contentRect;
    reputationRect.origin.x = contentRect.origin.x + 70;
    reputationRect.origin.y = contentRect.origin.y + 32;
    reputationRect.size.width = 200;
    reputationRect.size.height = 30;
    reputationLabel.frame = reputationRect;
}

@end