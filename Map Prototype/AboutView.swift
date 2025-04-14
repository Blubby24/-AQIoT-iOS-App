//
//  AboutView.swift
//  Map Prototype
//
//  Created by Esteban Linarez  on 4/13/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            ScrollView {
                Text("About the Project")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()

                Text("AQ IoT")
                    .font(.system(size: 15))
                    .fontWeight(.bold)

                Image("aqiot")
                    .resizable()
                    .frame(width: 350, height: 200)
                    .padding(.bottom)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Clean air is essential, but not everyone has equal access to it. While air quality in the U.S. has improved overall, many communities—especially communities of color—still face higher levels of pollution. Unfortunately, government sensors are often too spread out to reflect the true air quality people experience in their neighborhoods.")

                    Text("This project was created to change that. Using low-cost air quality sensors and Internet of Things (IoT) technology, we’re working with residents and schools to make accurate, real-time air quality data available to everyone.")

                    Text("With support from community partners, students are learning how to build and install their own sensors, monitor pollution around them, and share that information through this app and a public web dashboard.")

                    Text("We’re also addressing challenges like power and internet access by partnering with organizations like PCs for People. The sensors are designed to be reliable, easy to expand in the future, and built to reflect what communities actually need.")

                    Text("The data from these sensors is compared with official readings, and results are shared with local leaders to help drive positive change.")
                }
                .font(.system(size: 15))
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
        }
    }
}


#Preview {
    AboutView()
}
