//
//  ProdectListView.swift
//  TummocTask
//
//  Created by gokul on 06/08/24.
//

import SwiftUI

struct ProdectListView: View {
    @State var prodects : [ItemsEntity]
    @StateObject var CDObj = CoreDataManager.share
    @State var catId : Int
    @Binding var cartCount : Int
    var body: some View {
        ZStack{
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(prodects,id: \.subCatId){ item in
                        ProdectView(prodect: item, isFav: item.isFav,cartCount: $cartCount)
                            .frame(width: 150,height: 230)
                            .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .shadow(radius: 2)
                            )
                            .padding(.vertical)
                            .padding(.horizontal,5)
                    }
                }
            }
        }
        .onAppear(perform: {
            prodects = CDObj.getAllItems(catId: Int64(catId))
        })
    }
}
//#Preview {
//    ProdectListView(prodects: [
//        St_items(id: 1, name: "apple", icon: "", price: 40.00),
//        St_items(id: 2, name: "orance", icon: "", price: 40.00),
//        St_items(id: 3, name: "supporta", icon: "", price: 40.00),
//    ])
//}
