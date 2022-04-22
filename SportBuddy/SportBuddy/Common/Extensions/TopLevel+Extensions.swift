//
//  TopLevel+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 31..
//

import Foundation

/// Return the value associated with a given object for a given key.
/// - Parameters:
///   - _: the source object for the association.
///   - key: the key for the association.
/// - Returns:
///     The value associated with the key.
func getAssociatedObject<T>(_ object: Any, _ key: UnsafeRawPointer) -> T? {
    objc_getAssociatedObject(object, key) as? T
}

/// Set an associated value for a given object using a given key and association policy.
/// - Parameters:
///   - _: the source object for the association.
///   - key: the key for the association.
///   - value: the value to associate with the key key for object. If `nil`, then it clears the (probably) existing association.
///   - policy: the policy for the association. By default `.OBJC_ASSOCIATION_RETAIN`.
/// - Returns:
///     The value associated with the key.
func setAssociatedObject<T>(_ object: Any,
                            _ key: UnsafeRawPointer,
                            _ value: T?,
                            _ policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN) {
    objc_setAssociatedObject(object, key, value, policy)
}

func dispatchToMain(closure: @escaping () -> Void) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async {
            closure()
        }
    }
}

/// Run the closures depending on the device type.
/// - Parameters:
///   - real: run if the device is a real device.
///   - simulator: run if the device is a simulator. By default does nothing.
/// - Returns:
///     Whether it runs on a real device.
@discardableResult func runOnDevice(real: () -> Void, simulator: () -> Void = { }) -> Bool {
#if targetEnvironment(simulator)
    simulator()
    return false
#else
    real()
    return true
#endif
}

func run(key: Key, times: Int, closure: () -> Void, else: () -> Void) {
    guard times > .zero else {
        `else`()
        return
    }
    let helper = SettingsHelper.self
    let secure = false
    let int: Int? = helper.retrieve(forKey: key, secure: secure)
    if let int = int {
        helper.save(object: int + 1, forKey: key, secure: secure)
        if int < times {
            closure()
        } else {
            `else`()
        }
    } else {
        closure()
        helper.save(object: 1, forKey: key, secure: secure)
    }
}
