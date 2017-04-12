//
//  CartViewController.h
//  Tradmark2
//
//  Created by EXCELLENT2 on 08/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartViewController : UIViewController

- (IBAction)btnCheckOut:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblTotalAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblItemCount;

@property (weak, nonatomic) IBOutlet UIButton *btnCheckOut;

@property (weak, nonatomic) IBOutlet UITableView *cartTableView;
@end
