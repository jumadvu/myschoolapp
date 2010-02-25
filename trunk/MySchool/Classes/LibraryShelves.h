//
//  LibraryShelves.h
//  MySchool
//
//  Created by Ashley Kayler on 2/24/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LibraryShelves : baseViewController {
	
	IBOutlet UIScrollView *scrollView;
	IBOutlet UISegmentedControl *segmentControl;
	NSArray *subjects;
	NSArray *bookImages;
	NSMutableArray *shelfMarkers;
	NSMutableArray *subjectNames;

}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UISegmentedControl *segmentControl;
@property (nonatomic, retain) NSArray *subjects;
@property (nonatomic, retain) NSArray *bookImages;
@property (nonatomic, retain) NSMutableArray *shelfMarkers;
@property (nonatomic, retain) NSMutableArray *subjectNames;

-(void)loadBooksIntoScrollView;
-(void)clickedButton:(UIButton *)button;
- (IBAction)segmentAction:(id)sender;

@end
