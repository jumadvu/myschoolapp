//
//  DesignAvatar1.h
//  MySchool
//
//  Created by Ashley Kayler on 1/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DesignAvatar1 : baseViewController {
	IBOutlet UISegmentedControl *segmentControl;
	IBOutlet UISegmentedControl *segmentControl2;
	NSMutableArray *imageArray;
	IBOutlet UIImageView *avatarImageView;
	NSArray *descriptions;
}

@property (nonatomic, retain) UISegmentedControl *segmentControl;
@property (nonatomic, retain) UISegmentedControl *segmentControl2;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) UIImageView *avatarImageView;
@property (nonatomic, retain) NSArray *descriptions;

- (void)segmentAction:(UISegmentedControl*)sender;

@end
