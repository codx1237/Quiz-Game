//
//  customSegmentedController.swift
//  QuizGame2
//
//  Created by Fırat Ören on 1.09.2024.
//

import SwiftUI

struct customSegmentedController: View {
    
    @Binding var selectedDiff: Difficulty

        
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(Difficulty.allCases) { dif in
                Button(action: {
                    withAnimation {
                        selectedDiff = dif
                    }
                }, label: {
                    Text(dif.rawValue)
                        .padding(.horizontal,16)
                        .frame(height: 50)
                        .foregroundStyle(Color.black)
                        .font(.title2)
                        .bold()
                        .background(
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20), style: .continuous)
                            .fill(selectedDiff == dif ? Color.green : Color.green.opacity(0.2))
                        )
                })
            }
        }
        
       
        
    }
}

#Preview {
    customSegmentedController(selectedDiff: .constant(.easy))
}
