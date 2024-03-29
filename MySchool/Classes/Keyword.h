//
//  Keyword.h
//  MySchool
//
//  Created by Ashley Kayler on 2/18/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class KeywordSet;

@interface Keyword :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSNumber * correct;
@property (nonatomic, retain) KeywordSet * set;

@end



