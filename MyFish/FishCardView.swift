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
        Reduce { state, action in
            return .none
        }
    }
}

struct FishCardView: View {
    //let store: StoreOf<FishCardFeature>
    let fish: Fish
    
    var body: some View {
        HStack(){
            Text(self.fish.species)
            Spacer()
            Text("\(self.fish.feet)' \(self.fish.inches)\"")
            Spacer()
            Text("\(String(format: "%.2f", self.fish.weight)) lbs")
        }
    }
}

#Preview {
    FishCardView(fish: Fish(id: UUID(), species: "test"))
}
