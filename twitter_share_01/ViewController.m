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
@property (weak, nonatomic) IBOutlet UITextView *fbTextView;
@property (weak, nonatomic) IBOutlet UITextView *moreTextView;


-(void)configureTweetTextView;


@end

@implementation ViewController

-(void)showMessage:(NSString*) message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Social Share" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];

}
- (IBAction)showFacebook:(id)sender {
    
    if([self.fbTextView isFirstResponder]){
        [self.fbTextView resignFirstResponder];
    }
    
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Get Social" message:@"Post your message to the social network" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *fbAction = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
            
            SLComposeViewController *fbvc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            if([self.fbTextView.text length]<140){
                [fbvc setInitialText:self.fbTextView.text];
            }
            else{
                NSString *shortText = [self.fbTextView.text substringToIndex:140 ];
                [fbvc setInitialText:shortText];
            }
            [self presentViewController:fbvc animated:YES completion:nil];
        }
        else{
            [self showMessage:@"please sign in to facebook"];
        }
    }];
    
    [actionController addAction:action];
    [actionController addAction:fbAction];

    
    [self presentViewController:actionController animated:NO completion:nil];

    
    
    
}
- (IBAction)doNothing:(id)sender {
    
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"No way!!" message:@"This button does absolutely nothing!!!" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    [actionController addAction:action];
    
    [self presentViewController:actionController animated:NO completion:nil];
        
}
- (IBAction)showMore:(id)sender {
    
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Get Social" message:@"Post your message to the social network" preferredStyle:UIAlertControllerStyleAlert];

    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"More" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        UIActivityViewController *morevc = [[UIActivityViewController alloc]initWithActivityItems:@[self.moreTextView.text] applicationActivities:nil];
        [self presentViewController:morevc animated:YES completion:nil];
    }];
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    [actionController addAction:moreAction];
    [actionController addAction:action];
    [self presentViewController:actionController animated:YES completion:nil];
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
    
    [actionController addAction:tweetAction];
    [actionController addAction:action];
    
    [self presentViewController:actionController animated:NO completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureTweetTextView];
    [self configureFacebookTextView];
    [self configureMoreTextView];
    
    
}


-(void)configureFacebookTextView{
    
    self.fbTextView.layer.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.2].CGColor;
    
    self.fbTextView.layer.cornerRadius =10.0;
    
    self.fbTextView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.9].CGColor;
    
    self.fbTextView.layer.borderWidth = 2.0;


}

-(void)configureTweetTextView{

    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2].CGColor;
    
    self.tweetTextView.layer.cornerRadius =10.0;
    
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.9].CGColor;
    
    self.tweetTextView.layer.borderWidth = 2.0;
    
}

-(void)configureMoreTextView{
    
    self.moreTextView.layer.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.2].CGColor;
    
    self.moreTextView.layer.cornerRadius =10.0;
    
    self.moreTextView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.9].CGColor;
    
    self.moreTextView.layer.borderWidth = 2.0;
    
}
@end
