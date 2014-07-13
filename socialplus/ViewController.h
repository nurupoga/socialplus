//
//  ViewController.h
//  socialplus
//
//  Created by ohtatomotaka on 2014/07/08.
//  Copyright (c) 2014年 ohtatomotaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMXMLParser.h"
@interface ViewController : UIViewController<KMXMLParserDelegate>{
    IBOutlet UITableView *table;
    
}
@property (strong, nonatomic) NSArray *dataArray;
@end
