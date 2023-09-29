//
//  FishEntryView.swift
//  MyFish
//
//  Created by Robert Bates on 9/24/23.
//

import SwiftUI
import ComposableArchitecture

struct FishFormFeature: Reducer {
    struct State: Equatable {
        @BindingState var focus: Field?
        @BindingState var fish: Fish
        @PresentationState var changeLength: LengthPickerFeature.State?
        
        enum Field: Hashable {
            case species
            case metrics
        }
        
        init(focus: Field? = .species, fish: Fish) {
            self.focus = focus
            self.fish = fish
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case changeLength(PresentationAction<LengthPickerFeature.Action>)
        case changeLengthButtonTapped
        case saveLengthButtonTapped
        case cancelChangeLengthButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .changeLengthButtonTapped:
                state.changeLength = LengthPickerFeature.State()
                return .none
            case .changeLength:
                return .none
            case .binding(_):
                return .none
            case .saveLengthButtonTapped:
                return .none
            case .cancelChangeLengthButtonTapped:
                return .none
            }
        }
    }
}

struct FishFormView: View {
    let store: StoreOf<FishFormFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            List {
                HStack {
                    Text("Species: ")
                    TextField("species", text: viewStore.$fish.species)
                }.font(.callout)
                HStack {
                    Text("Length: ")
                    Button(action: {viewStore.send(.changeLengthButtonTapped)}, label: {
                        Text("\(viewStore.fish.feet)' \(viewStore.fish.inches)\"")
                    })
                }
            }
            .sheet(
                store: self.store.scope(
                    state: \.$changeLength,
                    action: { .changeLength($0) }
                )
            ) { _ in
                NavigationStack {
                    FishFormView(store: store)
                        .navigationTitle("Length")
                }
            }
        }
    }
}

#Preview {
    FishFormView(store: Store(initialState: FishFormFeature.State(fish: .mock)){FishFormFeature()})
}
