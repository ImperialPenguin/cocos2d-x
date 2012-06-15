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
#include "CCEGLView.h"


@implementation AppController

// cocos2d application instance
static AppDelegate s_sharedApplication;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //    cocos2d::CCDirectorMac *director = (cocos2d::CCDirectorMac*) cocos2d::CCDirectorMac::sharedDirector();
    //    
    NSRect rect = NSMakeRect(650, 350, 800, 480);    
    window = [[NSWindow alloc] initWithContentRect: rect styleMask:( NSClosableWindowMask | NSTitledWindowMask) backing:NSBackingStoreBuffered defer:YES];
    
    rect = NSMakeRect(0, 0, 800, 480);    
    glView = [[EAGLView alloc] initWithFrame:rect];
    [glView initWithFrame:rect];
    [window setContentView:glView];
    
    cocos2d::CCEGLView * pMainWnd = new cocos2d::CCEGLView();
    pMainWnd->Create(800, 480, 480, 320);

    [window setTitle:@"Cocos2d-x Tests"];
    
    [window makeKeyAndOrderFront:self];
    
    cocos2d::CCApplication::sharedApplication().run();
    cocos2d::CCDirector::sharedDirector()->setDeviceOrientation(cocos2d::CCDeviceOrientationLandscapeLeft);
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return YES;
}

- (void)dealloc
{
	cocos2d::CCDirectorMac::sharedDirector()->end();
	[super dealloc];
}

#pragma mark AppDelegate - IBActions

- (IBAction)toggleFullScreen: (id)sender
{
    cocos2d::CCDirectorMac *director = (cocos2d::CCDirectorMac*) cocos2d::CCDirectorMac::sharedDirector();
	director->setFullScreen(!director->isFullScreen());
}

@end
