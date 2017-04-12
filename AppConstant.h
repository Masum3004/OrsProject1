//
//  AppConstant.h
//  Tradmark2
//
//  Created by EXCELLENT2 on 12/04/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

#ifndef AppConstant_h
#define AppConstant_h

/*       ViewController Identifier       */

#define Category_Identifier @"CATEGORY"

#define Brand_Identifier @"BRAND"

#define ProductList_Identifier @"PRODUCT"

#define ProductDetail_Identifier @"PRODUCT_DETAIL"

#define ContactUs_Identifier @"CONTACT_US"

#define Cart_Identifier @"CART"

#define Home_Identifier @"HOME"


/*       MENU ARRAY       */

#define MENU_ARRAY @[@"Home", @"Shop by Brand", @"Shop By Category", @"Shopping Cart", @"Contact Us", @"Check Updates"]

#define MENU_IDENTIFIER_ARRAY @[Home_Identifier, Brand_Identifier, Category_Identifier, Cart_Identifier, ContactUs_Identifier]



/*      API URL       */

#define BASE_URL @"https://muscleguru.in/mobilefiles/"

#define IMAGE_BASE_URL @"http://www.muscleguru.in/data2/thamb/"

#define FETCH_CATEGORY @"showcategory.php/"

#define FETCH_BRAND @"showbrands.php/"

#define FETCH_PRODUCT @"showproducts.php?"

#define FETCH_PRODUCT_DETAIL @"showproductdetail.php?"

#endif /* AppConstant_h */
