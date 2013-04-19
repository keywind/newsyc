//
//  PocketSubmission.h
//  newsyc
//
//  Created by Dafeng Jin on 13-4-19.
//
//

#import <Foundation/Foundation.h>

@interface PocketSubmission : NSObject {
    NSURL *url;
}

- (id)initWithURL:(NSURL *)url;
- (UIViewController *)submitFromController:(UIViewController *)controller;

@end
