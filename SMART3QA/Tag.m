#import "Tag.h"

@implementation Tag

- (void)setTagId:(NSInteger)input
{
    tagId = input;
}
- (NSInteger)getTagId
{
    return  tagId;
}

- (void)setQuestionCount:(NSInteger)input
{
    questionCount = input;
}
- (NSInteger)getQuestionCount
{
    return questionCount;
}

- (void)setName:(NSString *)input
{
    name = input;
}
- (NSString *)getName
{
    return name;
}

- (void)setExcerpt:(NSString *)input
{
    excerpt = input;
}

- (NSString *)getExcerpt
{
    return excerpt;
}

- (void)setWiki:(NSString *)input
{
    wiki = input;
}
- (NSString *)getWiki
{
    return wiki;
}

@end