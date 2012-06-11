//
//  AppController.h
//  test
//
//  Created by John Garrison on 6/9/12.
//  Copyright (c) 2012 Imperial Penguin. All rights reserved.
//

#import "cocos2d.h"
#import "EAGLView_mac.h"

@interface AppController : NSObject <NSApplicationDelegate>
{
    NSWindow    *window;
    EAGLView	*glView;
}

- (IBAction)toggleFullScreen:(id)sender;

@end
