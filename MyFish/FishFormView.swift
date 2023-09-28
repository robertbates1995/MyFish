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
        
        enum Field: Hashable {
            case species
            case weight
            case length
        }
        
        init(focus: Field? = .species, fish: Fish) {
            self.focus = focus
            self.fish = fish
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            return .none
        }
    }
}

struct FishFormView: View {
    let store: StoreOf<FishFormFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form{
                HStack{
                    Text("Species: ")
                        .font(.callout)
                    TextField("Species", text: viewStore.$fish.species)
                        .font(.callout)
                }
            }
        }
    }
}

#Preview {
    FishFormView(store: Store(initialState: FishFormFeature.State(fish: Fish(id: UUID()))){FishFormFeature()})
}
