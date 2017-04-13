//
//  ForgotPasswordViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 13/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "ForgotPasswordViewController.h"

#import "AppConstant.h"

#import "AFNetworking.h"
#import "UIView+Toast.h"
#import "MBProgressHUD.h"


@interface ForgotPasswordViewController ()
{
    MBProgressHUD *hud;
}
@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_txtEmail.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnSubmit:(id)sender {
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
-(void) checkLogin {
    
    [self showHud];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    /*
     {
     "txtpass" : "123123",
     "txtemail" : "hello@gmail.com"
     }
     */
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            _txtEmail.text,@"txtemail",
                            
                            nil];
    NSLog(@">>%@",params);
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // if request JSON format
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSLog(@">> %@",[NSString stringWithFormat:@"%@%@",BASE_URL,CHECK_LOGIN]);
    
    [manager POST:[NSString stringWithFormat:@"%@%@",BASE_URL,CHECK_LOGIN] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (responseObject != [NSNull null]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self parseDataResponseObjectForInchagrge:responseObject];
            });
            
        }
        else {
            
            [self hideHud];
            [self.view makeToast:@"No response from server."];
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"ERROR ----->> %@",error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.view makeToast:@"Please check Internet connectivity."];
    }];
    
    
    
}
-(void)parseDataResponseObjectForInchagrge:(NSDictionary *)dictionary {
    
    NSLog(@">> %@",dictionary);
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField; {
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing: (UITextField *)textField
{
    return YES;
}


@end
