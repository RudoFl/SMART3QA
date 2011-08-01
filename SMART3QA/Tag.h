#import <Foundation/Foundation.h>

@interface Tag : NSObject
{
    NSInteger tagId, questionCount;
    NSString *name, *excert, *wiki;
}

- (void)setTagId:(NSInteger)input;
- (NSInteger)getTagId;

- (void)setQuestionCount:(NSInteger)input;
- (NSInteger)getQuestionCount;

- (void)setName:(NSString *)input;
- (NSString *)getName;

- (void)setExcert:(NSString *)input;
- (NSString *)getExcert;

- (void)setWiki:(NSString *)input;
- (NSString *)getWiki;

@end