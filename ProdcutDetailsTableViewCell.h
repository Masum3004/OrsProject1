//
//  ProdcutDetailsTableViewCell.h
//  Tradmark2
//
//  Created by EXCELLENT2 on 08/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProdcutDetailsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblServingSize;
@property (weak, nonatomic) IBOutlet UILabel *lblServingContainerSize;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscount;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToCart;
@end
