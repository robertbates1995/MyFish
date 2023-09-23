//
//  ContentView.swift
//  MyFish
//
//  Created by Robert Bates on 9/21/23.
//

import SwiftUI
import ComposableArchitecture

struct FishListFeature: Reducer {
    struct State {
        var CaughtFish: IdentifiedArrayOf<Fish> = []
    }
    
    enum Action {
        case notesButtonTapped
        //    case decrementButtonTapped
        //    case incrementButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce{state,action in return .none}

        //    switch action {
        //    case .decrementButtonTapped:
        //
        //    case .incrementButtonTapped:
        //
        //    }
    }
}

struct FishListView: View {
    let store: StoreOf<FishListFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: \.CaughtFish) { viewStore in
            List{
                ForEach(viewStore.state) { fish in
                    FishCardView(fish: fish)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        NavigationStack {
            FishListView(
                store: Store(
                    initialState: FishListFeature.State(CaughtFish: [.mock])
                ) {
                    FishListFeature()
                })
        }
    }
}
