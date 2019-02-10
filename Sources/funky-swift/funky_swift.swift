struct funky_swift {
    var text = "Hello, World!"
}
//precedence: higher than logical? x |> y && z |> a needs to evaluate the functions first

public enum Result<T, U> {
    case Ok(T)
    case Err(U)
}


precedencegroup ForwardPipe {
    associativity: left
    higherThan: TernaryPrecedence
}

infix operator |> : ForwardPipe

public func |> <T, U>(val: T, fn: (T) -> U) -> U {
    return fn(val)
}


// Bind, >>=
infix operator ||> : ForwardPipe

public func ||> <T, E, U>(result: Result<T, E>, fn: (T) -> Result<U, E>) -> Result<U, E> {
    switch result {
        case .Ok(let data):
            return fn(data)
        case .Err(let e):
            return .Err(e)
    }
}

precedencegroup Composition {
    associativity: left
    higherThan: ForwardPipe
}

// Single Composition
infix operator >-> : Composition

public func >-> <T, U, V>(fn1: @escaping (T) -> U, fn2: @escaping (U) -> V) -> (T) -> V {
    return { val -> V in fn2(fn1(val)) }
}


// RocketShip... fine Kleisli
infix operator >=> : Composition

public func >=> <T, E, U, V>(fn1: @escaping (T) -> Result<U, E>, fn2: @escaping (U) -> Result<V, E>) -> (T) -> Result<V, E> {
    return { val in
        fn1(val) ||> fn2
    }
}
