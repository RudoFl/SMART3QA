//
//  SMART3QAAppDelegate.m
//  SMART3QA
//
//  Created by Ruud Puts on 7/19/11.
//  Copyright 2011 Fontys Hogeschool ICT. All rights reserved.
//

#import "SMART3QAAppDelegate.h"
#import "SBJSON/SBJson.h"
#import "Question.h"
#import "User.h"
#import "Tag.h"

@implementation SMART3QAAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    hostname = [[NSString alloc]initWithString:@"http://192.168.1.103"]; //wifi ruud
    hostname = [[NSString alloc]initWithString:@"http://192.168.0.10"]; //wifi upc
    //hostname = [[NSString alloc]initWithString:@"http://192.168.0.27"]; //kabel zolder
    //hostname = [[NSString alloc]initWithString:@"http://vanderwerf.xs4all.nl"];
    NSLog(@"Download/Parsing started");
    [self downloadQuestions];
    [self downloadUsers];
    [self downloadTags];
    NSLog(@"Download/Parsing finished");
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
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
    NSLog(@"QuestionsAfterDowload: %d", [questions count]);
    
    NSMutableArray *parsedQuestions = [NSMutableArray array];
    for (NSDictionary *dict in questions)
    {
        Question *newQuestion = [[Question alloc]init];
        [newQuestion setQuestionId:[[dict objectForKey:@"id"] intValue]];
        [newQuestion setTitle:[dict objectForKey:@"title"]];
        [newQuestion setUserId: [[dict objectForKey:@"user_id"] intValue]];
        [newQuestion setCreated:[self dateFromString:[dict objectForKey:@"created"]]];
        [newQuestion setAnswerCount:[[dict objectForKey:@"answer_count"] intValue]];
        [parsedQuestions addObject:newQuestion];
    }
    questions = [parsedQuestions copy];
    NSLog(@"QuestionsAfterParse: %d", [questions count]);
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
        [selectedQuestion setBody:[dict objectForKey:@"body"]];
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
    return nil;
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
        [newUser setUserId:[[dict objectForKey:@"id"] intValue]];
        [newUser setName:[dict objectForKey:@"name"]];
        [newUser setLocation:[dict objectForKey:@"location"]];
        
        NSString *avatarURL = [[NSString alloc] initWithFormat:[dict objectForKey:@"avatar"]];
        [newUser setAvatar:[self downloadImage:[[NSURL alloc] initWithString:avatarURL]]];
        
        [newUser setReputation:[[dict objectForKey:@"reputation_sum"] intValue]];
        
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
            [selectedUser setTwitterUrl:[[NSURL alloc] initWithString:[dict objectForKey:@"twitterurl"]]];
        }
        if(([dict objectForKey:@"googleurl"] != [NSNull null]))
        {
            [selectedUser setGoogleUrl:[[NSURL alloc] initWithString:[dict objectForKey:@"googleurl"]]];
        }
        if(([dict objectForKey:@"facebookurl"] != [NSNull null]))
        {
            [selectedUser setFacebookUrl:[[NSURL alloc] initWithString:[dict objectForKey:@"facebookurl"]]];
        }
        [selectedUser setAbout:[dict objectForKey:@"about_me"]];
        [selectedUser setProfile:[dict objectForKey:@"profile"]];
        [selectedUser setUrl:[dict objectForKey:@"url"]];
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
        if([dict objectForKey:@"question_count"] == [NSNull null])
        {
            [newTag setQuestionCount:0];
        }
        else
        {
            [newTag setQuestionCount:[[dict objectForKey:@"question_count"] intValue]];
        }
        [parsedTags addObject:newTag];
        [newTag setExcerpt:[dict objectForKey:@"excerpt"]];
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
        [selectedTag setWiki:[dict objectForKey:@"wiki"]];
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
