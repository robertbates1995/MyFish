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
                guard let feet = state.changeLength?.feet,
                let inches = state.changeLength?.inches
                else { return .none }
                state.fish.feet = feet
                state.fish.inches = inches
                state.changeLength = nil
                return .none
            case .cancelChangeLengthButtonTapped:
                state.changeLength = nil
                return .none
            }
        }.ifLet(\.$changeLength, action: /Action.changeLength) {
            LengthPickerFeature()
        }
    }
}

struct FishFormView: View {
    let store: StoreOf<FishFormFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
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
            ) { (store: StoreOf<LengthPickerFeature>) in
                NavigationStack {
                    LengthPickerView(store: store)
                        .navigationTitle("Length")
                        .toolbar {
                            ToolbarItem {
                                Button("Save") {
                                    viewStore.send(.saveLengthButtonTapped)
                                }
                            }
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    viewStore.send(.cancelChangeLengthButtonTapped)
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    FishFormView(store: Store(initialState: FishFormFeature.State(fish: .mock)){FishFormFeature()})
}
