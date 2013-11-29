//
//  ViewController.m
//  PromoTest
//
//  Created by darren cullen on 25/11/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITextField *textView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // sets the textField delegates to equal this viewController ... this allows for the keyboard to disappear after pressing done
    self.textField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    NSLog(@"Want to redeem: %@", textField.text);
//    return TRUE;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // Get device unique ID
    UIDevice *device = [UIDevice currentDevice];
    NSString *uniqueIdentifier = [[device identifierForVendor] UUIDString];
    
    // Store code from UI
    NSString *code = textField.text;
    
    // Hide keyword
    [textField resignFirstResponder];
    // Clear text field
    _textView.text = @"";
    
    // Show progress window
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Redeeming code...";
    
    
    // Create the request.
//    NSMutableURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/~darrencullen/webservices/promos/"]];
    NSURL *url = [NSURL URLWithString:@"http://localhost/~darrencullen/webservices/promos/"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // Specify that it will be a POST request
    urlRequest.HTTPMethod = @"POST";
    
    // This is how we set header fields
//    [urlRequest setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Convert your data and set your request's HTTPBody property
    NSString *stringData = [NSString stringWithFormat:@"rw_app_id=1&code=%@&device_id=%@", code, uniqueIdentifier];
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest.HTTPBody = requestBodyData;
    
    // Create url connection and fire request
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    
////
//    // Start NSURLSession
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    // POST parameters
//    NSURL *url = [NSURL URLWithString:@"http://localhost/~darrencullen/promos/"];
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *params = [NSString stringWithFormat:@"rw_app_id=1&code=%@&device_id=%@", code, uniqueIdentifier];
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
//    // NSURLSessionDataTask returns data, response, and error
//    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:urlRequest
//                                                      completionHandler:^(NSData *data,
//                                                                          NSURLResponse *response,
//                                                                          NSError *error) {
//                                                          
//              // Remove progress window
//              [MBProgressHUD hideHUDForView:self.view animated:YES];
//              // Handle response
//              NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
//              NSInteger statusCode = [httpResponse statusCode];
//              if(error == nil) {
//                  
//                  if (statusCode == 400) {
//                      _textView.text = @"Invalid code";
//                  } else if (statusCode == 403) {
//                      _textView.text = @"Code already used";
//                  } else if (statusCode == 200) {
//                      
//                      // Parse out the JSON data
//                      NSError *jsonError;
//                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
//                                                                           options:kNilOptions
//                                                                             error:&jsonError];
//                      
//                      NSString* unlockCode = [json objectForKey:@"unlock_code"];
//                      
//                      // JSON data parsed, continue handling response
//                      if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame) {
//                          _textView.text = @"The cake is a lie!";
//                      } else {
//                          _textView.text = [NSString stringWithFormat:@"Received unexpected unlock code: %@", unlockCode];
//                      }
//                      
//                  } else {
//                      _textView.text = @"Unexpected error";
//                  }
//                  
//              } else {
//                  _textView.text = error.localizedDescription;
//              }
//              
//          }];
//    [dataTask resume];
    
    return TRUE;
}
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
//    NSLog(@"jsonObject is %@",_responseData);
    NSError *jsonError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&jsonError];
    
    NSString* unlockCode = [json objectForKey:@"unlock_code"];
    
    // JSON data parsed, continue handling response
    if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame) {
        _textView.text = @"The cake is a lie!";
    } else {
        _textView.text = [NSString stringWithFormat:@"Received unexpected unlock code: %@", unlockCode];
    }
    
    
//    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
//    NSInteger statusCode = [httpResponse statusCode];
//    if(error == nil) {
//        
//        if (statusCode == 400) {
//            _textView.text = @"Invalid code";
//        } else if (statusCode == 403) {
//            _textView.text = @"Code already used";
//        } else if (statusCode == 200) {
//            
//            // Parse out the JSON data
//            NSError *jsonError;
//            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
//                                                                 options:kNilOptions
//                                                                   error:&jsonError];
//            
//            NSString* unlockCode = [json objectForKey:@"unlock_code"];
//            
//            // JSON data parsed, continue handling response
//            if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame) {
//                _textView.text = @"The cake is a lie!";
//            } else {
//                _textView.text = [NSString stringWithFormat:@"Received unexpected unlock code: %@", unlockCode];
//            }
//            
//        } else {
//            _textView.text = @"Unexpected error";
//        }
//        
//    } else {
//        _textView.text = error.localizedDescription;
//    }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
