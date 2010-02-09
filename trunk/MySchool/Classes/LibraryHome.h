//
//  LibraryHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LibraryHome : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
	NSArray *subjects;
	NSMutableArray *moduleNames;
}

@property (nonatomic, retain) NSMutableArray *moduleNames;
@property (nonatomic, retain) NSArray *subjects;


@end
