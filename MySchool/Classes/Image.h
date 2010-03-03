//
//  Image.h
//  MySchool
//
//  Created by Connor Riley on 3/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Article;

@interface Image :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) Article * article;

@end



