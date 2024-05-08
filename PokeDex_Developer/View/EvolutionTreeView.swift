//
//  EvolutionTreeView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 5/7/24.
//

import SwiftUI
import Kingfisher

struct EvolutionTreeView: View {
    let items = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    @EnvironmentObject var vm:UpdateViewModel
    @State var fetchTree = ""
    var body: some View {
        VStack(spacing:0){
            TextField("진화트리 번호",text: $fetchTree).font(.title3)
                .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(.pink))
                .padding(.horizontal,10)
                .padding(.vertical,30)
            ScrollView(showsIndicators: false){
                bodyView
            }
            .padding(.horizontal,10)
            .background(Color.gray.opacity(0.1))
            communication
        }
    }
}

#Preview {
    EvolutionTreeView()
        .environmentObject(UpdateViewModel())
}

extension EvolutionTreeView{
    var bodyView:some View{
        VStack {
            HStack{
                Text("ID : ").bold()
                TextField("", text: Binding(
                    get: { String(vm.tree?.id ?? 0) },
                    set: { if let value = Int($0) { vm.tree?.id = value }}
                )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
            }.padding(.bottom,20)
            EvolTreeNodeView(node:  vm.tree ?? EvolutionTo(image: [], name: ""))
            
        }
    }
    var communication:some View{
        HStack(spacing: 0){
            Button {
                Task{
                    guard let num = Int(fetchTree) else {return}
                    try await vm.fetchPokemonEvolutionTree(num:num)
                }
            } label: {
                Text("불러오기")
                    .bold()
                    .padding(.vertical,20)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
            }.background(Color.pink)
            Button {
                Task{
                    guard let num = Int(fetchTree),let tree = vm.tree else {return}
                    try await vm.updateEvolutionTree(num: num, tree: tree)
                }
            } label: {
                Text("수정하기")
                    .bold()
                    .padding(.vertical,20)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
            }.background(Color.pink.opacity(0.7))
            Button {
                Task{
                    guard let num = Int(fetchTree) else {return}
                    try await vm.deleteTree(num:num)
                }
            } label: {
                Text("삭제하기")
                    .bold()
                    .padding(.vertical,20)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
            }.background(Color.pink.opacity(0.5))
        }
        
    }
}
