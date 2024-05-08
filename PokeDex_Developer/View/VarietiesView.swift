//
//  VarietiresView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 5/7/24.
//

import SwiftUI
import Kingfisher

struct VarietiesView: View {
    @EnvironmentObject var vm:UpdateViewModel
    @State var fetchForm = ""
    var body: some View {
        VStack(spacing:0){
            TextField("폼 이름",text: $fetchForm).font(.title3)
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
    VarietiesView()
        .environmentObject(UpdateViewModel())
}

extension VarietiesView{
    var header:some View{
        HStack(alignment: .bottom){
            KFImage(URL(string: vm.varieties?.form.images ?? ""))
                .placeholder{
                    Color.gray.opacity(0.2)
                }
                .resizable()
                .frame(width: 200,height: 200)
                .cornerRadius(10)
            Spacer()
            VStack(alignment:.leading, spacing: 10){
                HStack{
                    Text("ID : ").bold()
                    TextField("", text: Binding(
                        get: { vm.varieties?.id ?? "" },
                        set: { vm.varieties?.id = $0 }
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
                .padding(.top)
                HStack{
                    Text("이름 : ").bold()
                    TextField("", text: Binding(
                        get: { vm.varieties?.form.name ?? "" },
                        set: { vm.varieties?.form.name = $0 }
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
                HStack{
                    Text("키 : ").bold()
                    TextField("", text: Binding(
                        get: { String(vm.varieties?.height ?? 0) },
                        set: {
                            if let value = Double($0) { vm.varieties?.height = value }
                        }
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
                HStack{
                    Text("무게 : ").bold()
                    TextField("", text: Binding(
                        get: { String(vm.varieties?.weight ?? 0) },
                        set: {
                            if let value = Double($0) { vm.varieties?.weight = value }
                        }
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
            }.padding(.bottom,15)
        }
    }
    var bodyView:some View{
        VStack(alignment: .leading,spacing: 20){
            HStack{
                Text("이미지 링크: ").bold()
                TextField("", text: Binding(
                    get: { vm.varieties?.form.images ?? "" },
                    set: { vm.varieties?.form.images = $0 }
                )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
            }
            Text("특성").bold()
            ForEach((vm.varieties?.abilites.isHidden ?? []).indices,id: \.self){ index in
                HStack{
                    TextField("", text: Binding(
                        get: { String(vm.varieties?.abilites.isHidden[index] ?? false) },
                        set: {  if let value = Bool($0) { vm.varieties?.abilites.isHidden[index] = value }}
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                    TextField("", text: Binding(
                        get: { vm.varieties?.abilites.name[index] ?? "" },
                        set: { vm.varieties?.abilites.name[index] = $0 }
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
                TextField("", text: Binding(
                    get: { vm.varieties?.abilites.text[index] ?? "" },
                    set: { vm.varieties?.abilites.text[index] = $0 }
                )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
            }
            Text("스탯").bold()
            HStack{
                ForEach((vm.varieties?.stats ?? []).indices,id: \.self){ index in
                    TextField("", text: Binding(
                        get: {  String(vm.varieties?.stats[index] ?? 0) },
                        set: { if let value = Int($0) { vm.varieties?.stats[index] = value }}
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
            }
            Text("타입").bold()
            HStack{
                ForEach((vm.varieties?.types ?? []).indices,id: \.self){ index in
                    TextField("", text: Binding(
                        get: { vm.varieties?.types[index] ?? "" },
                        set: { vm.varieties?.types[index] = $0 }
                    )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                }
            }
        }
    }
    var communication:some View{
        HStack(spacing: 0){
            Button {
                Task{
                    try await vm.fetchPokemonVarieties(form: fetchForm)
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
                    guard let varieties = vm.varieties else {return}
                    try await vm.updatePokemonForm(name: fetchForm, varieties: varieties)
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
                    try await vm.deleteForm(name:fetchForm)
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
