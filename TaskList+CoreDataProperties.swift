//
//  TaskList+CoreDataProperties.swift
//  
//
//  Created by Danil Tymofeev on 26.05.2021.
//
//

import Foundation
import CoreData


extension TaskList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskList> {
        return NSFetchRequest<TaskList>(entityName: "TaskList")
    }

    @NSManaged public var task: Task?

}
