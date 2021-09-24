//
//  ProfileCore+CoreDataProperties.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//
//


import Foundation
import CoreData


extension ProfileCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileCore> {
        return NSFetchRequest<ProfileCore>(entityName: "ProfileCore")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var lastName: String?
    @NSManaged public var age: String?
    @NSManaged public var sex: String?
    @NSManaged public var location: String?
    @NSManaged public var id: UUID?
    @NSManaged public var date: String?
    
    func getTodayDate() -> String
    {
        let today = Date()
        let formatter3 = DateFormatter()
        formatter3.dateStyle = .short
        return formatter3.string(from: today)
        
    }

//
//    public var likedArray: [ProfileCore] {
//        let cardsSet = photos as? Set<ProfileCore> ?? []
//
//        return cardsSet.sorted {
//            $0.unwrappedWord < $1.unwrappedWord
//        }
//    }
}

extension ProfileCore : Identifiable {
}
