//
//  ModuleCell.h
//  MySchool
//
//  Created by Connor Riley on 2/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ModuleCell : UITableViewCell {
	NSString *fileName;
	NSString *moduleName;
}

@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) NSString *moduleName;

@end
