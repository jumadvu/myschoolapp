//
//  testing123.m
//  MySchool
//
//  Created by Ashley Kayler on 3/2/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "testing123.h"


@implementation testing123

@synthesize imageView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	BOOL waving = YES;
	
	NSString *imageFile = [NSString stringWithFormat:@"Girl1Happy.png"];
	UIImage *image = [UIImage imageNamed:imageFile];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.image = image;
	imageView.frame = CGRectMake(10, 10.0, 100.0, 125.0); 
	//imageView.transform = CGAffineTransformScale(imageView.transform, .5, .5);

	NSString *bodyImageFile = [NSString stringWithFormat:@"Girl1Body.png"];
	UIImage *bodyImage = [UIImage imageNamed:bodyImageFile];
	UIImageView * bodyView = [[UIImageView alloc] initWithImage:bodyImage];
	//bodyView.frame = basicView.frame;
	bodyView.contentMode = UIViewContentModeScaleAspectFit;
	
	CGRect rect = bodyView.frame;
	rect.size.height = 125;
	rect.size.width = 100;
	rect.origin.x = 0;
	rect.origin.y = 0;
	bodyView.frame = rect;
	
	
	//waving? add animation
	if (waving) {
		NSArray * imageArray  = [[NSArray alloc] initWithObjects:
								 [UIImage imageNamed:@"Girl1wave1.png"],
								 [UIImage imageNamed:@"Girl1wave2.png"],
								 [UIImage imageNamed:@"Girl1wave3.png"],
								 [UIImage imageNamed:@"Girl1wave2.png"],
								 nil];
		bodyView.animationImages = imageArray;
		bodyView.animationDuration = 1.1;
		bodyView.contentMode = UIViewContentModeScaleAspectFit;
		[bodyView startAnimating];
		bodyView.image = nil;
		//basicView.image = nil;
	} else {
		[bodyView stopAnimating];
		bodyView.animationImages = nil;
	}
	
	[imageView addSubview:bodyView];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
