//
//  ProductViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 08/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductTableViewCell.h"
#import "AppConstant.h"
#import "AFNetworking.h"
#import "UIView+Toast.h"
#import "MBProgressHUD.h"
#import "UIImageView+AFNetworking.h"
#import "ProductDetailViewController.h"


//https://muscleguru.in/mobilefiles/showproducts.php?tpid=4-MN&searchId=NA
//https://muscleguru.in/mobilefiles/showproducts.php?tpid=0-SR&searchId=on


@interface ProductViewController ()
{
    MBProgressHUD *hud;
    NSArray *productArr;
}
@end

@implementation ProductViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fetchProducts:_categoryID Seearch:_searchID];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [productArr count];    //count number of row from counting array hear catagory is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
    
    NSDictionary *dictionary = [productArr objectAtIndex:indexPath.row];
    
    cell.lblProductName.text = [dictionary objectForKey:@"productName"];
    cell.lblproductSize.text = [NSString stringWithFormat:@"%@ %@",[dictionary objectForKey:@"productSize"],[dictionary objectForKey:@"unit1"]];
    cell.lblProductPrice.text = [NSString stringWithFormat:@"₹ %@",[dictionary objectForKey:@"price"]];
    [cell.productImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,[dictionary objectForKey:@"productImage"]]]];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductDetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:ProductDetail_Identifier];
    viewController.productID = [[productArr objectAtIndex:indexPath.row] objectForKey:@"pid"];
    [self presentViewController:viewController animated:YES completion:nil];
}


#pragma mark - Button Menu methods

- (IBAction)btnMenu:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:(id)self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    for (NSString *string in MENU_ARRAY) {
        [actionSheet addButtonWithTitle:string];
    }
    
    [actionSheet showInView:self.view];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        
        if (buttonIndex != 6) {
            
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:[MENU_IDENTIFIER_ARRAY objectAtIndex:buttonIndex-1]];
            [self presentViewController:viewController animated:YES completion:nil];
        }
        
    }
}

#pragma mark - Consuming Webservices


-(void)fetchProducts:(NSString *)categoryId Seearch:(NSString *)searchID {
    
    [self showHud];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString *strURL = [NSString stringWithFormat:@"%@%@tpid=%@&searchId=%@",BASE_URL, FETCH_PRODUCT ,categoryId,searchID];
    
    NSLog(@"FETCHURL :%@",strURL);
    
    [manager GET:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responsDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (responsDict != nil) {
            
            [self hideHud];
            [self parseDataResponseObject:responsDict];
            
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
        
        productArr = [dictionary objectForKey:@"products"];
        [self.productTableView reloadData];
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
