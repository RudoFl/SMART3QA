#import "SMART3QAAppDelegate.h"
#import "SBJSON/SBJson.h"
#import "Question.h"
#import "User.h"
#import "Tag.h"

@implementation SMART3QAAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    hostname = [[NSString alloc]initWithString:@"http://192.168.1.103"]; //wifi ruud
    //hostname = [[NSString alloc]initWithString:@"http://192.168.0.10"]; //wifi upc
    //hostname = [[NSString alloc]initWithString:@"http://192.168.0.27"]; //kabel zolder
    //hostname = [[NSString alloc]initWithString:@"http://vanderwerf.xs4all.nl"];
    //hostname = [[NSString alloc]initWithString:@"http://smart3.fhict.com"];
    NSLog(@"Download/Parsing started");
    [self downloadQuestions];
    NSLog([NSString stringWithFormat:@"Questions done(%d)", [questions count]]);
    [self downloadUsers];
    NSLog([NSString stringWithFormat:@"Users done(%d)", [users count]]);
    [self downloadTags];
    NSLog([NSString stringWithFormat:@"Tags done(%d)", [tags count]]);
    NSLog(@"Download/Parsing finished");
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (UIImage *)downloadImage:(NSURL *)url
{
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:url];
    if(imageData == nil)
        return nil;
    UIImage *image = [[UIImage alloc]initWithData:imageData];
    
    return image;
}

- (UIImage *)resizeImage:(UIImage *)image scaleToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter alloc];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (NSDate *)dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormatter = [NSDateFormatter alloc];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *stringDate = [dateFormatter dateFromString:string];
    return stringDate;
}

- (NSString *)timeSinceDate:(NSDate *)date
{
    int interval = [date timeIntervalSinceNow];
    int seconds = -interval;
    int minutes = seconds / 60;
    int hours = seconds / 3600;
    int days = seconds / 86400;
    int weeks = seconds / 604800;
    if(weeks > 0)
    {
        return [NSString stringWithFormat:@"%d weeks", weeks];
    } else if(days > 0)
    {
        return [NSString stringWithFormat:@"%d days", days];
    } else if(hours > 0)
    {
        return [NSString stringWithFormat:@"%d hours", hours];
    } else if(minutes > 0)
    {
        return [NSString stringWithFormat:@"%d minutes", minutes];
    } else
    {
        return [NSString stringWithFormat:@"%d seconds", seconds];
    }
}

- (void)downloadQuestions
{
    NSString *myRawJSON = [[NSString alloc]initWithContentsOfURL:[[NSURL alloc] initWithString:[hostname stringByAppendingString:@"/QA/questions.json"]] encoding:NSUTF8StringEncoding error:nil];
    
    if ([myRawJSON length] == 0) 
    {
        return;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    questions = [[parser objectWithString:myRawJSON error:nil] copy];
    
    NSMutableArray *parsedQuestions = [NSMutableArray array];
    for (NSDictionary *dict in questions)
    {
        Question *newQuestion = [[Question alloc]init];
        [newQuestion setQuestionId:[[dict objectForKey:@"id"] intValue]];
        [newQuestion setTitle:[dict objectForKey:@"title"]];
        [newQuestion setUserId: [[dict objectForKey:@"user_id"] intValue]];
        [newQuestion setAnswerCount:[[dict objectForKey:@"answer_count"] intValue]];
        [newQuestion setTags:[dict objectForKey:@"tags"]];
        [parsedQuestions addObject:newQuestion];
    }
    questions = [parsedQuestions copy];
}

- (void)downloadDataForQuestion:(NSInteger)questionId
{
    NSString *myRawJSON = [[NSString alloc]initWithContentsOfURL:[[NSURL alloc] 
                                                                  initWithString:[hostname 
                                                                                  stringByAppendingString:[NSString stringWithFormat:@"/QA/questions/view.json?id=%d", questionId]]] 
                                                        encoding:NSUTF8StringEncoding 
                                                           error:nil];
    
    if ([myRawJSON length] == 0) 
    {
        return;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSArray *questionData = [[parser objectWithString:myRawJSON error:nil] copy];    
    for (NSDictionary *dict in questionData)
    {
        Question *selectedQuestion = [self getQuestionForId:questionId];
        [selectedQuestion setCreated:[self dateFromString:[dict objectForKey:@"created"]]];
        [selectedQuestion setBody:[dict objectForKey:@"body"]];
        [selectedQuestion setAnswerCount:[[dict objectForKey:@"answer_count"] intValue]];
        if([dict objectForKey:@"comments"] != [NSNull null])
        {
            [selectedQuestion setComments:[dict objectForKey:@"comments"]];
        }
        if([dict objectForKey:@"answers"] != [NSNull null])
        {
            [selectedQuestion setAnswers:[dict objectForKey:@"answers"]];
        }
    }
}

- (NSArray *)getQuestions
{
    return questions;
}

- (NSArray *)getQuestionsForUser:(NSInteger)userId
{
    NSMutableArray *questionsForUser = [[NSMutableArray alloc] initWithCapacity:[questions count]];
    for(Question *q in questions)
    {
        if([q getUserId] == userId)
        {
            [questionsForUser addObject:q];
        }
    }
    return [questionsForUser copy];
}

- (NSArray *)getQuestionsForTag:(NSInteger)tagId
{
    NSMutableArray *questionsForTag = [[NSMutableArray alloc] initWithCapacity:[questions count]];
    for(Question *q in questions)
    {
        for(int i = 0; i < [[q getTags] count]; i++)
        {
            if([[[q getTags] objectAtIndex:i] intValue] == tagId)
            {
                [questionsForTag addObject:q];
                break;
            }
        }
    }
    return [questionsForTag copy];
}

- (Question *)getQuestionForId:(NSInteger)questionId
{
    for(Question *q in questions){
        if([q getQuestionId] == questionId)
        {
            return q;
        }
    }
    return nil;
}

- (Question *)getQuestionForIndex:(NSInteger)index
{
    return [questions objectAtIndex:index];
}

- (void)downloadUsers
{
    NSString *myRawJSON = [[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:[hostname stringByAppendingString:@"/QA/users.json"]] encoding:NSUTF8StringEncoding error:nil];
    
    if ([myRawJSON length] == 0) 
    {
        return;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    users = [[parser objectWithString:myRawJSON error:nil] copy];
    
    NSMutableArray *parsedUsers = [NSMutableArray array];
    for (NSDictionary *dict in users)
    {
        User *newUser = [[User alloc]init];
        if ([dict objectForKey:@"id"] != [NSNull null]) 
        {
            [newUser setUserId:[[dict objectForKey:@"id"] intValue]];
        }
        if ([dict objectForKey:@"name"] != [NSNull null]) 
        {
            [newUser setName:[dict objectForKey:@"name"]];
        }
        if([dict objectForKey:@"location"] != [NSNull null])
        {
            [newUser setLocation:[dict objectForKey:@"location"]];
        }
        if ([dict objectForKey:@"avatar"] != [NSNull null]) 
        {
            NSString *avatarURL = [[NSString alloc] initWithFormat:@"%@", [dict objectForKey:@"avatar"]];
            [newUser setAvatar:[self downloadImage:[[NSURL alloc] initWithString:avatarURL]]];
        }
        if ([dict objectForKey:@"reputation_sum"] != [NSNull null]) {
            [newUser setReputation:[[dict objectForKey:@"reputation_sum"] intValue]];
        }
        
        [parsedUsers addObject:newUser];
    }
    
    users = [parsedUsers copy];
}

- (void)downloadDataForUser:(NSInteger)userId
{
    NSString *myRawJSON = [[NSString alloc]initWithContentsOfURL:[[NSURL alloc] 
                                                                  initWithString:[hostname 
                                                                                  stringByAppendingString:[NSString stringWithFormat:@"/QA/users/view.json?id=%d", userId]]] 
                                                        encoding:NSUTF8StringEncoding 
                                                           error:nil];
    
    if ([myRawJSON length] == 0) 
    {
        return;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSArray *userData = [[parser objectWithString:myRawJSON error:nil] copy];
    
    for (NSDictionary *dict in userData)
    {
        User *selectedUser = [self getUserForId:userId];
        [selectedUser setCreated:[self dateFromString:[dict objectForKey:@"created"]]];
        if(([dict objectForKey:@"twitterurl"] != [NSNull null]))
        {
            [selectedUser setTwitterUrl:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@", [dict objectForKey:@"twitterurl"]]]];
        }
        if(([dict objectForKey:@"googleurl"] != [NSNull null]))
        {
            [selectedUser setGoogleUrl:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@", [dict objectForKey:@"googleurl"]]]];
        }
        if(([dict objectForKey:@"facebookurl"] != [NSNull null]))
        {
            [selectedUser setFacebookUrl:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@", [dict objectForKey:@"facebookurl"]]]];
        }
        if([dict objectForKey:@"about_me"] != [NSNull null])
        {
            [selectedUser setAbout:[dict objectForKey:@"about_me"]];
        }
        if([dict objectForKey:@"profile"] != [NSNull null])
        {
            [selectedUser setProfile:[dict objectForKey:@"profile"]];
        }
        if([dict objectForKey:@"url"] != [NSNull null])
        {
            [selectedUser setUrl:[dict objectForKey:@"url"]];
        }
    }
}

- (NSArray *)getUsers
{
    return users;
}

- (User *)getUserForId:(NSInteger)userid
{
    for(User *u in users)
    {
        if([u getUserId] == userid)
        {
            return u;
        }
    }
    return nil;
}

- (Tag *)getUserForIndex:(NSInteger)index
{
    return [users objectAtIndex:index];    
}

- (void)downloadTags
{
    NSString *myRawJSON = [[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:[hostname stringByAppendingString:@"/QA/tags.json"]] encoding:NSUTF8StringEncoding error:nil];
    
    if ([myRawJSON length] == 0) 
    {
        return;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    tags = [[parser objectWithString:myRawJSON error:nil] copy];
    
    NSMutableArray *parsedTags = [NSMutableArray array];
    for (NSDictionary *dict in tags)
    {
        Tag *newTag = [[Tag alloc]init];
        [newTag setTagId:[[dict objectForKey:@"id"] intValue]];
        [newTag setName:[dict objectForKey:@"name"]];
        
        //TODO: questioncount
        //if([dict objectForKey:@"question_count"] == [NSNull null])
        //{
            [newTag setQuestionCount:0];
        /*}
        else
        {
            [newTag setQuestionCount:[[dict objectForKey:@"question_count"] intValue]];
        }*/
        [parsedTags addObject:newTag];
        if([dict objectForKey:@"excerpt"] != [NSNull null])
        {
            [newTag setExcerpt:[dict objectForKey:@"excerpt"]];
        } else {
            [newTag setExcerpt:@""];
        }
    }
    
    tags = [parsedTags copy];
}

- (void)downloadDataForTag:(NSInteger)tagId
{
    NSString *myRawJSON = [[NSString alloc]initWithContentsOfURL:[[NSURL alloc] 
                                                                  initWithString:[hostname 
                                                                                  stringByAppendingString:[NSString stringWithFormat:@"/QA/tags/view.json?id=%d", tagId]]] 
                                                        encoding:NSUTF8StringEncoding 
                                                           error:nil];
    
    if ([myRawJSON length] == 0) 
    {
        return;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSArray *tagData = [[parser objectWithString:myRawJSON error:nil] copy];    
    for (NSDictionary *dict in tagData)
    {
        Tag *selectedTag = [self getTagForId:tagId];
        if([dict objectForKey:@"wiki"] != [NSNull null])
        {
            [selectedTag setWiki:[dict objectForKey:@"wiki"]];
        }
    }
}


- (NSArray *)getTags
{
    return tags;
}

- (Tag *)getTagForId:(NSInteger)tagid
{
    for(Tag *t in tags)
    {
        if([t getTagId] == tagid)
        {
            return t;
        }
    }
    return nil;
}

- (Tag *)getTagForIndex:(NSInteger)index
{
    return [tags objectAtIndex:index];
}

- (NSString *)getTagsForQuestion:(Question *)question
{
    NSString *tagString = @"";
    for(int i = 0; i < [[question getTags] count]; i++)
    {
        NSString *tagId = [[question getTags]objectAtIndex:i];
        NSString *tagName = [[self getTagForId:[tagId intValue]] getName];
        tagString = [tagString stringByAppendingString:tagName];
        tagString = [tagString stringByAppendingString:@" "];
    }
    return tagString;
}

- (void)describeDictionary:(NSDictionary *)dict
{ 
    NSArray *keys;
    int i, count;
    id key, value;
    
    keys = [dict allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [dict objectForKey: key];
        NSLog (@"Key: %@ for value: %@", key, value);
    }
}


@end
