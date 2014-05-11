//
//  AppDelegate.m
//  xingtest
//
//  Created by Jose Alcalá Correa on 07/05/14.
//  Copyright (c) 2014 joseac. All rights reserved.
//

#import "AppDelegate.h"
#import <XNGAPIClient.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([[XNGAPIClient sharedClient] handleOpenURL:url]) {
        NSLog(@"handled login url");
        return YES;
    } else {
        
        
    }
    
    return NO;
}


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    XNGAPIClient *client = [XNGAPIClient sharedClient];
    client.consumerKey = @"6c4bbf836346005cd62d";
    client.consumerSecret = @"df18bd41e76cc04ca5e1f9660e8f0a50648831d8";
    
    return YES;
}

@end
