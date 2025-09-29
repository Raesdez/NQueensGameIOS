//
//  HomeView.swift
//  NQueensGame
//
//  Created by Ramón on 28/9/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(NavigationCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Gradient.backgroundGradient
            makeContentView()
        }
    }
}

private extension HomeView {
    @ViewBuilder
    func makeContentView() -> some View {
        VStack {
            Text("N-Queens challenge!")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .textFont(.heading)
                .padding(.top, .xxl)
            makeGoToGameButtonView()
                .padding(.vertical, .xl)
            Spacer()
            makeBackgroundImageView()
        }
    }
    
    @ViewBuilder
    func makeGoToGameButtonView() -> some View {
        Button(action: {
            coordinator.push(.game)
        }, label: {
            Text("Start game")
                .foregroundColor(.white)
                .textFont(.buttonBig, .medium)
                .padding()
                .background(Color.brown)
                .cornerRadius(30)
        })
    }

    func makeBackgroundImageView() -> some View {
        HStack {
            Spacer()
            Image("Mascot")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 350)
        }
    }
}

#Preview {
    HomeView()
        .environment(NavigationCoordinator())
}

