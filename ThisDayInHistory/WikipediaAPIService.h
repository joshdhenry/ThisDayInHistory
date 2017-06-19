//
//  WikipediaAPIService.h
//  ThisDayInHistory
//
//  Created by Josh Henry on 6/18/17.
//  Copyright © 2017 Big Smash Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WikipediaAPIService : NSObject
{
    NSURL *dataSourceURL;
}

-(void)fetchArticle;
-(void)parseThisDayArticle:(NSString *) article;

@end
