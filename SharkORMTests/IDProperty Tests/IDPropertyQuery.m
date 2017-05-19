//    MIT License
//
//    Copyright (c) 2016 SharkSync
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.


#import "IDPropertyQuery.h"
#import "KeyValue.h"


@implementation IDPropertyQuery

- (void)test_string {
    
    [self cleardown];
    
    NSString* key1 = @"key1";
    NSString* value1 = @"The quick brown fox jumped over the lazy dog";
    NSString* key2 = @"key2";
    NSString* value2 = @"Mark";

    KeyValue* p = [KeyValue new];
    p.key = key1;
    p.value = value1;
    [p commit];
    
    p = [KeyValue new];
    p.key = key2;
    p.value = value2;
    [p commit];
    XCTAssert([[KeyValue query] count] == 2, @"Failed to insert 2 records");
    
    // key1/value1
    p = [[[[KeyValue query] whereWithFormat:@"value = %@", value1] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record by value1");
    
    //  key2/value2
    p = [[[[KeyValue query] whereWithFormat:@"value = %@", value2] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record by value2");
}

- (void)test_boolean {
    
    [self cleardown];
    
    NSString* key1 = @"key1";
    NSNumber* value1 = @YES;
    NSString* key2 = @"key2";
    NSNumber* value2 = @NO;
    
    KeyValue* p = [KeyValue new];
    p.key = key1;
    p.value = value1;
    [p commit];
    
    p = [KeyValue new];
    p.key = key2;
    p.value = value2;
    [p commit];
    
    XCTAssert([[KeyValue query] count] == 2, @"Failed to insert 2 records");
    
    // key1/value1
    p = [[[[KeyValue query] whereWithFormat:@"value = %@", value1] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record by value1");
    XCTAssertEqualObjects(p.key, key1, @"Keys don't match for key1");
    XCTAssertEqualObjects(p.value, value1, @"Values don't match for key1");

    //  key2/value2
    p = [[[[KeyValue query] whereWithFormat:@"value = %@", value2] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record by value2");
    XCTAssertEqualObjects(p.key, key2, @"Keys don't match for key2");
    XCTAssertEqualObjects(p.value, value2, @"Values don't match for key2");
}

- (void)test_integer {
    
    [self cleardown];
    
    NSString* key1 = @"key1";
    NSNumber* value1 = @1234;
    NSString* key2 = @"key2";
    NSNumber* value2 = @-1000020000;
    
    KeyValue* p = [KeyValue new];
    p.key = key1;
    p.value = value1;
    [p commit];
    
    p = [KeyValue new];
    p.key = key2;
    p.value = value2;
    [p commit];
    
    XCTAssert([[KeyValue query] count] == 2, @"Failed to insert 2 records");
    
    // key1/value1
    p = [[[[KeyValue query] whereWithFormat:@"value = %@", value1] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record by value1");
    XCTAssertEqualObjects(p.key, key1, @"Keys don't match for key1");
    XCTAssertEqualObjects(p.value, value1, @"Values don't match for key1");
    
    //  key2/value2
    p = [[[[KeyValue query] whereWithFormat:@"value = %@", value2] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record by value2");
    XCTAssertEqualObjects(p.key, key2, @"Keys don't match for key2");
    XCTAssertEqualObjects(p.value, value2, @"Values don't match for key2");
}

- (void)test_double {
    
    [self cleardown];
    
    NSString* key1 = @"key1";
    NSNumber* value1 = @1234.3;
    NSString* key2 = @"key2";
    NSNumber* value2 = @-1232e30;
    
    KeyValue* p = [KeyValue new];
    p.key = key1;
    p.value = value1;
    [p commit];
    
    p = [KeyValue new];
    p.key = key2;
    p.value = value2;
    [p commit];
    
    XCTAssert([[KeyValue query] count] == 2, @"Failed to insert 2 records");
    
    // key1/value1
    p = [[[[KeyValue query] whereWithFormat:@"value = %@", value1] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record by value1");
    XCTAssertEqualObjects(p.key, key1, @"Keys don't match for key1");
    XCTAssertEqualObjects(p.value, value1, @"Values don't match for key1");
    
    //  key2/value2
    p = [[[[KeyValue query] whereWithFormat:@"value = %@", value2] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record by value2");
    XCTAssertEqualObjects(p.key, key2, @"Keys don't match for key2");
    XCTAssertEqualObjects(p.value, value2, @"Values don't match for key2");
}

- (void)test_date {
    
    [self cleardown];
    
    NSString* key1 = @"key1";
    NSDate* value1 = [NSDate date];
    NSString* key2 = @"key2";
    NSDate* value2 = [NSDate dateWithTimeIntervalSince1970:1000000];
    
    KeyValue* p = [KeyValue new];
    p.key = key1;
    p.value = value1;
    [p commit];
    
    p = [KeyValue new];
    p.key = key2;
    p.value = value2;
    [p commit];
    
    XCTAssert([[KeyValue query] count] == 2, @"Failed to insert 2 records");
    
    // key1/value1
    p = [[[[KeyValue query] whereWithFormat:@"value = %@", value1] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record by value1");
    XCTAssertEqualObjects(p.key, key1, @"Keys don't match for key1");
    XCTAssertEqualObjects(p.value, value1, @"Values don't match for key1");
    
    //  key2/value2
    p = [[[[KeyValue query] whereWithFormat:@"value = %@", value2] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record by value2");
    XCTAssertEqualObjects(p.key, key2, @"Keys don't match for key2");
    XCTAssertEqualObjects(p.value, value2, @"Values don't match for key2");
}

@end
