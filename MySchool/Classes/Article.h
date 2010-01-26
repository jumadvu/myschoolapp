//
//  Article.h
//  MySchool
//
//  Created by Ashley Kayler on 1/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Chapter;

@interface Article :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Chapter * chapter;

@end



