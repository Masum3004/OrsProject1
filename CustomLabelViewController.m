//
//  CustomLabelViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 12/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "CustomLabelViewController.h"

@interface CustomLabelViewController ()

@end

@implementation CustomLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.txtCustomText setText:_strCustomText];
    
    
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [_strCustomText dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    
    [self.txtCustomText setAttributedText:attributedString];
    
    [self.txtCustomText setTextColor:[UIColor whiteColor]];
    
    [self.txtCustomText setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
