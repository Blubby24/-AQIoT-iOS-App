//
//  AboutView.swift
//  Map Prototype
//
//  Created by Esteban Linarez  on 4/13/25.
//

import SwiftUI

struct AboutView: View {
    var people = [Person(name: "Dorian Hawkins", profilePicture: "Dorian",              About: "This is where the about you would go"),
                  Person(name: "Esteban Linarez", profilePicture: "Esteban", About: "This is where the about you would go"),
                  Person(name: "Ryan Lin", profilePicture: "Ryan", About: "This is where the about you would go")]
    var body: some View {
        VStack{
            ScrollView {
                Text("About Us")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()
                ForEach(people) { person in
                    Image(person.profilePicture)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                    Text(person.name)
                        .padding()
                        .font(.headline)
                    Text(person.About)
                        .padding()
                }
            }
            .padding()
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    AboutView()
}
