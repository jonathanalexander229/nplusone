//
//  Auth.swift
//  nplusone
//
//  Created by clutchcoder on 12/15/24.
//
import Foundation
import SwiftUI
import CoreData

class Auth: ObservableObject {
    
    let context: NSManagedObjectContext
    @Published var loggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var currentUser: User?
    @Published var items: [Item] = []
    
    public init(context: NSManagedObjectContext) {
        self.context = context
        debugPrint("Auth init")
        
        let fetchRequest = User.fetchRequest() as! NSFetchRequest<User>
        if let users = try? context.fetch(fetchRequest), !users.isEmpty {
            self.currentUser = users.first
            self.loggedIn = true
        }
        fetchCurrentUserItems()
        
        debugPrint(loggedIn)
    }
    
     func login(username: String, completion: @escaping (Bool) -> Void) {
        guard currentUser == nil else { 
            completion(false); return // Prevent multiple logins
        }
       
        let newUser = User(context: context)
        newUser.username = username
        
        isLoading = true
        do {
            self.currentUser = newUser
            try context.save()
            loggedIn = true
            debugPrint("user logged in")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLoading = false
            }
            //isLoading = false
            completion(true)
        } catch {
            isLoading = false
            fatalError("error saving user:\(error), \(error)")
        }
    }


    func logout(completion: @escaping (Bool) -> Void) {
        guard let userToDelete = currentUser else { 
            completion(false); return 
        }
                
        isLoading = true
        
        context.delete(userToDelete)
        
        do {
            try context.save()
            loggedIn = false
            currentUser = nil
            debugPrint("user logged out and deleted")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLoading = false
            }
            completion(true)
        } catch {
            isLoading = false
            fatalError("error deleting user \(error), \(error)")
        }
    }
    
    func fetchCurrentUserItems() {
           guard let currentUser = currentUser else {
               return
           }

           self.items = Array(currentUser.items ?? [])
       }
    
}
