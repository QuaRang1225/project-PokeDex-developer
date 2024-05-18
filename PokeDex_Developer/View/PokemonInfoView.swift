//
//  PokemonInfoView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import SwiftUI
import Kingfisher

struct PokemonInfoView: View {
    @StateObject var vm = UpdateViewModel()
    @State var firstNum = ""
    @State var lastNum = ""
    @State var firstFormNum = ""
    @State var lastFormNum = ""
    @State var storeNum = ""
    @State var name = ""
    @State var code = ""
    @State var pokeonInfo = false
    @State var varietieInfo = false
    @State var treeInfo = false
    
    var body: some View {
        VStack{
            title(text: "포켓몬 DB 저장", imageLink: "https://github.com/PokeAPI/sprites/blob/master/sprites/items/master-ball.png?raw=true", show: nil)
            storePokemons
            title(text: "포켓몬 폼 DB 저장", imageLink: "https://github.com/PokeAPI/sprites/blob/master/sprites/items/ultra-ball.png?raw=true", show: nil)
            storeForms
            title(text: "포켓몬 정보", imageLink: "https://github.com/PokeAPI/sprites/blob/master/sprites/items/poke-ball.png?raw=true", show: $pokeonInfo)
            storePokemon
            title(text: "폼 정보", imageLink: "https://github.com/PokeAPI/sprites/blob/master/sprites/items/sablenite.png?raw=true", show: $varietieInfo)
            storePokemonForms
            title(text: "진화 트리 정보", imageLink: "https://github.com/PokeAPI/sprites/blob/master/sprites/items/gen5/dawn-stone.png?raw=true", show: $treeInfo)
            storePokemonTree
        }
        .foregroundStyle(.primary)
        .padding(.horizontal)
        .sheet(isPresented:Binding(get: {
            if pokeonInfo{
                return pokeonInfo
            }else if varietieInfo{
                return varietieInfo
            }else{
                return treeInfo
            }
        }, set: {
            if pokeonInfo{
                pokeonInfo = $0
            }else if varietieInfo{
                varietieInfo = $0
            }else{
                treeInfo = $0
            }
        })){
            if pokeonInfo{
                PokemonView().environmentObject(vm)
            }else if varietieInfo{
                VarietiesView().environmentObject(vm)
            }else{
                EvolutionTreeView().environmentObject(vm)
            }
        }
    }
        
}

#Preview {
    ScrollView{
        PokemonInfoView()
    }
}

extension PokemonInfoView{
    func title(text:String,imageLink:String,show:Binding<Bool>?) -> some View{
        HStack{
            KFImage(URL(string: imageLink))
                .resizable()
                .frame(width: 50,height: 50)
            Text(text)
                .bold()
            Spacer()
            if let show{
                Button {
                    show.wrappedValue = true
                } label: {
                    Image(systemName: "chevron.up")
                }
            }
        }
        .font(.title2)
        .padding(.top)
    }
    
    var storePokemons: some View{
        VStack(alignment: .leading){
            HStack(alignment: .bottom){
                    TextField("시작번호",text: $firstNum)
                        .frame(width: 80)
                        .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(.pink))
                        .padding(.horizontal,10)
                    Text("~")
                    TextField("끝번호",text: $lastNum)
                        .frame(width: 80)
                        .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(.pink))
                        .padding(.horizontal,10)
                
                .font(.body)
                Spacer()
                
                UpdateButtonView(type: "저장"){
                    Task{
                        await withThrowingTaskGroup(of: Void.self) { group in
                            guard let first = Int(firstNum),let last = Int(lastNum) else { return }
                            for i in first...last{
                                group.addTask {
                                    try await vm.updatePokemonInfo(num: i)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    var storeForms: some View{
        VStack(alignment: .leading){
            HStack(alignment: .bottom){
                    TextField("시작번호",text: $firstFormNum)
                        .frame(width: 80)
                        .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(.pink))
                        .padding(.horizontal,10)
                    Text("~")
                    TextField("끝번호",text: $lastFormNum)
                        .frame(width: 80)
                        .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(.pink))
                        .padding(.horizontal,10)
                
                .font(.body)
                Spacer()
                
                UpdateButtonView(type: "저장"){
                    Task{
                        await withThrowingTaskGroup(of: Void.self) { group in
                            guard let first = Int(firstFormNum),let last = Int(lastFormNum) else { return }
                            for i in first...last{
                                group.addTask {
                                    try await vm.updateForms(num: i)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    var storePokemon:some View{
        VStack(alignment: .leading){
            HStack(alignment: .bottom){
                TextField("번호",text: $storeNum)
                    .font(.body)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(.pink))
                    .padding(.horizontal,10)
                Spacer()
                UpdateButtonView(type: "저장"){
                    Task{
                        guard let num = Int(storeNum) else {return}
                        let _ = try await vm.storePokemon(num: num)
                    }
                }
            }
        }
    }
    var storePokemonForms:some View{
        VStack(alignment: .leading){
            HStack(alignment: .bottom){
                TextField("폼이름 (영문명) ",text: $name)
                    .font(.body)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(.pink))
                    .padding(.horizontal,10)
                Spacer()
                UpdateButtonView(type: "저장"){
                    Task{
                        try await vm.storePokemonVarieties(form: name)
                    }
                }
            }
        }
    }
    var storePokemonTree:some View{
        VStack(alignment: .leading){
            HStack(alignment: .bottom){
                TextField("진화 트리 코드 (숫자)",text: $code)
                    .font(.body)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(.pink))
                    .padding(.horizontal,10)
                Spacer()
                UpdateButtonView(type: "저장"){
                    Task{
                        guard let code = Int(code) else {return}
                        try await vm.storePokemonEvolutionTree(num:code)
                    }
                }
            }
        }
    }
    
}
