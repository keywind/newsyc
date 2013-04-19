//
//  PocketActivity.m
//  newsyc
//
//  Created by Dafeng Jin on 13-4-18.
//
//

#import "PocketActivity.h"
#import "PocketSubmission.h"

@implementation PocketActivity

- (void)dealloc {
    [submission release];
    [super dealloc];
}

- (NSString *)activityType {
    return @"com.readitlater.pocket";
}

- (NSString *)activityTitle {
    return @"Pocket";
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"PocketActivity.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    [submission release];
    
    submission = [[PocketSubmission alloc] initWithURL:[activityItems objectAtIndex:0]];
}

- (UIViewController *)activityViewController {
    return [submission submitFromController:nil];
}

- (void)performActivity {
    [self activityDidFinish:YES];
}

@end
