//
//  RegistrationViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 13/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AppConstant.h"

@interface RegistrationViewController ()

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
