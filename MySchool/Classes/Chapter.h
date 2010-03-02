//
//  Chapter.h
//  MySchool
//
//  Created by Ashley Kayler on 2/18/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Article;
@class Lecture;
@class Module;

@interface Chapter :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * overview;
@property (nonatomic, retain) Module * module;
@property (nonatomic, retain) Lecture * lecture;
@property (nonatomic, retain) Article * article;

@end

