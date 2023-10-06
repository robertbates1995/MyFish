//
//  MyFishApp.swift
//  MyFish
//
//  Created by Robert Bates on 9/21/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct MyFishApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                FishListView(
                    store: Store(
                        initialState: FishListFeature.State(fishList: [.mock])
                    ) {
                        FishListFeature()
                    }
                )
            }
        }
    }
}

#Preview {
    MyFishApp()
}
