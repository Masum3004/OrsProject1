//
//  HomeViewController.m
//  Tradmark2
//
//  Created by EXCELLENT2 on 12/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeTableViewCell.h"

#import "AppConstant.h"
#import "ProductViewController.h"

@interface HomeViewController ()
{
    NSArray *titleArr, *subtitleArr, *imageArr, *categoryIdArr;
}
@end

@implementation HomeViewController

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
    
    [self.bannerImageView setImage:[UIImage imageNamed:@"sale.jpg"]];
    
    titleArr = [NSArray arrayWithObjects:@"Top Selling Proteins", @"Top Selling Gainers", @"Top Selling Fat Loss", @"Top Selling Pre Workout", @"Top Selling Amino Acids", @"Top Selling Creatine", nil];
    subtitleArr = [NSArray arrayWithObjects:@"Premium Quality Whey Protein", @"Balanced levels of fat & sugar to avoid bloating", @"Safe & without any side effects or uneasiness", @"Prevent Energy Crash or Muscle Fatigue", @"Energy, Pump & Strength", @"Workout Quality, Weight Lifting Capacity, More Reps", nil];
    imageArr = [NSArray arrayWithObjects:@"wheyprotein.png", @"seriousmass.png", @"hydrocuut.png", @"preworkout.png", @"aminoacid.png", @"creatine.png", nil];
    
    categoryIdArr = [NSArray arrayWithObjects:@"2", @"3", @"4", @"5", @"6", @"7", nil];

}


#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [titleArr count];    //count number of row from counting array hear catagory is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    [cell.productImageView setImage:[UIImage imageNamed:[imageArr objectAtIndex:indexPath.row]]];
    
    cell.lblTitle.text = [titleArr objectAtIndex:indexPath.row];
    
    cell.lblSubtitle.text = [subtitleArr objectAtIndex:indexPath.row];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cateoryId = [NSString stringWithFormat:@"%@-MN",[categoryIdArr objectAtIndex:indexPath.row]];
    NSString *searchId = @"NA";
    
    ProductViewController *viewCotroller = [self.storyboard instantiateViewControllerWithIdentifier:ProductList_Identifier];
    
    viewCotroller.categoryID = cateoryId;
    viewCotroller.searchID = searchId;
    
    [self presentViewController:viewCotroller animated:YES completion:nil];
    
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


- (IBAction)btnGo:(id)sender {
    
    NSString *cateoryId = @"0-SR";
    NSString *searchId = [NSString stringWithFormat:@"%@",self.txtSearch.text];
    
    ProductViewController *viewCotroller = [self.storyboard instantiateViewControllerWithIdentifier:ProductList_Identifier];
    
    viewCotroller.categoryID = cateoryId;
    viewCotroller.searchID = searchId;
    
    [self presentViewController:viewCotroller animated:YES completion:nil];
}
@end
