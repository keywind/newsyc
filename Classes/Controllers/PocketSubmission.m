//
//  PocketSubmission.m
//  newsyc
//
//  Created by Dafeng Jin on 13-4-19.
//
//

#import "PocketSubmission.h"
#import "ProgressHUD.h"
#import "PocketAPI.h"

@implementation PocketSubmission

- (id)initWithURL:(NSURL *)url_ {
    if ((self = [super init])) {
        url = [url_ copy];
    }
    
    return self;
}

- (void)dealloc {
    [url release];
    
    [super dealloc];
}

- (void)submitPocketRequest {
    ProgressHUD *hud = [[ProgressHUD alloc] init];
    [hud setText:@"Saving"];
    [hud showInWindow:[[UIApplication sharedApplication] keyWindow]];
    [hud release];
    
    [[PocketAPI sharedAPI] saveURL:url handler:^(PocketAPI *api, NSURL *url_, NSError *error) {
        if(!error){
            [hud setText:@"Saved!"];
            [hud setState:kProgressHUDStateCompleted];
            [hud dismissAfterDelay:0.8f animated:YES];
        }else{
            [hud setText:@"Error Saving"];
            [hud setState:kProgressHUDStateError];
            [hud dismissAfterDelay:0.8f animated:YES];
        }
    }];
}

- (UIViewController *)submitFromController:(UIViewController *)controller {
    if ([PocketAPI sharedAPI].isLoggedIn) {
        [self submitPocketRequest];
    } else {
        [[PocketAPI sharedAPI] loginWithHandler:^(PocketAPI *api, NSError *error) {
            if(error){
                [self loginFailed:error];
            }else{
                [self loggedInSuccessfully];
            }
        }];
    }

    return nil;
}

-(void)loggedInSuccessfully{
	[self submitPocketRequest];
}

-(void)loginFailed:(NSError *)error{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error logging in"
														message:[NSString stringWithFormat:@"There was an error logging in: %@", [error localizedDescription]]
													   delegate:nil
											  cancelButtonTitle:nil
											  otherButtonTitles:nil];
	
	[alertView show];
	[alertView autorelease];
}

@end
