//
//  CategoryViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 08/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryTableViewCell.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

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
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    return cell;
    
}
@end
