//
//  CartView.swift
//  TummocTask
//
//  Created by gokul on 07/08/24.
//

import SwiftUI

struct CartView: View {
    @Environment (\.presentationMode) var PM
    @StateObject var CDObj = CoreDataManager.share
    @State var cartArr : [ItemsEntity] = [ItemsEntity]()
    @State var subtotal = 0
    @State var discount = 0
    @State var Total = 0
    @State var itemCost : Int = 0
    var body: some View {
        ZStack{
            VStack{
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
                    Text("Cart")
                        .fontWeight(.medium)
                        .font(.system(size: 23))
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
                        ForEach(cartArr,id: \.subCatId){ favItem in
                            CartGrid(cartItem: favItem, cartArr: $cartArr, itemCost: itemCost, subtotal: $subtotal)
                                .padding(.horizontal)
                                .padding(.vertical,2)
                        }
                    }
                }
                VStack {
                    VStack{
                        VStack(alignment: .leading){
                            HStack{
                                Text("Subtotal")
                                    .fontWeight(.light)
                                    .padding(.bottom)
                                Spacer()
                                Text("\(subtotal)")
                                    .fontWeight(.light)
                            }
                            HStack{
                                Text("Discount")
                                    .fontWeight(.light)
                                    .padding(.bottom)
                                Spacer()
                                Text("\(discount)")
                                    .fontWeight(.light)
                            }
                            Divider()
                                .padding(.bottom)
                            HStack{
                                Text("Total")
                                    .fontWeight(.medium)
                                Spacer()
                                Text("\(Total)")
                                    .fontWeight(.medium)
                            }
                        }
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                        )
                        Button(action: {
                            
                        }, label: {
                            HStack{
                                Spacer()
                                Text("Checkout")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 23))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                                .padding()
                                .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.orange)
                                    .frame(height: 50)
                                )
                        })
                    }.padding(.horizontal)
                }
            }
        }
        .onChange(of: subtotal, perform: { _ in
            if subtotal > 39{
                discount = 40
                Total = subtotal - discount
            }else{
                discount = 0
                Total = subtotal
            }
            
        })
        .onChange(of: cartArr.count, perform: { _ in
            if cartArr.isEmpty{
                Total = 0
                subtotal = 0
                discount = 0
            }else{
                cartArr = CDObj.getAllCartItems().filter({$0.isCart})
                let prise = cartArr.map({Int($0.prise)})
                subtotal = 0
                for x in prise {
                    subtotal = subtotal + x
                }
                if subtotal > 39{
                    discount = 40
                    Total = subtotal - discount
                }
            }
        })
        .navigationBarHidden(true)
        .onAppear(perform: {
            cartArr = CDObj.getAllCartItems().filter({$0.isCart})
            let prise = cartArr.map({Int($0.prise)})
            for x in prise {
                subtotal = subtotal + x
            }
            if subtotal > 39{
                discount = 40
                Total = subtotal - discount
            }
        })
    }
}
#Preview {
    CartView()
}
struct CartGrid : View {
    @State var cartItem : ItemsEntity
    @StateObject var CDObj = CoreDataManager.share
    @Binding var cartArr : [ItemsEntity]
    @State var itemCount = 1
    @State var itemCost : Int
    @Binding var subtotal : Int
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    let url = URL(string: cartItem.icon ?? "")
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                           
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 50,height: 50)
                    VStack(alignment: .leading){
                        Text(cartItem.name ?? "")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .lineLimit(1)
                        Spacer()
                        Text("\(Int(cartItem.prise))")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        HStack(spacing: 15){
                            Button(action: {
                                withAnimation(){
                                    if itemCount > 1{
                                        itemCount = itemCount - 1
                                        subtotal = subtotal - Int(cartItem.prise)
                                        itemCost = (itemCost) - Int(cartItem.prise)
                                    }else{
                                        CDObj.isUnCartUpdate(selectedItem: cartItem)
                                        cartArr = CDObj.getAllCartItems().filter({$0.isCart})
                                    }
                                }
                            }, label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 15,height: 15)
                                    .padding(5)
                                    .background(Color.orange)
                                    .cornerRadius(10)
                            })
                            Text("\(itemCount)")
                            Button(action: {
                                itemCount = itemCount + 1
                                subtotal = subtotal + Int(cartItem.prise)
                                itemCost = (itemCost) + Int(cartItem.prise)
                            }, label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 15,height: 15)
                                    .padding(5)
                                    .background(Color.orange)
                                    .cornerRadius(10)
                            })
                        }
                        Spacer()
                        Text("\(itemCost)")
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
        .onAppear(perform: {
            itemCost = Int(cartItem.prise)
        })
        
    }
}
