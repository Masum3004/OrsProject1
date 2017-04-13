//
//  ForgotPasswordViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 13/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

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

@end
