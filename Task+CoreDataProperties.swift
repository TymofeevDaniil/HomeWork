//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Danil Tymofeev on 26.05.2021.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var item: String?
    @NSManaged public var taskList: TaskList?

}
