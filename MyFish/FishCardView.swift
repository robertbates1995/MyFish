//
//  FishCardView.swift
//  MyFish
//
//  Created by Robert Bates on 9/23/23.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct FishCardFeature: Reducer {
    struct State {
        var fish: Fish
        var showingNotes: Bool = false
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce{state,action in return .none}
    }
}

struct FishCardView: View {
    //let store: StoreOf<FishCardFeature>
    let fish: Fish
    
    var body: some View {
            HStack{
                Text(self.fish.species)
                    .font(.headline)
                Spacer()
                VStack{
                    Text("Length: \(String(format: "%.2f", self.fish.length))")
                        .font(.subheadline)
                    Text("Weight: \(String(format: "%.2f", self.fish.weight))")
                        .font(.subheadline)
                }
                Spacer()
            }
    }
}
