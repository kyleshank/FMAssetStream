//
//  FMAssetStreamTests.m
//  FMAssetStreamTests
//
//  Created by Kyle Shank on 07/08/2014.
//  Copyright (c) 2014 Kyle Shank. All rights reserved.
//

SpecBegin(InitialSpecs)

describe(@"these will fail", ^{
    
    it(@"will wait and fail", ^AsyncBlock {
        done();
    });
});

describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
    it(@"will wait and fail", ^AsyncBlock {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            done();
        });
    });
});

SpecEnd
