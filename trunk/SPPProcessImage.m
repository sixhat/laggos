/*
 Copyright (c) 2007 David Rodrigues
 
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
 */

#import "SPPProcessImage.h"

@implementation SPPProcessImage

- (void)processImage:(id)sender
{
//	NSLog(@"processImage");
	NSImage *im;
	NSSize iori;
	NSSize ifinal;

	im=[sender image];
	iori = [[sender image] size];			
	ifinal.width=240;
	ifinal.height=(int) (ifinal.width*iori.height/iori.width);
	

	NSImage *im2 = [[NSImage alloc] initWithSize:ifinal];
	
	[im2 lockFocus];
	
	[im drawInRect:NSMakeRect(0,0,ifinal.width,ifinal.height) fromRect:NSMakeRect(0,0,iori.width,iori.height) operation:NSCompositeSourceOver fraction:1.0];

	
	[im2 unlockFocus];
	
	
	NSBitmapImageRep *ooo;
	
	ooo = [[NSBitmapImageRep alloc] initWithData:[im2 TIFFRepresentation]];
	

	
	NSData *ood = [ooo representationUsingType:NSJPEGFileType properties:nil];	
	
	NSDate *agora = [NSDate date];
	
	NSString *vText = [agora descriptionWithCalendarFormat:@"%j%H%M%S%F" timeZone:nil locale:nil];
//	NSLog(vText);
	
	NSString *fullOutputPath =[@"~/Desktop/laggos_" stringByExpandingTildeInPath];
	fullOutputPath = [fullOutputPath stringByAppendingString:vText];
	fullOutputPath = [fullOutputPath stringByAppendingString:@".jpg"];
	
//	NSLog(fullOutputPath);	
	
	[ood writeToFile:fullOutputPath atomically:NO];
		
	
}

@end
