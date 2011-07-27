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

@implementation SMART3QAAppDelegate

@synthesize window = _window, hostname;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    hostname = [[NSString alloc]initWithString:@"http://192.168.1.103"];
    [self downloadQuestions];
    [self downloadUsers];
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
    [dateFormatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (NSDate *)dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormatter = [NSDateFormatter alloc];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
    NSDate *stringDate = [dateFormatter dateFromString:string];
    return stringDate;
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
    //NSLog(@"Users: %d", [users count]);*/
    
    NSMutableArray *parsedQuestions = [NSMutableArray array];
    for (NSDictionary *dict in questions)
    {
        Question *newQuestion = [[Question alloc]init];
        //[newQuestion setQuestionId:[[dict objectForKey:@"id"] intValue]];
        [newQuestion setTitle:[dict objectForKey:@"title"]];
        //[newQuestion setBody:[dict objectForKey:@"body"]];
        [newQuestion setUserId: [[dict objectForKey:@"user_id"] intValue]];
        //[newQuestion setCreated:[dict objectForKey:@"created"]];
        //[newQuestion setAcceptedAnswer:[[dict objectForKey:@"accepted_answer_id"] intValue]];
        [parsedQuestions addObject:newQuestion];
    }
    
    questions = [parsedQuestions copy];
}

- (NSArray *)getQuestions
{
    return questions;
}

- (Question *)getQuestionForId:(NSInteger *)questionid
{
    for(Question *q in questions){
        if([q getQuestionId] == questionid)
        {
            return q;
        }
    }
    return nil;
}

- (Question *)getQuestionForIndex:(NSInteger *)index
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
    //NSLog(@"Users: %d", [users count]);
    
    NSMutableArray *parsedUsers = [NSMutableArray array];
    for (NSDictionary *dict in users)
    {
        User *newUser = [[User alloc]init];
        [newUser setName:[dict objectForKey:@"name"]];
        [newUser setLocation:[dict objectForKey:@"location"]];
        
        NSString *avatarURL = [[NSString alloc] initWithFormat:[dict objectForKey:@"avatar"]];
        [newUser setAvatar:[self downloadImage:[[NSURL alloc] initWithString:avatarURL]]];
        
        [newUser setReputation:[[dict objectForKey:@"reputation_sum"] intValue]];
        [newUser setCreated:[self dateFromString:[dict objectForKey:@"created"]]];
        
        [parsedUsers addObject:newUser];
    }
    
    users = [parsedUsers copy];
}

- (NSArray *)getUsers
{
    return users;
}

- (User *)getUserForId:(NSInteger *)userid
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

- (Question *)getUserForIndex:(NSInteger *)index
{
    return [users objectAtIndex:index];    
}

@end
