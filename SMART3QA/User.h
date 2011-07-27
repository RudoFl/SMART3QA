#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSInteger userId, reputation;
    NSString *name, *location, *about;
    NSURL *url;
    NSDate *birthday, *created;
    UIImage *avatar;
}

- (void)setUserId:(NSInteger)input;
- (NSInteger) getUserId;

- (void)setReputation:(NSInteger)input;
- (NSInteger) getReputation;

- (void) setName:(NSString *)input;
- (NSString *) getName;

- (void) setLocation:(NSString *)input;
- (NSString *) getLocation;

- (void) setAbout:(NSString *)input;
- (NSString *) getAbout;

- (void) setUrl:(NSURL *)input;
- (NSURL *) getUrl;

- (void) setBirthday:(NSDate *)input;
- (NSDate *) getBirthday;

- (void) setCreated:(NSDate *)input;
- (NSDate *) getCreated;

- (void) setAvatar:(UIImage *)input;
- (UIImage *) getAvatar;

@end