//
//  FMViewController.m
//  FMAssetStream
//
//  Created by Kyle Shank on 07/08/2014.
//  Copyright (c) 2014 Kyle Shank. All rights reserved.
//

#import "FMViewController.h"
#import <FMProgressViewController/UIViewController+FMProgress.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <FMAssetStream/NSMutableURLRequest+FMAssetStream.h>

@interface FMViewController ()
@property (nonatomic, retain) ALAssetsLibrary* library;
@property (nonatomic, retain) NSURLConnection* connection;
@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)uploadFile:(id)sender{
    // Grabs test image test.png
    UIImage* imageToSave = [UIImage imageNamed:@"test.png"];
    
    self.library = [[ALAssetsLibrary alloc] init];
    
    FMViewController* myself = self;
    
    // Writes test image into local photo album
    [self.library writeImageToSavedPhotosAlbum:[imageToSave CGImage] orientation:(ALAssetOrientation)[imageToSave imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            NSLog(@"Asset library writeImageToSavedPhotosAlbum error %@", error);
        } else {
            // Gets reference to the ALAsset that was created
            [self.library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://s3.amazonaws.com/fmassetstream-test1/test.png"]];
                [request setHTTPMethod:@"PUT"];
                
                // setAsset is the additional category method from FMAssetStream
                // Takes an ALAsset and an FMAssetInputStreamDelegate for getting progress updates
                [request setAsset:asset delegate:myself];
       
                [myself setTitle:@"Uploading..."];
                self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            } failureBlock:^(NSError *error) {
                NSLog(@"Asset library assetForURL error %@", error);
            }];
        }
    }];
}

#pragma mark FMAssetInputStream Delegate Methods

- (void) progressBytes:(long long)progress totalBytes:(long long)total{
    float percentage = (float)progress / (float)total;
    
    // set the percentage (float between 0.0 and 1.0) on the FMProgressViewController provided progress bar
    self.fm_progress = percentage;
    if( progress == total){
        [self setTitle:@"Done!"];
    }
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"Connection error %@", error);
}

@end
