//
//  VarietiresView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 5/7/24.
//

import SwiftUI
import Kingfisher

struct VarietiresView: View {
    @EnvironmentObject var vm:UpdateViewModel
    var body: some View {
        VStack(alignment: .leading){
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
                            get: { String(vm.varieties?.height ?? 0) },
                            set: {
                                if let value = Double($0) { vm.varieties?.height = value }
                            }
                        )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                    }
                    HStack{
                        Text("분류 : ").bold()
                        TextField("", text: Binding(
                            get: { vm.pokemon?.genra ?? "" },
                            set: { vm.pokemon?.genra = $0 }
                        )).overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(.gray))
                    }
                    
                    
                    
                }.padding(.bottom,15)
            }
        }
    }
}

#Preview {
    VarietiresView()
        .environmentObject(UpdateViewModel())
}
