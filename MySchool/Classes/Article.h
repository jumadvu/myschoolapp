//
//  Article.h
//  MySchool
//
//  Created by Connor Riley on 3/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Chapter;

@interface Article :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Chapter * chapter;
@property (nonatomic, retain) NSSet* images;

@end


@interface Article (CoreDataGeneratedAccessors)
- (void)addImagesObject:(NSManagedObject *)value;
- (void)removeImagesObject:(NSManagedObject *)value;
- (void)addImages:(NSSet *)value;
- (void)removeImages:(NSSet *)value;

@end

