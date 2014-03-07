//
//  WRQViewController.m
//  Wit
//
//  Created by Donny Kurniawan on 18/02/2014.
//  Copyright (c) 2014 Worqbench. All rights reserved.
//

#import "WRQViewController.h"

@interface WRQViewController ()

@end

@implementation WRQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set the WitDelegate object
    [Wit sharedInstance].delegate = self;
    [Wit sharedInstance].commandDelegate = self;
    
    // Create the button
    CGRect screen = [UIScreen mainScreen].bounds;
    CGFloat w = 100;
    CGRect rect = CGRectMake(screen.size.width/2 - w/2, 60, w, 100);
    
    WITMicButton* witButton = [[WITMicButton alloc] initWithFrame:rect];
    [self.view addSubview:witButton];
    
    // Create the label
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 250, screen.size.width, 200)];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.tag = 100;
    textView.text = @"Tap to start and end the speech...";
    [self.view addSubview:textView];
}

- (void)witDidGraspIntent:(NSString *)intent entities:(NSDictionary *)entities body:(NSString *)body error:(NSError *)e {
    if (e) {
        NSLog(@"Error: %@", [e localizedDescription]);
        return;
    }

    // Get the name
    NSString *name = [NSString stringWithString:entities[@"contact"][@"value"]];
    NSArray* names = [name componentsSeparatedByString:@" "];
    NSString *firstName = [names objectAtIndex:0];
    NSString *lastName = [names objectAtIndex:1];
    
    // Get the joke
    NSString *url = [NSString stringWithFormat:@"http://intu-jokes.herokuapp.com/joke/%@/%@", firstName, lastName];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLResponse *response;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *joke = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UITextView *textView = (UITextView *)[self.view viewWithTag:100]; // Ignore capturing self in block
        textView.text = joke;
    });
}

- (void)witDidStartRecording
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UITextView *textView = (UITextView *)[self.view viewWithTag:100]; // Ignore capturing self in block
        textView.text = @"Recording and processing...";
    });
}

@end
