//
//  Person.swift
//  web-request-test
//
//  Created by Francisco Claret on 03/03/16.
//  Copyright © 2016 Francisco Claret. All rights reserved.
//

import Foundation

class Person {
    
    private var _name: String!
    private var _height: String!
    private var _birthYear: String!
    private var _hairColor: String!
    
    var name: String {
        get {
            return _name
        }
    }
    
    var height: String {
        get {
            return _height
        }
    }
    
    var birthYear: String {
        get {
            return _birthYear
        }
    }
    
    var hairColor: String {
        get {
            return _hairColor
        }
    }

    init(name: String, height: String, birthYear: String, hairColor: String) {
        
        self._name = name
        self._height = height
        self._birthYear = birthYear
        self._hairColor = hairColor
    }
}
