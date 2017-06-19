//
//  WikipediaAPIService.m
//  ThisDayInHistory
//
//  Created by Josh Henry on 6/18/17.
//  Copyright © 2017 Big Smash Software. All rights reserved.
//

#import "WikipediaAPIService.h"

@implementation WikipediaAPIService

static NSString *const articleURLBaseString = @"https://en.wikipedia.org/w/api.php?action=query&titles=";

-(void)fetchArticle {
    NSString *thisDayURLString = [articleURLBaseString stringByAppendingString:@"june%2018&prop=revisions&rvprop=content&format=json"];
    NSLog(@"%@", thisDayURLString);
    NSURL *thisDayURL = [NSURL URLWithString:thisDayURLString];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:thisDayURL];
    
    //NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        
        if (error) {
            NSLog(@"Error - No data received in response.");
            return;
        }
        else if (response == nil) {
            NSLog(@"Error - No response received from the request.");
            return;
        }
        else if (statusCode != 200) {
            NSLog(@"Error - Invalid status code received.");
            return;
        }
        else if (!data) {
            NSLog(@"Error - No data received from the request.");
            return;
        }
        else {
            NSError *dataError = nil;
            NSDictionary *dataDict = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&dataError] objectForKey:@"query"];
            
            if (!dataError) {
                NSString *articleString = [dataDict[@"pages"] allValues][0][@"revisions"][0][@"*"];
                [self parseThisDayArticle:articleString];
            }
            else {
                NSLog(@"Error serializing json data.");
                return;
            }
        }
    }];
    [dataTask resume];
}


-(void)parseThisDayArticle:(NSString *) articleStr {
    //PARSE THE ARTICLE AND SEPARATE INTO 3 STRINGS - EVENTS, BIRTHS, DEATHS
    NSString *eventString = @"Events==";
    [articleStr rangeOfString:eventString];
    NSUInteger eventsIndex = [articleStr rangeOfString:@"==Events=="].location;
    NSString *events = [articleStr substringFromIndex:eventsIndex];
    NSLog(@"%@", events);
}

//-(NSArray *)parseEvents:(NSString *) eventsString {
//    
//}
//
//-(NSArray *)parseBirthsOrDeaths:(NSString *) birthsOrDeathsString {
//    
//}

@end
