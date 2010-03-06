/*
//  DRControl.m
//  ClockItX
//
//  Created by David Rodrigues on 09/01/30.

 The MIT License
 
 Copyright (c) 2008 David Rodrigues
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 * 
 */


#import "DRControl.h"


@implementation DRControl

- (id) init 
{
    [super init];
    srandom(time(NULL));
    ison=FALSE;
    clockTime=0;
    startTime=0;
    groundTime=0;
    NSLog(@"%d",time(NULL));
    return self;
}

- (void) quit:(id)sender
{
    NSLog(@"Quit App");
    exit(0);
}


- (void) onoff:(id)sender
{
    NSLog(@"onoff pressed");
    if (!ison) {
        NSLog(@"Turning it ON");
        if (timer==nil)
        { 
            [self startClock];
            [textField setTextColor:[NSColor greenColor]];
            [sender setTitle:@"On Air"];
        }
        ison=TRUE;
    } else {
        NSLog(@"Turning it OFF");
        [textField setTextColor:[NSColor blueColor]];
        ison=FALSE;
        groundTime=clockTime;
        [timer invalidate];
        [timer release];
        timer=nil;
        [sender setTitle:@"Off Air"];
    }
    
}
- (void) reset:(id)sender
{
    NSLog(@"reset pressed");
    ison=FALSE;
    clockTime=0;
    startTime=0;
    groundTime=0;
    [self stopClock];
    [textField setTextColor:[NSColor blackColor]];
    [self updateClock];
}

- (void) updateClock{
    clockTime=time(NULL)-startTime+groundTime;
    NSLog(@"%d",clockTime);
    if (timer!=nil) {
        [textField setStringValue:[NSString stringWithFormat:@"%u:%.2u", (int)(clockTime/10), clockTime%10]];
    } 
}
- (void) startClock
{
    timer=[[NSTimer scheduledTimerWithTimeInterval:0.1
                                            target:self selector:@selector(updateClock)
                                          userInfo:nil repeats:YES] retain];
    startTime=time(NULL);
}
- (void) stopClock
{
    [timer invalidate];
    [timer release];
    timer=nil;
    [textField setStringValue:@"0:00"];
}

@end
