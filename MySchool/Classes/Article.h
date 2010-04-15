//
//  Article.h
//  MySchool
//
//  Created by Ashley Kayler on 4/14/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Chapter;
@class Image;

@interface Article :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Chapter * chapter;
@property (nonatomic, retain) NSSet* images;

@end


@interface Article (CoreDataGeneratedAccessors)
- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)value;
- (void)removeImages:(NSSet *)value;

@end

