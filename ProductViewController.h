//
//  ProductViewController.h
//  Tradmark2
//
//  Created by EXCELLENT2 on 08/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *productTableView;

@property (weak, nonatomic) NSString *categoryID;
@property (weak, nonatomic) NSString *searchID;
@end
