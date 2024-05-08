//
//  UpdateButtonView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 5/7/24.
//

import SwiftUI

struct UpdateButtonView: View {
    let type:String
    let action: ()->()
    var body: some View {
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
}

#Preview {
    UpdateButtonView(type: "asdad", action: {})
}

