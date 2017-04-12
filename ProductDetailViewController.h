//
//  ProductDetailViewController.h
//  Tradmark2
//
//  Created by EXCELLENT2 on 08/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *productTableView;

@property (weak, nonatomic)NSString *productID;

@property (weak, nonatomic) IBOutlet UIImageView *lblProductImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;

@property (weak, nonatomic) IBOutlet UILabel *lblBrandName;

@property (weak, nonatomic) IBOutlet UILabel *lblGoal;

@property (weak, nonatomic) IBOutlet UILabel *lblIngredint;

@end
