//
//  CardCore+CoreDataProperties.swift
//  FlashPadMacOS
//
//  Created by Emre Yasa on 9/23/21.
//
//


import Foundation
import CoreData


extension CardCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardCore> {
        return NSFetchRequest<CardCore>(entityName: "CardCore")
    }

    @NSManaged public var definition: String?
    @NSManaged public var degree: Double
    @NSManaged public var imageName: String?
    @NSManaged public var word: String?
    @NSManaged public var x: Double
    @NSManaged public var y: Double
    @NSManaged public var deck: DeckCore?
    @NSManaged public var liked: LikedCore?
    @NSManaged public var likedDeck: NSSet?

    public var unwrappedImage:String {
        imageName ?? "bbS"
    }
    public var unwrappedWord:String {
        word ?? "Unknown deckName"
    }
    
    public var unwrappedDefinition:String {
        definition ?? "Unknown deckName"
    }
}

// MARK: Generated accessors for likedDeck
extension CardCore {

    @objc(addLikedDeckObject:)
    @NSManaged public func addToLikedDeck(_ value: DeckCore)

    @objc(removeLikedDeckObject:)
    @NSManaged public func removeFromLikedDeck(_ value: DeckCore)

    @objc(addLikedDeck:)
    @NSManaged public func addToLikedDeck(_ values: NSSet)

    @objc(removeLikedDeck:)
    @NSManaged public func removeFromLikedDeck(_ values: NSSet)

}

extension CardCore : Identifiable {

}
