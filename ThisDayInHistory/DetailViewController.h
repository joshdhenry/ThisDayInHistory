//
//  DetailViewController.h
//  ThisDayInHistory
//
//  Created by Josh Henry on 6/18/17.
//  Copyright © 2017 Big Smash Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThisDayInHistory+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

