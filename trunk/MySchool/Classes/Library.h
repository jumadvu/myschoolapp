//
//  Library.h
//  MySchool
//
//  Created by Ashley Kayler on 2/9/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

//#import <Cocoa/Cocoa.h>


@interface Library : NSObject {
}


+(NSArray*)subjectsForGrade:(NSNumber *)gradeLevel;
+(NSString*) whichXMLFile:(NSNumber*)gradeLevel;

@end
