//
//  ContentView.swift
//  UIDemo
//
//  Created by Frank Dulko on 2/11/22.
//
// HStack, VStack, ZStack, List
//NavigationView
//NAvigationLink
// ForEach

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Image(systemName: "circle")
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
            Image(systemName: "rectangle")
                .resizable()
                .frame(width: 100, height: 100)
            Image(systemName: "triangle")
                .resizable()
                .frame(width: 100, height: 100)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
