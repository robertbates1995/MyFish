//
//  FishEntryView.swift
//  MyFish
//
//  Created by Robert Bates on 9/24/23.
//

import SwiftUI
import ComposableArchitecture

struct FishFormFeature: Reducer {
    struct State {
        var fish: Fish
    }
    
    enum Action {
        //    case decrementButtonTapped
        //    case incrementButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce{ state,action in
            return .none
        }
    }
}

struct FishFormView: View {
    let store: StoreOf<FishFormFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: \.fish) { viewStore in
            VStack {
                HStack{
                    Text("Species:")
                        .font(.headline)
                    Text(viewStore.species)
                }
            }
        }
    }
}

#Preview {
    FishFormView(store: Store(initialState: FishFormFeature.State(fish: .mock)) {
        
    })
}
