//
//  BrandViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 12/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "BrandViewController.h"
#import "BrandTableViewCell.h"
#import "AppConstant.h"
#import "AFNetworking.h"
#import "UIView+Toast.h"
#import "MBProgressHUD.h"


@interface BrandViewController ()
{
    MBProgressHUD *hud;
    NSArray *brandArr;
}

@end

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fetchCategory:[NSString stringWithFormat:@"%@%@",BASE_URL,FETCH_BRAND]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [brandArr count];    //count number of row from counting array hear catagory is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
     [cell.lblBrandName setText:[[brandArr objectAtIndex:indexPath.row] objectForKey:@"brandName"]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - Consuming Webservices


-(void)fetchCategory:(NSString *)strURL {
    
    [self showHud];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSLog(@"FETCHURL :%@",strURL);
    
    [manager GET:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responsDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (responsDict != nil) {
            
            [self hideHud];
            [self parseDataResponseObject:responsDict];
            
        }
        
        else {
            [self hideHud];
            [self.view makeToast:@"Login Incorrect!!"];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"ERROR------>> %@",error);
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];
    
    
}

-(void)parseDataResponseObject:(NSDictionary *)dictionary {
    
    NSLog(@"response >> %@",dictionary);
    
    if ([[dictionary objectForKey:@"success"] integerValue] == 1) {
        
        brandArr = [dictionary objectForKey:@"products"];
        [self.brandTableView reloadData];
    }
    else {
        
        [self.view makeToast:@"No data found."];
    }
}
#pragma mark -MBProgressHUD methods

-(void)showHud
{
    dispatch_async(dispatch_get_main_queue()
                   , ^{
                       hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                       hud.delegate = (id)self;
                       
                   });
}

-(void)hideHud
{
    dispatch_async(dispatch_get_main_queue()
                   , ^{
                       [hud hide:YES];
                       //[hud removeFromSuperview];
                       
                   });
}



@end
