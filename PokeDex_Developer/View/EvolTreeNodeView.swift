////
////  EvolTreeNodeView.swift
////  PokeDex_Developer
////
////  Created by 유영웅 on 3/26/24.
////
//
import SwiftUI
import Kingfisher

struct EvolTreeNodeView: View {
    let items = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    let node: EvolutionTo
    
    var body: some View {
        VStack {
            HStack{
                ForEach(node.image,id: \.self){
                    KFImage(URL(string: $0))
                        .placeholder{
                            Color.gray.opacity(0.2)
                        }
                        .resizable()
                        .frame(width: 200,height: 200)
                        .cornerRadius(10)
                }
            }
            Text("이름 : \(node.name)").bold()
            if !node.evolTo.isEmpty{
                Image(systemName: "chevron.down")
                    .font(.title2)
                    .padding(.top,20)
            }
            HStack (alignment: .top){
                if node.evolTo.count > 3{
                    LazyVGrid(columns: items){
                        ForEach(node.evolTo,id: \.self) { child in
                            EvolTreeNodeView(node: child)
                                .padding()
                        }
                    }
                }else{
                    ForEach(node.evolTo,id: \.self) { child in
                        EvolTreeNodeView(node: child)
                    }
                }
            }
        }
    }
}

#Preview {
    EvolTreeNodeView(node:EvolutionTo(image: [], name: ""))
}
