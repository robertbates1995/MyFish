//
//  ContentView.swift
//  MyFish
//
//  Created by Robert Bates on 9/21/23.
//

import SwiftUI
import ComposableArchitecture

struct FishListFeature: Reducer {
    struct State: Equatable {
        @PresentationState var addFish: FishFormFeature.State?
        var fishes: IdentifiedArrayOf<Fish> = []
    }
    
    enum Action {
        case addFish(PresentationAction<FishFormFeature.Action>)
        case notesButtonTapped
        case addButtonTapped
        case saveFishButtonTapped
        case cancelFishButtonTapped
        case swipeDelete(IndexSet)
    }
    
    @Dependency(\.uuid) var uuid
    var body: some ReducerOf<Self> {
        Reduce{ state, action in
            switch action {
            case .addButtonTapped:
                state.addFish = FishFormFeature.State(fish: Fish(id: self.uuid()))
                return .none
            case .addFish:
                return .none
            case .notesButtonTapped:
                return .none
            case .saveFishButtonTapped:
                guard let fish = state.addFish?.fish
                else { return .none }
                state.fishes.append(fish)
                state.addFish = nil
                return .none
            case .cancelFishButtonTapped:
                state.addFish = nil
                return .none
            case .swipeDelete(let toDelete):
                state.fishes.remove(atOffsets: toDelete)
                return .none
            }
        }
        .ifLet(\.$addFish, action: /Action.addFish) {
            FishFormFeature()
        }
    }
}

struct FishListView: View {
    let store: StoreOf<FishListFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: \.fishes) { viewStore in
            List{
                ForEach(viewStore.state) { fish in
                    FishCardView(fish: fish)
                }
                .onDelete { indexSet in
                    viewStore.send(.swipeDelete(indexSet))
                }
            }
            .navigationTitle("Fish")
            .toolbar {
                ToolbarItem {
                    Button("Add") {
                        viewStore.send(.addButtonTapped)
                    }
                }
            }
            .sheet(
                store: self.store.scope(
                    state: \.$addFish,
                    action: { .addFish($0) }
                )
            ) { (store: StoreOf<FishFormFeature>) in
                NavigationStack {
                    FishFormView(store: store)
                        .navigationTitle("New Fish")
                        .toolbar {
                            ToolbarItem {
                                Button("Save") {
                                    viewStore.send(.saveFishButtonTapped)
                                }
                            }
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    viewStore.send(.cancelFishButtonTapped)
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        NavigationStack {
            FishListView(
                store: Store(
                    initialState: FishListFeature.State(fishes: [.mock])
                ) {
                    FishListFeature()
                }
            )
        }
    }
}

extension FishListFeature {
    static let mock: Self.State = State(fishes: .init(arrayLiteral: .mock))
}
