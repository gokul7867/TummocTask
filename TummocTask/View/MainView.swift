//
//  MainView.swift
//  TummocTask
//
//  Created by gokul on 28/07/24.
//

import Foundation
import SwiftUI



struct MainView : View {
    @State var isPopup = false
    var body: some View {
        ZStack{
            VStack{
                Text("Hello World!")
                Spacer()
                Button(action: {
                    withAnimation(){
                        isPopup = true
                    }
                }, label: {
                    Text("Tap me")
                })
            }.padding()
            if isPopup {
                Popup(isPopup: $isPopup)
            }
        }
    }
}
#Preview{
MainView()
}

struct Popup : View {
    @Binding var isPopup : Bool
    var body: some View {
        ZStack{
            if isPopup { Color.black.opacity(0.5).ignoresSafeArea()
            }else{
                Color.white.ignoresSafeArea()
            }
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(){
                            isPopup = false
                        }
                    }, label: {
                        Text("Close")
                    })
                }
                Spacer()
                Text("I am popup")
                Spacer()
            }
            .frame(height: 200)
            .padding(10)
            .background(Color.white)
            .cornerRadius(20)
            .padding()
        }
    }
}
