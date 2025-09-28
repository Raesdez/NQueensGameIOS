//
//  BoardSizePickerView.swift
//  NQueensGame
//
//  Created by Ramón on 28/9/25.
//

import SwiftUI

struct BoardSizePickerView: View {
    @State private var selectedNumber: Int
    private let range: ClosedRange<Int> = 4...20
    
    var startGameButtonTappedAction: ((Int) -> Void)?
    var closeButtonTappedAction: (() -> Void)?

    init(
        selectedNumber: Int,
        startGameButtonTappedAction: ((Int) -> Void)? = nil,
        closeButtonTappedAction: (() -> Void)? = nil
    ) {
        self.selectedNumber = selectedNumber
        self.startGameButtonTappedAction =  startGameButtonTappedAction
        self.closeButtonTappedAction = closeButtonTappedAction
    }
    
    var body: some View {
        VStack {
            makeCloseButton()
                .padding(.top, 5)
                .padding(.bottom, 15)
                .padding(.horizontal, 15)
            
            Text("Select the size of the board you wanna play")
            Text("Bigger boards are more difficult")
            
            makePickerView()
                .padding(.vertical, 15)
            
            makeStartButton()
        }
        .padding(.vertical, 12)
    }
}

private extension BoardSizePickerView {
    func makePickerView() -> some View {
        HStack {
            Button {
                if selectedNumber > range.lowerBound {
                    selectedNumber -= 1
                }
            } label: {
                Image(systemName: "minus.square.fill")
                    .resizable()
                    .frame(width: 35, height: 37)
            }
            .disabled(selectedNumber == range.lowerBound)
            
            Text("\(selectedNumber)")
                .font(.system(size: 40))
                .padding(.horizontal, 20)
            
            Button {
                if selectedNumber < range.upperBound {
                    selectedNumber += 1
                }
            } label: {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .frame(width: 35, height: 37)
            }
            .disabled(selectedNumber == range.upperBound)
        }
    }
    
    func makeStartButton() -> some View {
        Button(action: {
            startGameButtonTappedAction?(selectedNumber)
        }, label: {
            Text("Start game")
        })
        .padding(.top, 20)
    }
    
    func makeCloseButton() -> some View {
        HStack {
           Spacer()
            Button {
                closeButtonTappedAction?()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
    }
}

#Preview {
    BoardSizePickerView(selectedNumber: 4)
}
