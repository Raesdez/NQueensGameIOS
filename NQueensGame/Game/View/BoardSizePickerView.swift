//
//  BoardSizePickerView.swift
//  NQueensGame
//
//  Created by Ramón on 28/9/25.
//

import SwiftUI

/// View that configures the board size and calls to start a new game
struct BoardSizePickerView: View {
    @State private var selectedNumber: Int
    private let range: ClosedRange<Int>
    private let isCloseButtonAvailable: Bool
    /// Closure to call when the main action button is pressed. Includes the final board size selected.
    var startGameButtonTappedAction: ((Int) -> Void)?
    /// Actor to perform when the close button is tapped (if available)
    var closeButtonTappedAction: (() -> Void)?

    init(
        allowedBoardRange: ClosedRange<Int>,
        selectedNumber: Int,
        isCloseButtonAvailable: Bool,
        startGameButtonTappedAction: ((Int) -> Void)? = nil,
        closeButtonTappedAction: (() -> Void)? = nil
    ) {
        range = allowedBoardRange
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
                    .accessibilityIdentifier(Identifiers.title)
                Text("Bigger boards are more difficult")
                    .textFont(.subtitle, .medium)
                    .accessibilityIdentifier(Identifiers.subtitle)
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

extension BoardSizePickerView {
    enum Identifiers: AccessibilityIdentifying {
        case title
        case subtitle
        case plusButton
        case minusButton
        case currentSelectedNumber
        case startGameButton
        case closeButton
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
            .accessibilityIdentifier(Identifiers.minusButton)
            
            Text("\(selectedNumber)")
                .textFont(.heading)
                .padding(.horizontal, .lg)
                .accessibilityIdentifier(Identifiers.currentSelectedNumber)
            
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
            .accessibilityIdentifier(Identifiers.plusButton)
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
        .accessibilityIdentifier(Identifiers.startGameButton)
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
            .accessibilityIdentifier(Identifiers.closeButton)
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        BoardSizePickerView(
            allowedBoardRange: 4...20,
            selectedNumber: 4,
            isCloseButtonAvailable: true
        )
    }
}
