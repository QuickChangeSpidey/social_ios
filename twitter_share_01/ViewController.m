//
//  ViewController.m
//  twitter_share_01
//
//  Created by Akshay Pandey on 4/13/17.
//  Copyright © 2017 Akshay Pandey. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;


-(void)configureTweetTextView;


@end

@implementation ViewController

-(void)showMessage:(NSString*) message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Social Share" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];

}

- (IBAction)showShare:(id)sender {
    
    if([self.tweetTextView isFirstResponder]){
            [self.tweetTextView resignFirstResponder];
    }
    
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Get Social" message:@"Post your message to the social network" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        
    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
            
            SLComposeViewController *twittervc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            if([self.tweetTextView.text length]<140){
                [twittervc setInitialText:self.tweetTextView.text];
            }
            else{
                NSString *shortText = [self.tweetTextView.text substringToIndex:140 ];
                [twittervc setInitialText:shortText];
            }
            [self presentViewController:twittervc animated:YES completion:nil];
        }
        else{
            [self showMessage:@"please sign in to twitter"];
        }
    }];
    
    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
            SLComposeViewController *facebookvc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            if([self.tweetTextView.text length]<140){
                [facebookvc setInitialText:self.tweetTextView.text];
            }
            else{
                NSString *shortText = [self.tweetTextView.text substringToIndex:140 ];
                [facebookvc setInitialText:shortText];
            }
            [self presentViewController:facebookvc animated:YES completion:nil];
        }
        else{
            [self showMessage:@"plesae log into facebook"];
        }
    }];
    
    [actionController addAction:tweetAction];
    [actionController addAction:facebookAction];
    [actionController addAction:action];
    
    [self presentViewController:actionController animated:NO completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureTweetTextView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)configureTweetTextView{


    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    
    self.tweetTextView.layer.cornerRadius =10.0;
    
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.9].CGColor;
    
    self.tweetTextView.layer.borderWidth = 2.0;
    
}
@end
