//
//  Person.swift
//  Map Prototype
//
//  Created by Dorian Hawkins on 4/13/25.
//

import Foundation

struct Person: Identifiable, Hashable{
    var id: UUID = UUID()
    var name: String
    var profilePicture: String
    var About: String
}
