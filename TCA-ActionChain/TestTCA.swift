//
//  TestTCA.swift
//  TCA-ActionChain
//
//  Created by Rhys Morgan on 12/05/2021.
//

import ComposableArchitecture

struct TestState: Equatable {
	var inFlight = false

	var fooCompleted = false
	var barCompleted = false
	var bazCompleted = false
}

enum TestAction {
	case initialise
	case reset

	case getFoo
	case getFooResponse(Result<String, Error>)

	case getBar
	case getBarResponse(Result<Double, Error>)

	case getBaz
	case getBazResponse(Result<Int, Error>)
}

struct TestEnvironment {
	var mainQueue: AnySchedulerOf<DispatchQueue>
	var randomNumberGen = {
		Double.random(in: 0.5...3)
	}
}

let testReducer = Reducer<TestState, TestAction, TestEnvironment> { state, action, env in
	switch action {
	case .initialise:
		state.inFlight = true
		return .concatenate(
			Effect(value: .getFoo),
			Effect(value: .getBar),
			Effect(value: .getBaz)
		)

	case .reset:
		state = TestState()
		return .none

	case .getFoo:
		return Effect(value: .getFooResponse(.success("Hello, World!")))
			.delay(for: .seconds(env.randomNumberGen()), scheduler: env.mainQueue)
			.eraseToEffect()

	case .getFooResponse(let result):
		print("Get Foo Completed: \(result)")
		state.fooCompleted = true
		return .none

	case .getBar:
		return Effect(value: .getBarResponse(.success(3.14159265)))
			.delay(for: .seconds(env.randomNumberGen()), scheduler: env.mainQueue)
			.eraseToEffect()

	case .getBarResponse(let result):
		print("Get Bar Completed: \(result)")
		state.barCompleted = true
		return .none


	case .getBaz:
		return Effect(value: .getBazResponse(.success(5)))
			.delay(for: .seconds(env.randomNumberGen()), scheduler: env.mainQueue)
			.eraseToEffect()

	case .getBazResponse(let result):
		print("Get Head Completed: \(result)")
		state.bazCompleted = true
		return .none
	}
}
