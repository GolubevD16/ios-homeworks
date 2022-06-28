//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 28.06.2022.
//

import Foundation
import CoreData
import SwiftUI

final class CoreDataManager{
    static let shared = CoreDataManager()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "Post", withExtension: "momd") else {
            fatalError("Unable to find data model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to load data model")
        }
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let documentsDirectoryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        print(documentsDirectoryURL)
        let storeName = "DataBaseModel1.sqlite"
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: nil)
        } catch {
            fatalError("Unable to load persistent store")
        }
        return persistentStoreCoordinator
    }()
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    func getLikedPost(complition: ([Post])-> Void){
        let featchRequest = PostBD.fetchRequest()
        var posts = [Post]()
        do {
            let postsDB = try managedObjectContext.fetch(featchRequest)
            for post in postsDB{
                posts.append(Post(author: post.author ?? "", description: String(post.descriptions ?? ""), image: post.image ?? "belka", likes: Int(post.likes), views: Int(post.views)))
                print(String(post.description))
            }
        } catch let error {
            print(error)
        }
        complition(posts)
    }
    
    func addPost(post: Post){
        let featchRequest = PostBD.fetchRequest()
        do {
            let postsDB = try managedObjectContext.fetch(featchRequest)
            for post1 in postsDB {
                if post1.image == post.image {return}
            }
            let newPost = PostBD(context: managedObjectContext)
            newPost.author = post.author
            newPost.descriptions = post.description
            newPost.image = post.image
            newPost.likes = Int16(post.likes)
            newPost.views = Int16(post.views)
            
            try managedObjectContext.save()
            
        } catch let error{
            print(error)
        }
    }
}
