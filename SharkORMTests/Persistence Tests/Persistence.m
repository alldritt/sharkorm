//
//  Persistence.m
//  SharkORM
//
//  Copyright © 2016 SharkSync. All rights reserved.
//

#import "Persistence.h"

@implementation Persistence

- (void)test_Simple_Object_Insert {
    
    [self cleardown];
    
    Person* p = [Person new];
    BOOL result = [p commit];
    XCTAssert(result,@"Failed to insert simple object (without values)");
    XCTAssert([Person query].count, @"BOOL <return value> from commit was TRUE but the count on the table was 0");
    
}

- (void)test_Simple_Object_Update {
    
    [self cleardown];
    
    Person* p = [Person new];
    p.Name = @"Adrian";
    BOOL result = [p commit];
    if (result) {
        Person* p2 = [[Person query] fetch].firstObject;
        if (p2) {
            p2.Name = @"Sarah";
            XCTAssert([p2 commit],@"Failed to update existing record with new values");
            Person* p3 = [[Person query] fetch].firstObject;
            XCTAssert([p3.Name isEqualToString:@"Sarah"],@"Non current value retrieved from store");
        } else {
            XCTAssert(p2,@"Object which was believed to be persisted, failed to be retrieved");
        }
    } else {
        XCTAssert(result,@"Failed to insert simple object (without values)");
    }
    
}

- (void)test_Simple_Object_Delete {
    
    [self cleardown];
    
    Person* p = [Person new];
    BOOL result = [p commit];
    if (result) {
        [[[Person query] fetch] remove];
        XCTAssert([Person query].count == 0, @"'removeAll' called, but objects remain in table");
    } else {
        XCTAssert(result,@"Failed to insert simple object (without values)");
    }
    
}

- (void)test_Multiple_Object_Insert {
    
    [self cleardown];
    
    Person* p1 = [Person new];
    Person* p2 = [Person new];
    Person* p3 = [Person new];
    
    [p1 commit];
    [p2 commit];
    [p3 commit];
    
    XCTAssert([Person query].count == 3, @"Insert 3 records inline failed");
    
}

- (void)test_Single_Object_Insert_Multiple_Times {
    
    [self cleardown];
    
    Person* p1 = [Person new];
    
    [p1 commit];
    [p1 commit];
    [p1 commit];
    
    XCTAssert([Person query].count == 1, @"Insert 1 record 3 times failed");
    
}

- (void)test_Nested_Object_Insert {
    
    [self cleardown];
    
    Person* p = [Person new];
    p.Name = @"New Person";
    p.department = [Department new];
    p.department.name = @"New Department";
    [p commit];
    
    XCTAssert([Person query].count == 1, @"Insert 1 record with a related/embedded object has failed");
    XCTAssert([Department query].count == 1, @"Insert 1 related record via a parent object");
    
    // actually check the correct object exists
    Department* d = [[[Department query] fetch] firstObject];
    XCTAssert(d != nil, @"Department object not retrieved");
    XCTAssert([d.name isEqualToString:@"New Department"], @"Invalid 'name' value in department object");
    
    
}

- (void)test_Nested_Object_Update {
    
    [self cleardown];
    
    Person* p = [Person new];
    p.Name = @"New Person";
    p.department = [Department new];
    p.department.name = @"New Department";
    [p commit];
    
    XCTAssert([Person query].count == 1, @"Insert 1 record with a related/embedded object has failed");
    XCTAssert([Department query].count == 1, @"Insert 1 related record via a parent object");
    
    // actually check the correct object exists
    Department* d = [[[Department query] fetch] firstObject];
    XCTAssert(d != nil, @"Department object not retrieved");
    XCTAssert([d.name isEqualToString:@"New Department"], @"Invalid 'name' value in department object");
    
    // now check persistence of an update to a related object when commit is called on the parent object
    p.department.name = @"New Name";
    [p commit];
    
    d = [[[Department query] fetch] firstObject];
    XCTAssert(d != nil, @"Department object not retrieved");
    XCTAssert([d.name isEqualToString:@"New Name"], @"Invalid 'name' value in department object after persistence call to parent object");
    
}

- (void)test_all_object_types {
    
    [[[MostObjectTypes query] fetchLightweight] removeAll];
    
    MostObjectTypes* ob = [MostObjectTypes new];
    ob.number = @(42);
    ob.array = @[@(1),@(2),@(3)];
    ob.date = [NSDate date];
    ob.dictionary = @{@"one" : @(1), @"two" : @(2)};
    ob.intvalue = 42;
    ob.floatValue = 42.424242f;
    ob.doubleValue = 1234567.1234567;
    [ob commit];
    
    SRKResultSet* r = [[MostObjectTypes query] fetch];
    for (MostObjectTypes* mot in r) {
        NSLog(@"%@", mot);
    }
    
}

- (void)test_invalid_object_types {
    
    MostObjectTypes* ob = [MostObjectTypes new];
    ob.number = @(42);
    ob.array = @[@(1),@(2),@(3)];
    ob.date = [NSDate date];
    ob.dictionary = @{@"vc" : (NSDictionary*)[[UIViewController alloc] init]};
    ob.intvalue = 42;
    ob.floatValue = 42.424242f;
    ob.doubleValue = 1234567.1234567;
    [ob commit];
    
    MostObjectTypes* r = (id)[[MostObjectTypes query] fetch].firstObject;
    
}

- (void)test_string_pk_object {
    
    StringIdObject* obj = [StringIdObject new];
    obj.value = @"test value];";
    
    // there should not be a UUID yet for the PK column
    XCTAssert(obj.Id == nil, @"Primary key had been generated prior to insertion into data store");
    [obj commit];
    XCTAssert(obj.Id != nil, @"Primary key had not been generated post insertion into data store");
    
    StringIdObject* o2 = [StringIdObject objectWithPrimaryKeyValue:obj.Id];
    XCTAssert(o2 != nil, @"Retrieval of object with a string PK value failed");
    
}

- (void)test_initial_values {
    
    [self cleardown];
    
    Person* p = [[Person alloc] initWithDictionary:@{@"Name":@"Adrian Herridge",@"age":@(38)}];
    
    XCTAssert(p.age == 38,@"initial values population failed");
    
    [p commit];
    
    int64_t count = [[[Person query] where:@"Name = 'Adrian Herridge' AND age = 38 AND seq = 0 AND department IS NULL"] count];
    
    XCTAssert(count == 1,@"initial values population failed");
    
}


@end
