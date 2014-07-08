//
//  NSMutableURLRequest+FMAssetStream.h
//  Pods
//
//  Created by Kyle Shank on 7/8/14.
//
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "FMAssetInputStream.h"

@interface NSMutableURLRequest (FMAssetStream)

-(void)setAsset:(ALAsset*)asset;
-(void)setAsset:(ALAsset*)asset delegate:(id<FMAssetInputStreamDelegate>) delegate;

@end
