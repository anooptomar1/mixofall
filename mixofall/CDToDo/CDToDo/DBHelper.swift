//
//  DBHelper.swift
//  CDToDo
//
//  Created by Anoop tomar on 5/5/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreData

class DBHelper{
    
    private let appDel: AppDelegate
    private let context: NSManagedObjectContext
    private let entity: NSEntityDescription
    private let DB_NAME = "Todo"
    
    init(){
        self.appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        self.context = appDel.managedObjectContext!
        self.entity = NSEntityDescription.entityForName(DB_NAME, inManagedObjectContext: context)!
    }
    
    func addNewTodo(todo: TodoModel){
        let newTodo = Todo(entity: entity, insertIntoManagedObjectContext: context)
        newTodo.title = todo.title!
        newTodo.desc = todo.desc!
        newTodo.due_date = todo.due_date!
        newTodo.finished = todo.finished!
        self.context.save(nil)
    }
    
    func getItemByTitle(title: String) -> TodoModel?{
        let request = NSFetchRequest(entityName: DB_NAME)
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "title = %@", title)
        let result:NSArray = context.executeFetchRequest(request, error: nil)!
        if result.count > 0{
            return convertTodoToModel(result[0] as! Todo)
        }
        return nil
    }
    
    func getAllItems() -> [TodoModel]?{
        let request = NSFetchRequest(entityName: DB_NAME)
        request.returnsObjectsAsFaults = false
        let result: NSArray = context.executeFetchRequest(request, error: nil)!
        if result.count > 0 {
            var todoItems = [TodoModel]()
            for item in result{
                todoItems.append(convertTodoToModel(item as! Todo))
            }
            return todoItems
        }
        return nil
    }
    
    private func convertTodoToModel(todoItem: Todo) -> TodoModel{
        let todoModel = TodoModel()
        todoModel.title = todoItem.title
        todoModel.desc = todoItem.desc
        todoModel.due_date = todoItem.due_date
        todoModel.finished = todoItem.finished
        return todoModel
    }

}

class TodoModel{
    var title: String?
    var desc: String?
    var finished: NSNumber?
    var due_date: NSDate?
}