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

// precedencegroup Bind {
//     associativity: left
//     higherThan: TernaryPrecedence
// }

//Bind
infix operator ||> : ForwardPipe

public func ||> <T, E, U>(val: Result<T, E>, fn: (T) -> U) -> Result<U, E> {
    switch val {
        case .Ok(let x):
            return .Ok(fn(x))
        case .Err(let e):
            return .Err(e)
    }
}

//RocketShip
precedencegroup Composition {
    associativity: left
    higherThan: ForwardPipe
}

infix operator >=> : Composition

public func >=> <T, E, U, V>(fn1: @escaping (T) -> Result<U, E>, fn2: @escaping (U) -> V) -> (T) -> Result<V, E> {
    return { val -> Result<V, E> in 
        switch fn1(val) {
            case Result.Ok(let x):
                return .Ok(fn2(x))
            case Result.Err(let e):
                return .Err(e)
        }
    }
}

// precedencegroup SingleComposition {
//     associativity: left
//     higherThan: TernaryPrecedence
// }

//Single Composition
infix operator >-> : Composition

public func >-> <T, U, V>(fn1: @escaping (T) -> U, fn2: @escaping (U) -> V) -> (T) -> V {
    return { val -> V in fn2(fn1(val)) }
}

// func add(_ x: Int) -> Int { return x + 5 }

// let vv = 5 |> add

// print(vv)
