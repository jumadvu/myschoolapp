//
//  PersonalQuestion.h
//  MySchool
//
//  Created by Ashley Kayler on 4/23/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface PersonalQuestion :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * correct;
@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * wrong;

@end



