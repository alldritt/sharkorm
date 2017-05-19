//
//  TestObject.m
//  SharkORM
//
//  Created by Mark Alldritt on 2017-05-19.
//  Copyright © 2017 Adrian Herridge. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

- (id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.date forKey:@"date"];
}

- (BOOL) isEqual:(id)object {
    return [object isMemberOfClass:[TestObject class]] &&
           [self.name isEqual:((TestObject*) object).name] &&
           [self.date isEqual:((TestObject*) object).date];
}

@end
