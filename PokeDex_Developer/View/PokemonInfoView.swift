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
    @State var storeNum = ""
    @State var fetchNum = ""
    @State var name = ""
    @State var code = ""
    
    var body: some View {
        VStack{
            title(text: "포켓몬 DB 저장", imageLink: "https://github.com/PokeAPI/sprites/blob/master/sprites/items/master-ball.png?raw=true")
            storePokemons
            title(text: "포켓몬 정보", imageLink: "https://github.com/PokeAPI/sprites/blob/master/sprites/items/poke-ball.png?raw=true")
            storePokemon
            Divider()
            HStack{
                TextField("도감번호", text: $fetchNum)
                updateButton(type: "불러오기") {
                    Task{
                        guard let num = Int(fetchNum) else {return}
                        try await vm.fetchPokemon(num:num)
                    }
                }
            }
            HStack(alignment: .bottom){
                KFImage(URL(string: vm.pokemon?.base.image ?? ""))
                    .placeholder{
                        Color.gray.opacity(0.2)
                    }
                    .resizable()
                    .frame(width: 150,height: 150)
                    .cornerRadius(10)
                Spacer()
                VStack(alignment:.leading, spacing: 10){
                    HStack{
                        Text("ID : ").bold()
                        TextField("", text: Binding(
                            get: { String(vm.pokemon?.id ?? 0) },
                            set: {
                                if let value = Int($0) { vm.pokemon?.id = value }
                            }
                        )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                    }
                    HStack{
                        Text("색상 : ").bold()
                        TextField("", text: Binding(
                            get: { vm.pokemon?.color ?? "" },
                            set: { vm.pokemon?.color = $0 }
                        )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                    }
                    HStack{
                        Text("이름 : ").bold()
                        TextField("", text: Binding(
                            get: { vm.pokemon?.name ?? "" },
                            set: { vm.pokemon?.name = $0 }
                        )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                    }
                    HStack{
                        Text("분류 : ").bold()
                        TextField("", text: Binding(
                            get: { vm.pokemon?.genra ?? "" },
                            set: { vm.pokemon?.genra = $0 }
                        )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                    }
                    HStack{
                        Text("포획률 : ").bold()
                        TextField("", text: Binding(
                            get: { String(vm.pokemon?.captureRate ?? 0) },
                            set: {
                                if let value = Int($0) { vm.pokemon?.captureRate = value }
                            }
                        )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                    }
                    
                    
                }
            }
            VStack(alignment: .leading,spacing: 20){
                HStack{
                    Text("리전폼 & 다른모습 : ").bold()
                    TextField("", text: Binding(
                        get: { String(vm.pokemon?.formsSwitchable ?? false) },
                        set: {
                            if let value = Bool($0) { vm.pokemon?.formsSwitchable = value }
                        }
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
                HStack{
                    Text("진화트리ID : ").bold()
                    TextField("", text: Binding(
                        get: { String(vm.pokemon?.evolutionTree ?? 0) },
                        set: {
                            if let value = Int($0) { vm.pokemon?.evolutionTree = value }
                        }
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
                HStack{
                    Text("성비 : ").bold()
                    TextField("", text: Binding(
                        get: { String(vm.pokemon?.genderRate ?? 0) },
                        set: {
                            if let value = Int($0) { vm.pokemon?.genderRate = value }
                        }
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
                HStack{
                    Text("부화 걸음수 : ").bold()
                    TextField("", text: Binding(
                        get: { String(vm.pokemon?.hatchCounter ?? 0) },
                        set: {
                            if let value = Int($0) { vm.pokemon?.hatchCounter = value }
                        }
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
                
                VStack{
                    Text("타입").bold()
                    HStack{
                        ForEach((vm.pokemon?.base.types ?? []).indices,id: \.self){ index in
                            TextField("", text: Binding(
                                get: { vm.pokemon?.base.types[index] ?? "" },
                                set: { vm.pokemon?.base.types[index] = $0 }
                            )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                        }
                    }
                }
                VStack{
                    Text("도감번호").bold()
                    
                    ForEach((vm.pokemon?.dex ?? []).indices,id: \.self){ index in
                        HStack{
                            TextField("", text: Binding(
                                get: { vm.pokemon?.dex[index].region ?? "" },
                                set: { vm.pokemon?.dex[index].region = $0 }
                            ))
                            .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                            TextField("", text: Binding(
                                get: { String(vm.pokemon?.dex[index].num ?? 0) },
                                set: {  if let value = Int($0) { vm.pokemon?.dex[index].num = value } }
                            )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                        }
                    }
                }
                VStack{
                    Text("알그룹").bold()
                    HStack{
                        ForEach((vm.pokemon?.eggGroup ?? []).indices,id: \.self){ index in
                            TextField("", text: Binding(
                                get: { vm.pokemon?.eggGroup[index] ?? "" },
                                set: { vm.pokemon?.eggGroup[index] = $0 }
                            )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                        }
                    }
                }
                VStack{
                    Text("도감 설명").bold()
                    
                    ForEach((vm.pokemon?.textEntries.version ?? []).indices,id: \.self){ index in
                        HStack{
                            TextField("", text: Binding(
                                get: { vm.pokemon?.textEntries.version[index] ?? "" },
                                set: { vm.pokemon?.textEntries.version[index] = $0 }
                            )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                            TextField("", text: Binding(
                                get: { vm.pokemon?.textEntries.text[index] ?? "" },
                                set: { vm.pokemon?.textEntries.text[index] = $0 }
                            )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                        }
                    }
                }
                VStack{
                    Text("리전폼").bold()
                    HStack{
                        ForEach((vm.pokemon?.varieties ?? []).indices,id: \.self){ index in
                            TextField("", text: Binding(
                                get: { vm.pokemon?.varieties[index] ?? "" },
                                set: { vm.pokemon?.varieties[index] = $0 }
                            )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                        }
                    }
                }
            }
            
            title(text: "폼 정보", imageLink: "https://github.com/PokeAPI/sprites/blob/master/sprites/items/sablenite.png?raw=true")
            storePokemonForms
            title(text: "진화 트리 정보", imageLink: "https://github.com/PokeAPI/sprites/blob/master/sprites/items/gen5/dawn-stone.png?raw=true")
            storePokemonTree
        }
        .foregroundStyle(.primary)
        .padding(.horizontal)
    }
}

#Preview {
    ScrollView{
        PokemonInfoView()
    }
}

extension PokemonInfoView{
    func title(text:String,imageLink:String) -> some View{
        HStack{
            KFImage(URL(string: imageLink))
                .resizable()
                .frame(width: 50,height: 50)
            Text(text)
                .bold()
            Spacer()
        }
        .font(.title2)
        .padding(.top)
    }
    func updateButton(type:String,action:@escaping()->()) -> some View{
        Button(action: action) {
            Text(type)
                .padding(5)
                .padding(.horizontal)
                .background(.pink)
                .cornerRadius(10)
                .foregroundColor(.white)
                .bold()
        }
    }
    var storePokemons: some View{
        VStack(alignment: .leading){
            HStack(alignment: .bottom){
                Group{
                    TextField("시작번호",text: $firstNum)
                    Text("~")
                    TextField("끝번호",text: $lastNum)
                }
                .frame(width: 60)
                .font(.body)
                Spacer()
                
                updateButton(type: "저장"){
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
    var storePokemon:some View{
        VStack(alignment: .leading){
            HStack(alignment: .bottom){
                TextField("번호",text: $storeNum)
                    .frame(width: 60)
                    .font(.body)
                Spacer()
                updateButton(type: "저장"){
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
                Spacer()
                updateButton(type: "저장"){
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
                Spacer()
                updateButton(type: "저장"){
                    Task{
                        guard let code = Int(code) else {return}
                        try await vm.storePokemonEvolutionTree(num:code)
                    }
                }
            }
        }
    }
}
