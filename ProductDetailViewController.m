//
//  ProductDetailViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 08/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "ProductDetailViewController.h"

#import "ProdcutDetailsTableViewCell.h"
#import "AppConstant.h"
#import "AFNetworking.h"
#import "UIView+Toast.h"
#import "MBProgressHUD.h"
#import "UIImageView+AFNetworking.h"
#import "CustomAnimationAndTransiotion.h"
#import "CustomLabelViewController.h"

@interface ProductDetailViewController ()
{
    MBProgressHUD *hud;
    NSArray *productArr;
}
@property(strong, nonatomic)CustomAnimationAndTransiotion  *customTransitionController;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchProducts:_productID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [productArr count];    //count number of row from counting array hear catagory is An Array
}


#pragma mark - UITableView Methods


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProdcutDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
    
    NSDictionary *dictionary = [productArr objectAtIndex:indexPath.row];
    
    cell.lblProductName.text =[NSString stringWithFormat:@"%@ %@ %@ ₹%@",[dictionary objectForKey:@"productSize"], [dictionary objectForKey:@"unit1"], [dictionary objectForKey:@"productFlovour"], [dictionary objectForKey:@"price"]];
    cell.lblServingSize.text = [NSString stringWithFormat:@"Serving size : %@",[dictionary objectForKey:@""]];
    cell.lblServingContainerSize.text = [NSString stringWithFormat:@"Serving Per Container : %@",[dictionary objectForKey:@""]];
    cell.lblDiscount.text = [dictionary objectForKey:@"addDiscount"];
    
    cell.btnAddToCart.tag = indexPath.row;
    
    [cell.btnAddToCart addTarget:(id)self action:@selector(btnAddToCart:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
    
}

-(void)btnAddToCart:(id)sender {
    
    NSArray *array;
    NSMutableArray *cartArr = [[NSMutableArray alloc] init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"cartItem"] != nil) {
       
        array = [[NSUserDefaults standardUserDefaults] objectForKey:@"cartItem"];
        cartArr = [NSMutableArray arrayWithArray:array];
    }
    else {
        NSLog(@"It is nill");
    }
    
    NSDictionary *dictionary = [productArr objectAtIndex:[sender tag]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[dictionary objectForKey:@"pid"] forKey:@"pid"];
    [dict setObject:[dictionary objectForKey:@"productFlovour"] forKey:@"productFlovour"];

    [dict setObject:[dictionary objectForKey:@"productSize"] forKey:@"productSize"];

    [dict setObject:[dictionary objectForKey:@"unit1"] forKey:@"unit1"];

    [dict setObject:[dictionary objectForKey:@"price"] forKey:@"price"];
    
    [dict setObject:[dictionary objectForKey:@"dsper"] forKey:@"dsper"];

    [cartArr addObject:dict];
    
    [[NSUserDefaults standardUserDefaults] setObject:cartArr forKey:@"cartItem"];
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:Cart_Identifier];
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


-(void)fetchProducts:(NSString *)categoryId {
    
    [self showHud];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString *strURL = [NSString stringWithFormat:@"%@%@tpid=%@",BASE_URL, FETCH_PRODUCT_DETAIL ,categoryId];
    
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
      
        [self.lblProductImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,[[productArr objectAtIndex:0] objectForKey:@"productImage"]]]];
       
        self.lblProductName.text = [[productArr objectAtIndex:0] objectForKey:@"productName"];
        
        self.lblBrandName.text = [[productArr objectAtIndex:0] objectForKey:@"productBrand"];
        
        self.lblGoal.text = [NSString stringWithFormat:@"Supp. Goal : %@",[[productArr objectAtIndex:0] objectForKey:@"suppGoal"]];
        
        self.lblIngredint.text = [NSString stringWithFormat:@"Main Ingre.: %@",[[productArr objectAtIndex:0] objectForKey:@"mainIng"]];
        
        [self.productTableView reloadData];
    }
    else {
        
        [self.view makeToast:@"No data found."];
    }
}
- (IBAction)btnViewDetails:(id)sender {

    CustomLabelViewController *popover=[self.storyboard instantiateViewControllerWithIdentifier:@"CUSTOM_LABEL"];
    popover.modalPresentationStyle = UIModalPresentationCustom;
    [popover setTransitioningDelegate:_customTransitionController];
    popover.strCustomText = [[productArr objectAtIndex:0] objectForKey:@"productdescription"];
    [self presentViewController:popover animated:YES completion:nil];
   
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
