//
//  PokemonInfoView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import SwiftUI

struct PokemonInfoView: View {
    @StateObject var vm = UpdateViewModel()
    @State var firstNum = ""
    @State var lastNum = ""
    
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .bottom){
                Image(systemName: "hare.fill")
                Text("포켓몬정보")
                    .bold()
                Spacer()
            }
            .font(.title2)
            .padding(.top)
            HStack(alignment: .bottom){
                Group{
                    TextField("시작번호",text: $firstNum)
                        .keyboardType(.numberPad)
                    Text("~")
                    TextField("끝번호",text: $lastNum)
                        .keyboardType(.numberPad)
                }
                .frame(width: 60)
                .font(.body)
                Spacer()
                Button{
                    Task{
                        await withThrowingTaskGroup(of: Void.self) { group in
                            if let first = Int(firstNum),let last = Int(lastNum){
                                for i in first...last{
                                    group.addTask {
                                        try await vm.updatePokemonInfo(num: i)
                                    }
                                }
                            }
                        }
                    }
                } label: {
                    Text("업데이트")
                        .padding(5)
                        .padding(.horizontal)
                        .background(.pink)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .bold()
                }
               
            }
        }
        .foregroundStyle(.primary)
        .padding(.horizontal)
    }
    
    func pokemonDataUpdate(){
        Task{
            
        }
    }
}

#Preview {
    PokemonInfoView()
}
