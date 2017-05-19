//    MIT License
//
//    Copyright (c) 2017 SharkSync
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


#import "IDProperty.h"
#import "KeyValue.h"
#import "TestObject.h"


@implementation IDProperty

- (void)test_string {
    
    [self cleardown];
    
    NSString* key = @"key";
    NSString* value = @"The quick brown fox jumped over the lazy dog";
    KeyValue* p = [KeyValue new];
    
    p.key = key;
    p.value = value;
    [p commit];
    
    XCTAssert([[KeyValue query] count] == 1, @"Failed to insert 1 record");

    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
    XCTAssertEqualObjects(p.key, key, @"Keys don't match");
    XCTAssertEqualObjects(p.value, value, @"Values don't match");
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
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key1] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
    XCTAssertEqualObjects(p.key, key1, @"Keys don't match for key1");
    XCTAssertEqualObjects(p.value, value1, @"Values don't match for key1");
    
    //  key2/value2
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key2] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
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
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key1] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
    XCTAssertEqualObjects(p.key, key1, @"Keys don't match for key1");
    XCTAssertEqualObjects(p.value, value1, @"Values don't match for key1");
    
    //  key2/value2
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key2] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
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
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key1] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
    XCTAssertEqualObjects(p.key, key1, @"Keys don't match for key1");
    XCTAssertEqualObjects(p.value, value1, @"Values don't match for key1");
    
    //  key2/value2
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key2] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
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
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key1] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
    XCTAssertEqualObjects(p.key, key1, @"Keys don't match for key1");
    XCTAssertEqualObjects(p.value, value1, @"Values don't match for key1");
    //  Workaround...
    XCTAssert([[NSDate dateWithTimeIntervalSince1970:((NSNumber*) p.value).doubleValue] isEqualToDate:value1], @"Workaround values don't match for key1");
    
    //  key2/value2
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key2] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
    XCTAssertEqualObjects(p.key, key2, @"Keys don't match for key2");
    XCTAssertEqualObjects(p.value, value2, @"Values don't match for key2");
    //  Workaround...
    XCTAssert([[NSDate dateWithTimeIntervalSince1970:((NSNumber*) p.value).doubleValue] isEqualToDate:value2], @"Workaround values don't match for key2");
}

- (void)test_data {
    
    [self cleardown];
    
    NSString* key = @"key";
    NSData* value = [@"hello world" dataUsingEncoding:NSUTF16StringEncoding];
    
    KeyValue* p = [KeyValue new];
    p.key = key;
    p.value = value;
    [p commit];
    
    XCTAssert([[KeyValue query] count] == 1, @"Failed to insert 1 record");
    
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
    XCTAssertEqualObjects(p.key, key, @"Keys don't match");
    XCTAssertEqualObjects(p.value, value, @"Values don't match");
}

- (void)test_value {
    
    [self cleardown];
    
    NSString* key = @"key";
    NSValue* value = [NSValue valueWithRange:NSMakeRange(10, 100)];
    
    KeyValue* p = [KeyValue new];
    p.key = key;
    p.value = value;
    [p commit];
    
    XCTAssert([[KeyValue query] count] == 1, @"Failed to insert 1 record");
    
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
    XCTAssertEqualObjects(p.key, key, @"Keys don't match");
    XCTAssertEqualObjects(p.value, value, @"Values don't match");
}

- (void)test_null {
    
    [self cleardown];
    
    NSString* key = @"key";
    NSNull* value = [NSNull null];
    
    KeyValue* p = [KeyValue new];
    p.key = key;
    p.value = value;
    [p commit];
    
    XCTAssert([[KeyValue query] count] == 1, @"Failed to insert 1 record");
    
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
    XCTAssertEqualObjects(p.key, key, @"Keys don't match");
    XCTAssertEqualObjects(p.value, value, @"Values don't match");
}

- (void)test_object {
    
    [self cleardown];
    
    NSString* key = @"key";
    TestObject* value = [TestObject new];
    
    value.name = @"Mark";
    value.date = [NSDate date];
    
    KeyValue* p = [KeyValue new];
    p.key = key;
    p.value = value;
    [p commit];
    
    XCTAssert([[KeyValue query] count] == 1, @"Failed to insert 1 record");
    
    p = [[[[KeyValue query] whereWithFormat:@"key = %@", key] fetch] firstObject];
    XCTAssert(p, @"Failed to retrieve KeyValue record");
    
    XCTAssertEqualObjects(p.key, key, @"Keys don't match");
    XCTAssertEqualObjects(p.value, value, @"Values don't match");
}

@end
