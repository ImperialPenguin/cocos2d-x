//
//  AppDelegate.m
//  test
//
//  Created by John Garrison on 6/9/12.
//  Copyright (c) 2012 Imperial Penguin. All rights reserved.
//
#include "CCPlatformConfig.h"
#include "AppDelegate.h"
#import "AppController.h"
#include "CCDirectorMac.h"


@implementation AppController
@synthesize window, glView;

// cocos2d application instance
static AppDelegate s_sharedApplication;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //    cocos2d::CCDirectorMac *director = (cocos2d::CCDirectorMac*) cocos2d::CCDirectorMac::sharedDirector();
    //    
    NSRect rect = NSMakeRect(0, 0, 480, 320);    
    window = [[NSWindow alloc] initWithContentRect: rect styleMask:( NSResizableWindowMask | NSClosableWindowMask | NSTitledWindowMask) backing:NSBackingStoreBuffered defer:YES];
    
    glView = [[EAGLView alloc] initWithFrame:rect];
    [glView initWithFrame:rect];
    [window setContentView:glView];
    
    [window makeKeyAndOrderFront:self];
    cocos2d::CCApplication::sharedApplication().run();
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return YES;
}

- (void)dealloc
{
	cocos2d::CCDirectorMac::sharedDirector()->end();
	[window release];
    [glView release];
	[super dealloc];
}

#pragma mark AppDelegate - IBActions

- (IBAction)toggleFullScreen: (id)sender
{
    cocos2d::CCDirectorMac *director = (cocos2d::CCDirectorMac*) cocos2d::CCDirectorMac::sharedDirector();
	director->setFullScreen(!director->isFullScreen());
}

@end
