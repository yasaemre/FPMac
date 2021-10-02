//
//  Persistence.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//


import CoreData
import SwiftUI

struct PersistenceController {
    let container: NSPersistentContainer

    static let shared = PersistenceController()
     //Convenience
    var viewContext: NSManagedObjectContext {

        return container.viewContext
    }

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
    
//        // Companies
//        let deckCore = DeckCore(context: viewContext)
//        deckCore.deckName = "Apple"

        shared.saveContext()
        
        return result
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "FPMac") // else UnsafeRawBufferPointer with negative count
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } 
        
      

        
//        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        print(urls[urls.count-1] as URL)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        
        if Thread.isMainThread {
            print("on main thread")
        } else {
            print("off main thread")
        }
        
        //Set the Query generation to .current. for dynamically updating views from Cloudkit
        try? container.viewContext.setQueryGenerationFrom(.current)
        
    }
    
    
    
    // Better save
     func saveContext() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
               
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
     
        
        
    }
}

