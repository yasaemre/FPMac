//
//  LikedCore+CoreDataProperties.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//
//


import Foundation
import CoreData



extension LikedCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedCore> {
        return NSFetchRequest<LikedCore>(entityName: "LikedCore")
    }

    @NSManaged public var definition: String?
    @NSManaged public var imageName: String?
    @NSManaged public var likedCards: NSObject?
    @NSManaged public var word: String?
    @NSManaged public var id: Int16
    @NSManaged public var offset: Float
    @NSManaged public var liked: NSSet?
  
    
    public var unwrappedImage:String {
        imageName ?? "cardBackg"
    }
    
    public var unwrappedWord:String {
        word ?? "Unknown word"
    }
    
    public var unwrappedDefinition:String {
        definition ?? "Unknown definition"
    }

    public var likedArray: [CardCore] {
        let cardsSet = liked as? Set<CardCore> ?? []
        
        return cardsSet.sorted {
            $0.unwrappedWord < $1.unwrappedWord
        }
    }

}

// MARK: Generated accessors for liked
extension LikedCore {

    @objc(addLikedObject:)
    @NSManaged public func addToLiked(_ value: CardCore)

    @objc(removeLikedObject:)
    @NSManaged public func removeFromLiked(_ value: CardCore)

    @objc(addLiked:)
    @NSManaged public func addToLiked(_ values: NSSet)

    @objc(removeLiked:)
    @NSManaged public func removeFromLiked(_ values: NSSet)

}

extension LikedCore : Identifiable {

}
