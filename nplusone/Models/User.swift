//
//  User.swift
//  nplusone
//
//  Created by clutchcoder on 11/4/24.
//

import Foundation
import CoreData

public class User: NSManagedObject, Identifiable {
    @NSManaged public var username: String
    @NSManaged public var items: [Item]
}
