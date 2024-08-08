//
//  ProdectView.swift
//  TummocTask
//
//  Created by gokul on 06/08/24.
//

import SwiftUI

struct ProdectView: View {
    @State var prodect : ItemsEntity
    @StateObject var CDObj = CoreDataManager.share
    @State var isFav : Bool
    @Binding var cartCount : Int
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(){
                            isFav.toggle()
                            if isFav{
                                CDObj.isFavUpdate(selectedItem: prodect)
                            }else{
                                CDObj.isUnFavUpdate(selectedItem: prodect)
                            }
                        }
                    }, label: {
                        if !isFav{
                            Image(systemName: "heart")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: 25,height: 25)
                        }else{
                            Image(systemName: "heart.fill")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .foregroundColor(.red)
                                .frame(width: 25,height: 25)
                        }
                    })
                }
                HStack{
                    Spacer()
                    let url = URL(string: prodect.icon ?? "")
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 100,height: 100)
                    Spacer()
                }
                Text(prodect.name ?? "")
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                HStack(alignment: .center){
                    Text("\(Int(prodect.prise)) /kg")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        CDObj.isCartUpdate(selectedItem: prodect)
                        cartCount = CDObj.getAllCartItems().filter({$0.isCart}).count
                    }, label: {
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 15,height: 15)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(20)
                    })
                }
            }
            .padding()
        }
        .onAppear(perform: {
            isFav = prodect.isFav
        })
    }
}

//#Preview {
//    ProdectView(prodect: St_items(id: 1, name: "Apple", icon: "", price: 40.00))
//}
