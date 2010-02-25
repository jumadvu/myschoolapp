//
//  ModulePlus.h
//  MySchool
//
//  Created by Ashley Kayler on 2/14/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Module.h"

@interface Module (ModulePlus) 

-(NSArray*)chaptersArray;
+(Module*) getModuleWithName:(NSString *)moduleName;

@end
