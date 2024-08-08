//
//  HomeView.swift
//  TummocTask
//
//  Created by gokul on 06/08/24.
//

import SwiftUI

extension View {
    func cornerRadis(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
struct MenuItems : Identifiable,Equatable {
    let id = UUID()
    let name : String
    let image : String?
}
struct HomeView: View {
    @State var menuItems : [MenuItems] = [
        MenuItems(name: "menu", image: "line.3.horizontal"),
        MenuItems(name: "My Store", image: nil),
        MenuItems(name: "Fav", image: "suit.heart"),
        MenuItems(name: "cart", image: "cart.fill"),
    ]
    @StateObject var obj = ResponceViewModel.share
    @State var prodectDetails : [St_CategoryModel] = []
    @State var isGrid = false
    @State var isFavView = false
    @State var isCartView = false
    @State var CDProduct : [ProdectEntity] = [ProdectEntity]()
    @State var CDItems : [ItemsEntity] = [ItemsEntity]()
    @StateObject var CDObj = CoreDataManager.share
    @State var selectedCatId = 0
    @State var selectedCatItem : ProdectEntity?
    @State var cartCount = 0
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(alignment: .leading){
                ZStack(alignment: .bottom){
                    Color.orange
                    HStack(alignment: .center,spacing: 20){
                        ForEach(menuItems){ item in
                            if let index = menuItems.firstIndex(where: { menuItem in
                                item == menuItem
                            }){
                                if let image = item.image{
                                    Button(action: {
                                        withAnimation(){
                                            if index == 2 {
                                                isFavView = true
                                            }else if index == 3{
                                                isCartView = true
                                            }
                                        }
                                    }, label: {
                                        Image(systemName: image)
                                            .resizable()
                                            .renderingMode(.template)
                                            .scaledToFit()
                                            .foregroundColor(.black)
                                            .frame(width: 25,height: 25)
                                            .overlay(alignment: .topTrailing, content: {
                                                ZStack{
                                                    if index == 3{
                                                        ZStack{
                                                            Circle()
                                                                .fill(Color.red)
                                                            Text("\(cartCount)")
                                                                .font(.system(size: 10))
                                                                .foregroundColor(.white)
                                                        }
                                                        .frame(width: 16, height: 16)
                                                        .offset(x: 5,y: -4)
                                                        .opacity(cartCount > 0 ? 1 : 0)
                                                    }
                                                }
                                            })
                                    })
                                }else{
                                    Text("\(item.name)")
                                        .fontWeight(.bold)
                                        .font(.system(size: 25))
                                        .foregroundColor(.black)
                                }
                                if index != 0 && index != 2 && index != 3 {
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom,5)
                }
                .cornerRadis(20, corners: [.bottomLeft,.bottomRight])
                .ignoresSafeArea()
                .frame(height: 70)
                Spacer()
                ZStack(alignment: .bottom){
                    ScrollViewReader{ proxy in
                        ScrollView(.vertical,showsIndicators: false){
                            VStack{
                            }.frame(height: 10)
                            VStack(alignment: .leading,spacing: 5){
                                ForEach(CDProduct,id: \.id) { prodect in
                                    VStack(spacing: 5){
                                        HStack{
                                            Text(prodect.name ?? "")
                                                .fontWeight(.medium)
                                                .font(.system(size: 22))
                                            Spacer()
                                            Button(action: {
                                                
                                            }, label: {
                                                Image(systemName: "chevron.down")
                                                    .resizable()
                                                    .renderingMode(.template)
                                                    .scaledToFit()
                                                    .foregroundColor(.black)
                                                    .frame(width: 15,height: 15)
                                            })
                                        }
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(height: 0.5)
                                        ProdectListView(prodects: CDObj.getAllItems(catId: prodect.id),catId: Int(prodect.id),cartCount: $cartCount)
                                    }
                                    .id(prodect)
                                }
                            }
                        }
                        .onChange(of: selectedCatItem){ _ in
                                withAnimation(){
                                    proxy.scrollTo(selectedCatItem)
                                }
                        }
                    }
                }
                .padding(.horizontal)
                
            }
            NavigationLink(isActive: $isFavView, destination: {
                FavouriteView()
            }, label: {
                
            })
            NavigationLink(isActive: $isCartView, destination: {
                CartView()
            }, label: {
                
            })
        }
        .overlay(alignment: .bottom, content: {
            ZStack(alignment: .bottom){
                if isGrid{
                    ZStack(alignment: .bottom){
                        Color.black.opacity(0.5).ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(){
                                    isGrid = false
                                }
                            }
                        VStack{
                            VStack{
                                HStack{
                                    ScrollView(.vertical,showsIndicators: false){
                                        VStack(alignment: .leading){
                                            ForEach(CDProduct,id: \.id){ catname in
                                                    Button(action: {
                                                        withAnimation(){
                                                            selectedCatItem = catname
                                                            isGrid = false
                                                        }
                                                    }, label: {
                                                        HStack{
                                                            Text(catname.name ?? "")
                                                                .foregroundColor(.black)
                                                            Spacer()
                                                        }
                                                            .padding(5)
                                                    })
                                                }
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                            )
                            .frame(width: UIScreen.main.bounds.width * 0.8,height: 230)
                            
                            Button(action: {
                                withAnimation(){
                                    isGrid = false
                                }
                            }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 15,height: 15)
                                    .padding(10)
                                    .background(
                                        Circle()
                                            .fill(Color.orange)
                                        
                                    )
                                    .padding(15)
                            })
                        }
                    }
                }else{
                    ZStack{
                        Button(action: {
                            withAnimation(){
                                isGrid = true
                            }
                        }, label: {
                            HStack{
                                Image(systemName: "square.grid.2x2")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 15,height: 15)
                                Text("Categories")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.black)
                                    .frame(width: 150,height: 40)
                            )
                        })
                    }
                }
            }
        })
        .onAppear(perform: {
            if CDProduct.isEmpty{
                obj.onloadResponce(completion: { responce in
                    prodectDetails = responce.categories
                    CDObj.SaveCategoryProdect(arrCategory: prodectDetails)
                    CDProduct = CDObj.getAllCategory()
                    cartCount = CDObj.getAllCartItems().filter({$0.isCart}).count
                })
            }else{
                CDProduct = CDObj.getAllCategory()
                cartCount = CDObj.getAllCartItems().filter({$0.isCart}).count
            }
        })
    }
}
#Preview {
    NavigationView{
        HomeView()
    }
}
