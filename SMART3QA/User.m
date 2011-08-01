#import "User.h"

@implementation User

- (void)setUserId:(NSInteger)input
{
    userId = input;
}
- (NSInteger) getUserId
{
    return userId;
}

- (void)setReputation:(NSInteger)input
{
    reputation = input;
}
- (NSInteger) getReputation
{
    return reputation;
}

- (void) setName:(NSString *)input
{
    name = input;
}

- (NSString *) getName
{
    return name;
}

- (void) setLocation:(NSString *)input
{
    location = input;
}
- (NSString *) getLocation
{
    return location;
}

- (void) setAbout:(NSString *)input
{
    about = input;
}
- (NSString *) getAbout
{
    return about;
}

- (void) setProfile:(NSString *)input
{
    profile = input;
}
- (NSString *) getProfile
{
    return profile;
}

- (void) setUrl:(NSURL *)input
{
    url = input;
}
- (NSURL *) getUrl
{
    return url;
}

- (void) setTwitterUrl:(NSURL *)input
{
    twitterurl = input;
}
- (NSURL *) getTwitterUrl
{
    return twitterurl;
}

- (void) setGoogleUrl:(NSURL *)input
{
    googleurl = input;
}
- (NSURL *) getGoogleUrl
{
    return googleurl;
}

- (void) setFacebookUrl:(NSURL *)input
{
    facebookurl = input;
}
- (NSURL *) getFacebookUrl
{
    return facebookurl;
}

- (void) setBirthday:(NSDate *)input
{
    birthday = input;
}
- (NSDate *) getBirthday
{
    return birthday;
}

- (void) setCreated:(NSDate *)input
{
    created = input;
}
- (NSDate *) getCreated
{
    return created;
}

- (void) setAvatar:(UIImage *)input
{
    avatar = input;
}

- (UIImage *) getAvatar
{
    return avatar;
}

@end