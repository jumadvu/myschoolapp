//
//  Image.h
//  MySchool
//
//  Created by Ashley Kayler on 3/17/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Article;

@interface Image :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSManagedObject * storeItem;
@property (nonatomic, retain) Article * article;

@end



