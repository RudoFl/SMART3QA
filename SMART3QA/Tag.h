#import <Foundation/Foundation.h>

@interface Tag : NSObject
{
    NSInteger tagId, questionCount;
    NSString *name, *excerpt, *wiki;
}

- (void)setTagId:(NSInteger)input;
- (NSInteger)getTagId;

- (void)setQuestionCount:(NSInteger)input;
- (NSInteger)getQuestionCount;

- (void)setName:(NSString *)input;
- (NSString *)getName;

- (void)setExcerpt:(NSString *)input;
- (NSString *)getExcerpt;

- (void)setWiki:(NSString *)input;
- (NSString *)getWiki;

@end