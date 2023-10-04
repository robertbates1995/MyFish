//
//  LengthPickerView.swift
//  MyFish
//
//  Created by Robert Bates on 9/28/23.
//

import SwiftUI
import ComposableArchitecture

struct LengthPickerFeature: Reducer {
    struct State: Equatable {
        @BindingState var feet = 0
        @BindingState var inches = 0
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce{ state,action in
            return .none
        }
    }
}

struct LengthPickerView: View {
    let store: StoreOf<LengthPickerFeature>
    
    var body: some View {
        VStack {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                HStack {
                    Text("\(viewStore.feet)'")
                    Text("\(viewStore.inches)''")
                }.font(.largeTitle)
                HStack {
                    Picker(selection: viewStore.$feet, label: Text("Feet")) {
                        ForEach(0...99, id: \.self){ i in
                            Text(String(i)).tag(i)
                        }
                    }.pickerStyle(.wheel)
                    Picker(selection: viewStore.$inches, label: Text("Inches")) {
                        ForEach(0...11, id: \.self){ i in
                            Text(String(i)).tag(i)
                        }
                    }.pickerStyle(.wheel)
                }
            }
        }
    }
}

#Preview {
    LengthPickerView(store: Store(initialState: LengthPickerFeature.State()){LengthPickerFeature()})
}
