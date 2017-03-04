//
//  Queue.swift
//  MathOfTheDead
//
//  Created by Rachel Shellborn on 2017-02-10.
//  Copyright © 2017 NGU. All rights reserved.
//

import Foundation

public struct Queue<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public var front: T! {
        return array.first
    }
    
    public func getValue(_ num: Int) -> T! {
        return array[num]
    }
}

public class BulletQueue {
    var queue = Queue<Int>()
    let maxVal = 5
    let minVal = -5

    init() {
        generateQueue()
    }
    
    public func generateQueue() {
        for _ in 0 ..< 5 {
            let val = generateValue()
            queue.enqueue(val)
            print(val)
        }
    }
    
    public func generateNewBullet() {
        queue.dequeue()
        queue.enqueue(generateValue())
    }
    
    public func generateValue() -> Int {
        //implement checking for max number of 0's later
        
        var val = minVal + Int(arc4random_uniform(UInt32(maxVal - minVal + 1)))
        
        while val == 0 {
            val = minVal + Int(arc4random_uniform(UInt32(maxVal - minVal + 1)))
        }
        
        return val
    }
    
    
}
