//
//  LoginViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 13/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "LoginViewController.h"
#import "AppConstant.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_txtEmail.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_txtPassword.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRegistration:(id)sender {
    
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"REGISTRATION"];
    
    [self presentViewController:viewController animated:YES completion:nil];
     
 }

- (IBAction)btnForgotPassword:(id)sender {
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FORGOT_PASSWORD"];
    
    [self presentViewController:viewController animated:YES completion:nil];
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



@end
