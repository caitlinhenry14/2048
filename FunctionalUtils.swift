func bind<T, U>(_ x: T, _ closure: (T) -> U) -> U {
    return closure(x)
}
