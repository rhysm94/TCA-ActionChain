//
//  ContentView.swift
//  TCA-ActionChain
//
//  Created by Rhys Morgan on 12/05/2021.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
	let store: Store<TestState, TestAction>

	var body: some View {
		WithViewStore(store) { viewStore in
			NavigationView {
				VStack {
					HStack {
						Button {
							viewStore.send(.initialise)
						} label: {
							Text("Initialise")
						}
						.disabled(viewStore.inFlight)

						Button {
							viewStore.send(.reset)
						} label: {
							Text("Reset")
						}
					}

					List {
						HStack {
							Text("Foo Completed:")
							Spacer()
							if viewStore.fooCompleted {
								Image(systemName: "checkmark")
							}
						}

						HStack {
							Text("Bar Completed:")
							Spacer()
							if viewStore.barCompleted {
								Image(systemName: "checkmark")
							}
						}

						HStack {
							Text("Baz Completed:")
							Spacer()
							if viewStore.bazCompleted {
								Image(systemName: "checkmark")
							}
						}
					}

				}
				.navigationTitle(Text("Test Store View"))
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(
			store: Store(
				initialState: TestState(),
				reducer: testReducer,
				environment: TestEnvironment(mainQueue: .main)
			)
		)
	}
}
