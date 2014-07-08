//
//  UIViewController+FMProgress.m
//  Pods
//
//  Created by Kyle Shank on 7/7/14.
//
//

#import "UIViewController+FMProgress.h"

#define FMPROGRESSTAG 19844
#define FMPROGRESSHEIGHT 2.0

@implementation UIViewController (FMProgress)

@dynamic fm_progress;

-(void)setFm_progress:(float)progress{
    if(self.navigationController){
        UIProgressView* progressView = (UIProgressView*)[self.navigationController.navigationBar viewWithTag:FMPROGRESSTAG];
        if(progressView==nil){
            progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0.0, self.navigationController.navigationBar.frame.size.height-FMPROGRESSHEIGHT, self.navigationController.navigationBar.frame.size.width, FMPROGRESSHEIGHT)];
            progressView.tag = FMPROGRESSTAG;
            [progressView setProgress:0.0f];
            [progressView setProgressTintColor:[UINavigationBar appearance].tintColor];
            [progressView setTrackTintColor:[UIColor clearColor]];
            [self.navigationController.navigationBar addSubview: progressView];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fmDidRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [progressView setProgress:progress];
        });
    }
}

-(float)fm_progress{
    UIProgressView* progressView = (UIProgressView*)[self.navigationController.navigationBar viewWithTag:FMPROGRESSTAG];
    if(progressView==nil){
        return 0.0f;
    }
    return progressView.progress;
}

- (void) fmDidRotate:(NSNotification *)notification
{
    if(self.navigationController){
        UIProgressView* progressView = (UIProgressView*)[self.navigationController.navigationBar viewWithTag:FMPROGRESSTAG];
        if(progressView != nil){
            [progressView setFrame:CGRectMake(0.0, self.navigationController.navigationBar.frame.size.height-FMPROGRESSHEIGHT, self.navigationController.navigationBar.frame.size.width, FMPROGRESSHEIGHT)];
        }
    }
}

@end
