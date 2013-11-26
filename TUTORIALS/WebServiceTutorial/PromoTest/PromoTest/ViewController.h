//
//  ViewController.h
//  PromoTest
//
//  Created by darren cullen on 25/11/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDelegate, UITextFieldDelegate>
{
    NSMutableData *_responseData;
}
@end
