//
//  WeakBox.swift
//
//  Created by Vladymyr Martyniuk on 20.12.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation


public struct WeakBox<Wrapped: AnyObject> {
    
    public var isEmpty: Bool {
        return self.wrapped == nil
    }
    
    public private(set) weak var wrapped: Wrapped?
    
    public init(_ wrapped: Wrapped?) {
        self.wrapped = wrapped
    }
}

public struct WeakFunction<Object: AnyObject> {
    
    // MARK: -
    // MARK: Variables
    
    private let wrappedFunction: (Object) -> () -> ()
    
    private(set) weak var wrapped: Object?
    
    public var isEmpty: Bool {
        return self.wrapped == nil
    }
    
    // MARK: -
    // MARK: Initializations
    
    public init(signature: @escaping (Object) -> () -> (), object: Object) {
        self.wrappedFunction = signature
        self.wrapped = object
    }
    
    // MARK: -
    // MARK: Public
    
    public func execute() {
        self.wrapped.map {
            self.wrappedFunction($0)()
        }
    }
}

extension WeakBox: Equatable {
    
    public static func ==(lhs: WeakBox, rhs: WeakBox) -> Bool {
        return lhs.wrapped.flatMap { lhs in
            rhs.wrapped.map { $0 === lhs }
        }
            ?? false
    }
}
