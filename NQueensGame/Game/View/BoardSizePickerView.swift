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
    private let isCloseButtonAvailable: Bool
    var startGameButtonTappedAction: ((Int) -> Void)?
    var closeButtonTappedAction: (() -> Void)?

    init(
        selectedNumber: Int,
        isCloseButtonAvailable: Bool,
        startGameButtonTappedAction: ((Int) -> Void)? = nil,
        closeButtonTappedAction: (() -> Void)? = nil
    ) {
        self.selectedNumber = selectedNumber
        self.isCloseButtonAvailable = isCloseButtonAvailable
        self.startGameButtonTappedAction =  startGameButtonTappedAction
        self.closeButtonTappedAction = closeButtonTappedAction
    }
    
    var body: some View {
        VStack {
            makeCloseButton()
                .padding(.top, .md)
                .padding(.horizontal, .md)
    
            VStack(spacing: Spacing.md.rawValue) {
                Text("Select the size of the board you wanna play")
                    .textFont(.title)
                    .multilineTextAlignment(.center)
                Text("Bigger boards are more difficult")
                    .textFont(.subtitle, .medium)
            }
            .padding(.top, isCloseButtonAvailable ? .sm : .md)
            .padding(.horizontal, .md)
            
            makePickerView()
                .padding(.vertical, 10)
            
            makeStartButton()
                .padding(.vertical, .md)
        }
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 11)
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
                    .tint(.green)
            }
            .disabled(selectedNumber == range.lowerBound)
            
            Text("\(selectedNumber)")
                .textFont(.heading)
                .padding(.horizontal, .lg)
            
            Button {
                if selectedNumber < range.upperBound {
                    selectedNumber += 1
                }
            } label: {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .frame(width: 35, height: 37)
                    .tint(.green)
            }
            .disabled(selectedNumber == range.upperBound)
        }
    }
    
    func makeStartButton() -> some View {
        Button(action: {
            startGameButtonTappedAction?(selectedNumber)
        }, label: {
            Text("Start game")
                .foregroundColor(.white)
                .textFont(.buttonStandard)
                .padding()
                .background(Color.green)
                .cornerRadius(30)
        })
        
    }
    
    @ViewBuilder
    func makeCloseButton() -> some View {
        if isCloseButtonAvailable {
            HStack {
                Spacer()
                Button {
                    closeButtonTappedAction?()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .tint(.gray)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        BoardSizePickerView(selectedNumber: 4, isCloseButtonAvailable: true)
    }
}
