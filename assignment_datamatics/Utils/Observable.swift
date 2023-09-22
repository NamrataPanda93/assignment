//
//  Observable.swift
//  assignment_cygnvs
//
//  Created by Namrata Panda  on 23/08/23.
//

import Foundation

class Observable<T> {
    
    typealias Listener = (T?) -> Void
    var listener: Listener?
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}