//
//  BaseTestCaseSwift.swift
//  SharkORM
//
//  Created by Mark Alldritt on 2017-05-19.
//  Copyright © 2017 Adrian Herridge. All rights reserved.
//

import XCTest


class BaseTestCaseSwift: XCTestCase, SRKDelegate {

    public var currentError : SRKError?
    
    override func setUp() {
        super.setUp()

        SharkORM.setDelegate(self)
        SharkORM.openDatabaseNamed("Persistence")
    }
    
    override func tearDown() {
        cleardown()
        
        SharkORM.closeDatabaseNamed("Persistence")
        SharkORM.setDelegate(nil)

        super.tearDown()
    }

    public func cleardown() {
        SharkORM.rawQuery("DELETE FROM Person;")
        SharkORM.rawQuery("DELETE FROM PersonSwift;")
        SharkORM.rawQuery("DELETE FROM Department;")
        SharkORM.rawQuery("DELETE FROM DepartmentSwift;")
        SharkORM.rawQuery("DELETE FROM Location;")
        SharkORM.rawQuery("DELETE FROM SmallPerson;")
        SharkORM.rawQuery("DELETE FROM StringIdObject;")
        SharkORM.rawQuery("DELETE FROM MostObjectTypes;")
        SharkORM.rawQuery("DELETE FROM MostObjectTypes;")
        SharkORM.rawQuery("DELETE FROM KeyValue;")
    }
    
    public func databaseError(_ error : SRKError) {
        print("error = \(error.errorMessage)\nsql=\(error.sqlQuery)")
    }

}
