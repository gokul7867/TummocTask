//
//  FavouriteView.swift
//  TummocTask
//
//  Created by gokul on 07/08/24.
//

import SwiftUI

struct FavouriteView: View {
    @Environment (\.presentationMode) var PM
    @StateObject var CDObj = CoreDataManager.share
    @State var favItems : [ItemsEntity] = [ItemsEntity]()
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                HStack{
                    Button(action: {
                        PM.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: 20,height: 20)
                    })
                    Spacer()
                    Text("Favourite")
                        .fontWeight(.medium)
                        .font(.system(size: 23))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundColor(.black)
                        .frame(width: 20,height: 20)
                        .opacity(0)
                }.padding(.horizontal)
               
                VStack{
                    ScrollView(.vertical,showsIndicators: false){
                        ForEach(favItems,id: \.subCatId){ favItem in
                            favGrid(favItem: favItem, favItems: $favItems)
                                .padding(.horizontal)
                                .padding(.vertical,2)
                        }
                    }
                }
                .padding(.vertical)
                .padding(.vertical,5)
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: {
           favItems = CDObj.getAllFavItems().filter({$0.isFav})
        })
    }
}

#Preview {
    FavouriteView()
}

struct favGrid : View {
    @State var favItem : ItemsEntity
    @StateObject var CDObj = CoreDataManager.share
    @Binding var favItems : [ItemsEntity]
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    let url = URL(string: favItem.icon ?? "")
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                           
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 50,height: 50)
                    VStack(alignment: .leading){
                        Text(favItem.name ?? "")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .lineLimit(1)
                        Spacer()
                        Text("\(Int(favItem.prise))")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    Spacer()
                    VStack{
                        Button(action: {
                            withAnimation(){
                                CDObj.isUnFavUpdate(selectedItem: favItem)
                                favItems = CDObj.getAllFavItems().filter({$0.isFav})
                            }
                        }, label: {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .foregroundColor(.red)
                                .frame(width: 25,height: 25)
                        })
                        Button(action: {
                            CDObj.isCartUpdate(selectedItem: favItem)
                        }, label: {
                            Image(systemName: "plus")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 15,height: 15)
                                .padding(6)
                                .background(Color.orange)
                                .cornerRadius(10)
                        })
                    }
                }
            }
        }
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .shadow(radius: 5,y: 2)
            .padding(.top,5)
        )
    }
}
