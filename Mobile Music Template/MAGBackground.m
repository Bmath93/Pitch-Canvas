//
//  MAGBackground.m
//  Mobile Music Template
//
//  Created by MillTwo on 7/2/13.
//  Copyright (c) 2013 MAG. All rights reserved.
//

#import "MAGBackground.h"
#import "MAGCircle.h"
#import "MAGCircleArray.h"
#import "MAGGesture.h"
#import "MAGSample.h"

@interface MAGBackground()

@property (strong, nonatomic) UIImage *backgroundImage;

@end

@implementation MAGBackground

@synthesize circles = _circles;

@synthesize allGestures = _allGestures;

-(void)awakeFromNib
{
    // self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }

    return self;
}

- (void)drawRect:(CGRect)rect
{
    //iterates through the circles, drawing each one
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.backgroundImage == NULL)
    {
        for (int counter = 0; counter < self.circles.circleArray.count; counter = counter + 1)
        {
            NSArray *currentColumn = self.circles.circleArray[counter];
            for (int counter2 = 0; counter2 < currentColumn.count; counter2 = counter2 + 1) {
                MAGCircle *aCircle = currentColumn[counter2];
                NSString *currentNoteName = [NSString stringWithFormat:@"Z#"];
                if (aCircle.pitch.intValue%12 == 0) {CGContextSetRGBFillColor(context, 0.8, 0.0, 0.0, 0.1); currentNoteName = @"C";}
                else if (aCircle.pitch.intValue%12 == 1) {CGContextSetRGBFillColor(context, 1.0, 0.25, 0.0, 0.1); currentNoteName = @"C#";}
                else if (aCircle.pitch.intValue%12 == 2) {CGContextSetRGBFillColor(context, 1.0, 0.5, 0.0, 0.1); currentNoteName = @"D";}
                else if (aCircle.pitch.intValue%12 == 3) {CGContextSetRGBFillColor(context, 1.0, 0.75, 0.0, 0.1); currentNoteName = @"D#";}
                else if (aCircle.pitch.intValue%12 == 4) {CGContextSetRGBFillColor(context, 1.0, 1.0, 0.0, 0.1); currentNoteName = @"E";}
                else if (aCircle.pitch.intValue%12 == 5) {CGContextSetRGBFillColor(context, 0.5, 1.0, 0.0, 0.1); currentNoteName = @"F";}
                else if (aCircle.pitch.intValue%12 == 6) {CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.1); currentNoteName = @"F#";}
                else if (aCircle.pitch.intValue%12 == 7) {CGContextSetRGBFillColor(context, 0.0, 1.0, 0.5, 0.1); currentNoteName = @"G";}
                else if (aCircle.pitch.intValue%12 == 8) {CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 0.1); currentNoteName = @"G#";}
                else if (aCircle.pitch.intValue%12 == 9) {CGContextSetRGBFillColor(context, 0.0, 0.5, 1.0, 0.1); currentNoteName = @"A";}
                else if (aCircle.pitch.intValue%12 == 10) {CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 0.1); currentNoteName = @"A#";}
                else if (aCircle.pitch.intValue%12 == 11) {CGContextSetRGBFillColor(context, 0.5, 0.0, 0.9, 0.1); currentNoteName = @"B";}
                else {NSLog(@"%i",aCircle.pitch.intValue%12);}
                
                CGPoint rectOrigin = CGPointMake(aCircle.center.x-aCircle.radius.floatValue,aCircle.center.y-aCircle.radius.floatValue);
                
                CGRect newRect = CGRectMake(rectOrigin.x,rectOrigin.y,aCircle.radius.floatValue*2.0,aCircle.radius.floatValue*2.0);
                
                CGContextAddEllipseInRect(context,newRect);
                
                //CGContextStrokePath(context);
                
                CGContextFillPath(context);
                
                UILabel *noteLabel = [[UILabel alloc] initWithFrame:newRect];
                noteLabel.text = currentNoteName;
                noteLabel.textColor = [[UIColor alloc] initWithWhite:0.5 alpha:1.0];
                [noteLabel drawTextInRect:CGRectMake(aCircle.center.x - 4.0, aCircle.center.y-aCircle.radius.floatValue,aCircle.radius.floatValue*2.0,aCircle.radius.floatValue*2.0)];
            }
        }
    }
        /*
        MAGCircle *aCircle = self.circles[counter];
         UIBezierPath *arc = [UIBezierPath bezierPathWithArcCenter:aCircle.center radius:aCircle.radius.floatValue startAngle:0.0 endAngle:360 clockwise:TRUE];
        [arc setLineWidth:4.0];
        [[UIColor blackColor] setStroke];
        [arc moveToPoint:CGPointMake(aCircle.center.x+aCircle.radius.floatValue,aCircle.center.y)];
        [arc stroke];
         
        CGMutablePathRef arcPath = CGPathCreateMutable();
        CGPathAddArc(arcPath, NULL, aCircle.center.x, aCircle.center.y, aCircle.radius.floatValue, 0, M_2_PI, TRUE);
        CGContextAddPath(context,arcPath);
        CGContextStrokePath(context);
         */
    else
    {
        NSLog(@"drawing");
        //CGContextDrawImage(context,CGRectMake(0, 0, 768, 1004), self.backgroundImage.CGImage);
        [self.backgroundImage drawInRect:CGRectMake(0, 0, 768, 1004)];
    }
    
    MAGGesture *currentGesture;
    MAGSample *currentSample;
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 1);
    for (int gestureCounter = 0; gestureCounter < self.allGestures.count; gestureCounter = gestureCounter + 1)
    {
        currentGesture = self.allGestures[gestureCounter];
        currentSample = currentGesture.sampleArray[0];
        CGContextMoveToPoint(context, currentSample.location.x, currentSample.location.y);
        for (int sampleCounter = 1; sampleCounter < [currentGesture.sampleArray count]; sampleCounter = sampleCounter + 1)
        {
            //NSLog(@"gestureCounter: %i, sampleCounter: %i",gestureCounter,sampleCounter);
           currentSample = currentGesture.sampleArray[sampleCounter];
            CGContextAddLineToPoint(context, currentSample.location.x, currentSample.location.y);
        }
    }
    CGContextStrokePath(context);
    //note symbols
    /*
     int delta = 173;
     CGContextMoveToPoint(context,63+delta,250);
     CGContextAddLineToPoint(context,112+delta,250);
     CGContextMoveToPoint(context,63+delta,260);
     CGContextAddLineToPoint(context,112+delta,260);
     CGContextMoveToPoint(context,63+delta,270);
     CGContextAddLineToPoint(context,112+delta,270);
     CGContextMoveToPoint(context,63+delta,280);
     CGContextAddLineToPoint(context,112+delta,280);
     CGContextMoveToPoint(context,63+delta,290);
     CGContextAddLineToPoint(context,112+delta,290);
     CGContextMoveToPoint(context,78+delta,300);
     CGContextAddLineToPoint(context,98+delta,300);
     CGContextMoveToPoint(context,93+delta,275);
     CGContextAddLineToPoint(context,93+delta,300);
     CGContextSetLineWidth(context, 2.0);
     CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
     CGContextStrokePath(context);
     CGContextAddEllipseInRect(context, CGRectMake(81.0+delta, 295.0, 13.0, 11.0));
     CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
     CGContextFillPath(context);
     */
}

@end