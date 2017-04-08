//
//  ProductDetailViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 08/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "ProductDetailViewController.h"

#import "ProdcutDetailsTableViewCell.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;    //count number of row from counting array hear catagory is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProdcutDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
    
    return cell;
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 0;
//}
- (IBAction)btnMenu:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"POPOVER"];
       CATransition *transition = [CATransition animation];
    transition.duration = 0.6;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    [vc.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
