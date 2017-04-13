//
//  RegistrationViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 13/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AppConstant.h"

#import "AFNetworking.h"
#import "UIView+Toast.h"
#import "MBProgressHUD.h"

@interface RegistrationViewController ()
{
    MBProgressHUD *hud;
}
@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initialize {
    
    [self setPlaceHolder:self.txtEmail];
    [self setPlaceHolder:self.txtPassword];
    [self setPlaceHolder:self.txtFirstName];
    [self setPlaceHolder:self.txtLastName];
    [self setPlaceHolder:self.txtPhoneNo];
    [self setPlaceHolder:self.txtAddress1];
    [self setPlaceHolder:self.txtAddress2];
    [self setPlaceHolder:self.txtCity];
    [self setPlaceHolder:self.txtState];
    [self setPlaceHolder:self.txtPincode];
    [self setPlaceHolder:self.txtCountry];

}

-(void)setPlaceHolder:(UITextField *)textField {
  
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
}


#pragma mark - UIKeyboard methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField; {
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing: (UITextField *)textField
{
    return YES;
}

-(void)resignKeyboard {
    
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}
- (void)keyboardWasShown:(NSNotification *)aNotification
{
    
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect keyboardInfoFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect windowFrame = [self.view.window convertRect:self.view.frame fromView:self.view];
    CGRect keyboardFrame = CGRectIntersection (windowFrame, keyboardInfoFrame);
    CGRect coveredFrame = [self.view.window convertRect:keyboardFrame toView:self.view];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake (0.0, 0.0, coveredFrame.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.frame.size.width, self.scrollView.contentSize.height)];
    
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
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
- (IBAction)btnSignUp:(id)sender {
    
    [self.view endEditing:YES];
    
    if (self.txtEmail.text.length == 0 || self.txtPassword.text.length == 0 || self.txtFirstName.text.length == 0 || self.txtLastName.text.length == 0 || self.txtPhoneNo.text.length == 0 || self.txtAddress1.text.length == 0 || self.txtAddress2.text.length == 0 || self.txtCity.text.length == 0 || self.txtState.text.length == 0 || self.txtPincode.text.length == 0 || self.txtCountry.text.length == 0 ) {
        
        [self.view makeToast:@"Please enter all fields."];
    }
    else {
        
        [self checkLogin];
    }
}


-(void) checkLogin {
    
    [self showHud];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    /*
     {
     "txtEmail" : "dhruvil123456@gmail.com",
     "txtPass" : "123456",
     "txtFName" : "demo",
     "txtLName" : "user",
     "txtAdd2T" : "abc abc",
     "txtAdd1T" : "xyz xyz",
     "txtPnoT" : "9998887654",
     "txtCityT" : "Vadodara",
     "txtStateT" : "10",
     "txtPinCodeT" : "390006",
     "txtCountryT" : "India"
     }
     */
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            _txtEmail.text,@"txtEmail",
                            _txtPassword.text,@"txtPass",
                            _txtFirstName.text,@"txtFName",
                            _txtLastName.text,@"txtLName",
                            _txtAddress2.text,@"txtAdd2T",
                            _txtAddress1.text,@"txtAdd1T",
                            _txtPhoneNo.text,@"txtPnoT",
                            _txtCity.text,@"txtCityT",
                            _txtState.text,@"txtStateT",
                            _txtPincode.text,@"txtPinCodeT",
                            _txtCountry.text,@"txtCountryT",
                            
                            nil];
    NSLog(@">>%@",params);
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // if request JSON format
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSLog(@">> %@",[NSString stringWithFormat:@"%@%@",BASE_URL,USER_REGISTRATION]);
    
    [manager POST:[NSString stringWithFormat:@"%@%@",BASE_URL,USER_REGISTRATION] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

@end
