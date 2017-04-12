//
//  CartViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 08/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "CartViewController.h"

#import "CartTableViewCell.h"

@interface CartViewController ()
{
    NSArray *cartArr;
}
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"cartItem"] == nil) {
        
        //show label
        self.lblItemCount.hidden = YES;
        self.btnCheckOut.hidden  = YES;
        self.lblTotalAmount.text = @"NO CART ITEM";
        
    }
    else {
        cartArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"cartItem"];
    }
    
    [self CountTotalAmount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [cartArr count];    //count number of row from counting array hear catagory is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartCell"];
    
    NSMutableDictionary *dictionary = [cartArr objectAtIndex:indexPath.row];
    
    cell.lblSize.text = [NSString stringWithFormat:@"%@ %@",[dictionary objectForKey:@"productSize"], [dictionary objectForKey:@"unit1"]];
    cell.lblPrice.text = [NSString stringWithFormat:@"₹ %@", [dictionary objectForKey:@"price"]];
    cell.lblProductName.text = [dictionary objectForKey:@"productFlovour"];
   
    cell.btnDelete.tag = indexPath.row;
    [cell.btnDelete addTarget:(id)self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchDown];
  
    return cell;
    
}

- (void)btnDelete:(id)sender {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:cartArr];
    
    [array removeObjectAtIndex:[sender tag]];

    cartArr = nil;
    
    cartArr = [NSArray arrayWithArray:array];
    
    [self.cartTableView reloadData];
    
    [self CountTotalAmount];
    
    [[NSUserDefaults standardUserDefaults] setObject:cartArr forKey:@"cartItem"];
}

-(void)CountTotalAmount {

    NSInteger totalAmount = 0;
    
    for (NSMutableDictionary *dict in cartArr) {
        
        totalAmount += [[dict objectForKey:@"price"] integerValue];
    }
    
    self.lblTotalAmount.text = [NSString stringWithFormat:@"Total Amount : %ld",totalAmount];
    
    self.lblItemCount.text = [NSString stringWithFormat:@"Items(%ld)",[cartArr count]];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"cartItem"] == nil || [cartArr count] == 0) {
        
        //show label
        self.lblItemCount.hidden = YES;
        self.btnCheckOut.hidden  = YES;
        self.lblTotalAmount.text = @"NO CART ITEM";
        
    }
    else {
        cartArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"cartItem"];
    }

    
}

- (IBAction)btnCheckOut:(id)sender {
}
@end
