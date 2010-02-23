//
//  ModuleHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ModuleHome : baseViewController <UIScrollViewDelegate>{
	IBOutlet UILabel *moduleNameLabel;
	IBOutlet UIScrollView *scrollview;
	NSString *moduleName;
	IBOutlet UILabel* pcurrent;
	IBOutlet UILabel* ptotal;
	NSMutableArray *moduleNames;	
	BOOL pageControlIsChangingPage;
	NSString *fileName;
	
}

@property (nonatomic, retain) UILabel *moduleNameLabel;
@property (nonatomic, retain) NSString *moduleName;
@property (nonatomic, retain) UIScrollView *scrollview;
@property (nonatomic, retain) UILabel* pcurrent;
@property (nonatomic, retain) UILabel* ptotal;
@property (nonatomic, retain) NSMutableArray *moduleNames;
@property (nonatomic, retain) NSString *fileName;

@end