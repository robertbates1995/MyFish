//
//  AppView.swift
//  MyFish
//
//  Created by Robert Bates on 10/5/23.
//

import SwiftUI
import ComposableArchitecture

struct AppFeature: Reducer {
    struct State {
        var fishList = FishListFeature.State()
    }
    
    enum Action {
        case fishList(FishListFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope( state: \.fishList, action: /Action.fishList) {
            FishListFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .fishList:
                return .none
            }
        }
    }
}

struct AppView: View {
    var body: some View {
        Text("hello world")
    }
}

#Preview {
    AppView()
}
