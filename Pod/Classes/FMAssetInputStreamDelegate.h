//
//  FMAssetInputStreamDelegate.h
//  Pods
//
//  Created by Kyle Shank on 7/8/14.
//
//

#import <Foundation/Foundation.h>

@protocol FMAssetInputStreamDelegate <NSObject>
@required
- (void) progressBytes:(long long)progress totalBytes:(long long)total;
@end
