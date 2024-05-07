//
//  PokemonView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 5/7/24.
//

import SwiftUI
import Kingfisher

struct PokemonView: View {
    
    @State var fetchNum = ""
    @EnvironmentObject var vm:UpdateViewModel
    var body: some View {
        VStack(spacing:0){
            TextField("도감번호",text: $fetchNum).font(.title3)
                .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(.pink))
                .padding(.horizontal,10)
                .padding(.vertical,30)
            ScrollView(showsIndicators: false){
                header
                bodyView
            }
            .padding(.horizontal,10)
            .background(Color.gray.opacity(0.1))
            communication
        }
    }
}

#Preview {
    PokemonView()
        .environmentObject(UpdateViewModel())
}

extension PokemonView{
    var header:some View{
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
                .padding(.top)
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
    }
    var bodyView:some View{
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
            
            VStack(alignment: .leading){
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
            VStack(alignment: .leading){
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
            VStack(alignment: .leading){
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
            VStack(alignment: .leading){
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
            VStack(alignment: .leading){
                Text("리전폼").bold()
                HStack{
                    ForEach((vm.pokemon?.varieties ?? []).indices,id: \.self){ index in
                        TextField("", text: Binding(
                            get: { vm.pokemon?.varieties[index] ?? "" },
                            set: { vm.pokemon?.varieties[index] = $0 }
                        )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                    }
                }
            }.padding(.bottom)
        }
    }
    var communication:some View{
        HStack(spacing: 0){
            Button {
                Task{
                    guard let num = Int(fetchNum) else {return}
                    try await vm.fetchPokemon(num:num)
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
                    guard let num = Int(fetchNum) else {return}
//                    try await vm.fetchPokemon(num:num)
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
                    guard let num = Int(fetchNum) else {return}
//                    try await vm.fetchPokemon(num:num)
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
