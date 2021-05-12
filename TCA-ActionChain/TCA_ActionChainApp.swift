//
//  TCA_ActionChainApp.swift
//  TCA-ActionChain
//
//  Created by Rhys Morgan on 12/05/2021.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_ActionChainApp: App {
    var body: some Scene {
        WindowGroup {
			ContentView(
				store: Store(
					initialState: TestState(),
					reducer: testReducer,
					environment: TestEnvironment(mainQueue: .main)
				)
			)
        }
    }
}
