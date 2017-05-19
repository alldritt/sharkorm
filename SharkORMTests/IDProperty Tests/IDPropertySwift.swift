//
//  IDPropertySwift.swift
//  SharkORM
//
//  Created by Mark Alldritt on 2017-05-19.
//  Copyright © 2017 Adrian Herridge. All rights reserved.
//

import XCTest


class IDPropertySwift: BaseTestCaseSwift {

    public func testBoolean() {
        cleardown()
        
        let key1 = "key1"
        let value1 = true
        let key2 = "key2"
        let value2 = false
        
        var p = KeyValue()
        p.key = key1
        p.value = value1
        p.commit()
        
        p = KeyValue()
        p.key = key2
        p.value = value2
        p.commit()
        
        XCTAssert(KeyValue.query().count() == 2, "Failed to insert 2 records")
        
        // key1/value1
        var pp = KeyValue.query().where(withFormat: "key = %@", withParameters: [key1]).fetch().firstObject as? KeyValue
        XCTAssert(pp != nil, "Failed to retrieve KeyValue record");
        
        XCTAssertEqual(pp?.key, key1, "Keys don't match for key1")
        XCTAssertEqual(pp?.value as? Bool, value1, "Values don't match for key1")
        
        //  key2/value2
        pp = KeyValue.query().where(withFormat: "key = %@", withParameters: [key2]).fetch().firstObject as? KeyValue
        XCTAssert(pp != nil, "Failed to retrieve KeyValue record");
        
        XCTAssertEqual(pp?.key, key2, "Keys don't match for key2");
        XCTAssertEqual(pp?.value as? Bool, value2, "Values don't match for key2");
    }

}
