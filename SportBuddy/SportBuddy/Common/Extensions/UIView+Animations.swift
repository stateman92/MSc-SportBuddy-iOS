//
//  UIView+Animations.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import UIKit

extension UIView {
    final class AnimationParameters {
        private(set) var duration: TimeInterval = 0.5
        private(set) var delay: TimeInterval = .zero
        private(set) var timingFunction: CAMediaTimingFunction = .linear
        private(set) var options: UIView.AnimationOptions = []
        private(set) var spring: Spring?

        /// Specify the `AnimationParameters`.
        /// - Parameters:
        ///   - duration: the given duration.
        /// - Returns:
        ///     The modified `AnimationParameters`.
        @discardableResult func with(duration: TimeInterval) -> Self {
            self.duration = duration
            return self
        }

        /// Specify the `AnimationParameters`.
        /// - Parameters:
        ///   - delay: the given delay.
        /// - Returns:
        ///     The modified `AnimationParameters`.
        @discardableResult func with(delay: TimeInterval) -> Self {
            self.delay = delay
            return self
        }

        /// Specify the `AnimationParameters`.
        /// - Parameters:
        ///   - timingFunction: the given timingFunction.
        /// - Returns:
        ///     The modified `AnimationParameters`.
        @discardableResult func with(timingFunction: CAMediaTimingFunction) -> Self {
            self.timingFunction = timingFunction
            return self
        }

        /// Specify the `AnimationParameters`.
        /// - Parameters:
        ///   - options: the given options.
        /// - Returns:
        ///     The modified `AnimationParameters`.
        @discardableResult func with(options: UIView.AnimationOptions) -> Self {
            self.options = options
            return self
        }

        /// Specify the `AnimationParameters`.
        /// - Parameters:
        ///   - options: the given options.
        /// - Returns:
        ///     The modified `AnimationParameters`.
        @discardableResult func add(options: UIView.AnimationOptions) -> Self {
            self.options.insert(options)
            return self
        }

        /// Specify the `AnimationParameters`.
        /// - Parameters:
        ///   - spring: the given spring.
        /// - Returns:
        ///     The modified `AnimationParameters`.
        @discardableResult func with(spring: Spring?) -> Self {
            self.spring = spring
            return self
        }
    }

    final class Spring {
        /// The damping ratio of the animation. To smoothly decelerate the animation without oscillation, use a value of `1`. A damping ratio closer to zero is increasing oscillation.
        private(set) var damping: CGFloat = 0.75

        /// The initial velocity of the animation. A value of `1` corresponds to the total animation distance traversed in one second. For example, if the total animation distance is 200 points and you want the start of the animation to match a view velocity of 100 pt/s, use a value of `0.5`.
        private(set) var velocity: CGFloat = 0.75

        /// Specify the `Spring`.
        /// - Parameters:
        ///   - damping: the given damping.
        /// - Returns:
        ///     The modified `Spring`.
        @discardableResult func with(damping: CGFloat) -> Self {
            self.damping = damping
            return self
        }

        /// Specify the `Spring`.
        /// - Parameters:
        ///   - velocity: the given velocity.
        /// - Returns:
        ///     The modified `Spring`.
        @discardableResult func with(velocity: CGFloat) -> Self {
            self.velocity = velocity
            return self
        }
    }

    /// Perform a view animation using the `AnimationParameters`.
    /// - Parameters:
    ///   - animationParameters: the given `AnimationParameters`.
    ///   - before: this function gets called before the animation. By default does nothing.
    ///   - animations: this function describes the animation. This can happen immediately or with the given duration.
    ///   - completion: this function gets called after the animation finishes. If the duration is not bigger then `.zero`, then this will called immediately. By default does nothing.
    /// - Returns:
    ///     The return value of the `before` method.
    @discardableResult class func animate<T>(animationParameters: AnimationParameters,
                                             before: () -> T? = { nil },
                                             animations: @escaping () -> Void,
                                             completion: @escaping (Bool) -> Void = { _ in }) -> T? {
        let returnValue = before()
        if animationParameters.duration > .zero {
            if let spring = animationParameters.spring {
                UIView.animate(withDuration: animationParameters.duration,
                               delay: animationParameters.delay,
                               usingSpringWithDamping: spring.damping,
                               initialSpringVelocity: spring.velocity,
                               options: animationParameters.options
                                .union(animationParameters.timingFunction.asAnimationOptions)) {
                    animations()
                } completion: { finished in
                    completion(finished)
                }
            } else {
                UIView.animate(withDuration: animationParameters.duration,
                               delay: animationParameters.delay,
                               options: animationParameters.options
                                .union(animationParameters.timingFunction.asAnimationOptions)) {
                    animations()
                } completion: { finished in
                    completion(finished)
                }
            }
        } else {
            animations()
            completion(true)
        }
        return returnValue
    }

    /// Perform a view animation using the `AnimationParameters`.
    /// - Parameters:
    ///   - parameters: the given `AnimationParameters`.
    ///   - before: this function gets called before the animation. By default does nothing.
    ///   - animations: this function describes the animation. This can happen immediately or with the given duration.
    ///   - completion: this function gets called after the animation finishes. If the duration is not bigger then `.zero`, then this will called immediately. By default does nothing.
    class func animate(parameters: AnimationParameters,
                       before: () -> Void = { },
                       animations: @escaping () -> Void,
                       completion: @escaping (Bool) -> Void = { _ in }) {
        animate(animationParameters: parameters, before: before, animations: animations, completion: completion)
    }

    /// Perform a view animation using the `AnimationParameters`.
    /// - Parameters:
    ///   - animationParameters: the given `AnimationParameters`.
    ///   - before: this function gets called before the animation. By default does nothing.
    ///   - animations: this function describes the animation. This can happen immediately or with the given duration.
    ///   - completion: this function gets called after the animation finishes. If the duration is not bigger then `.zero`, then this will called immediately. By default does nothing.
    /// - Returns:
    ///     The return value of the `before` method.
    @discardableResult class func animate<T>(animationParameters: AnimationParameters,
                                             before: () -> T? = { nil },
                                             animations: @escaping () -> Void,
                                             completion: @escaping () -> Void = { }) -> T? {
        animate(animationParameters: animationParameters,
                before: before,
                animations: animations,
                completion: { _ in completion() })
    }

    /// Perform a view animation using the `AnimationParameters`.
    /// - Parameters:
    ///   - animationParameters: the given `AnimationParameters`.
    ///   - before: this function gets called before the animation. By default does nothing.
    ///   - animations: this function describes the animation. This can happen immediately or with the given duration.
    ///   - completion: this function gets called after the animation finishes. If the duration is not bigger then `.zero`, then this will called immediately. By default does nothing.
    /// - Returns:
    ///     The return value of the `before` method.
    @discardableResult func apply<T>(animationParameters: AnimationParameters,
                                     before: () -> T? = { nil },
                                     animations: @escaping () -> Void,
                                     completion: @escaping () -> Void = { }) -> T? {
        Self.animate(animationParameters: animationParameters,
                     before: before,
                     animations: animations,
                     completion: { _ in completion() })
    }

    /// Perform a view animation using the `AnimationParameters`.
    /// - Parameters:
    ///   - animationParameters: the given `AnimationParameters`.
    ///   - before: this function gets called before the animation. By default does nothing.
    ///   - animations: this function describes the animation. This can happen immediately or with the given duration.
    ///   - completion: this function gets called after the animation finishes. If the duration is not bigger then `.zero`, then this will called immediately. By default does nothing.
    /// - Returns:
    ///     The return value of the `before` method.
    @discardableResult func apply<T>(animationParameters: AnimationParameters,
                                     before: () -> T? = { nil },
                                     animations: @escaping () -> Void,
                                     completion: @escaping (Bool) -> Void = { _ in }) -> T? {
        Self.animate(animationParameters: animationParameters,
                     before: before,
                     animations: animations,
                     completion: completion)
    }

    /// Perform a view animation without delay using the parameters.
    /// - Parameters:
    ///   - withDuration: the duration of the animation (in seconds).
    ///   - options: the options of the animation.
    ///   - spring: the spring values of the animation. By default `nil`.
    ///   - before: this function gets called before the animation. By default does nothing.
    ///   - animations: this function describes the animation. This can happen immediately or with the given duration.
    ///   - completion: this function gets called after the animation finishes. If the duration is not bigger then `.zero`, then this will called immediately. By default does nothing.
    class func animate(duration: TimeInterval?,
                       options: UIView.AnimationOptions,
                       spring: Spring? = nil,
                       before: () -> Void = { },
                       animations: @escaping () -> Void,
                       completion: @escaping (Bool) -> Void = { _ in }) {
        before()
        if let duration = duration, duration > .zero {
            if let spring = spring {
                UIView.animate(withDuration: duration,
                               usingSpringWithDamping: spring.damping,
                               initialSpringVelocity: spring.velocity,
                               options: options) {
                    animations()
                } completion: { finished in
                    completion(finished)
                }
            } else {
                UIView.animate(withDuration: duration, options: options) {
                    animations()
                } completion: { finished in
                    completion(finished)
                }
            }
        } else {
            animations()
            completion(true)
        }
    }

    /// Perform a view animation without delay using the parameters.
    /// - Parameters:
    ///   - withDuration: the duration of the animation (in seconds).
    ///   - timingFunction: the timing function of the animation. By default `.linear`.
    ///   - spring: the spring values of the animation. By default `nil`.
    ///   - before: this function gets called before the animation. By default does nothing.
    ///   - animations: this function describes the animation. This can happen immediately or with the given duration.
    ///   - completion: this function gets called after the animation finishes. If the duration is not bigger then `.zero`, then this will called immediately. By default does nothing.
    class func animate(duration: TimeInterval?,
                       timingFunction: CAMediaTimingFunction = .linear,
                       spring: Spring? = nil,
                       before: () -> Void = { },
                       animations: @escaping () -> Void,
                       completion: @escaping (Bool) -> Void = { _ in }) {
        animate(duration: duration,
                options: timingFunction.asAnimationOptions,
                spring: spring,
                before: before,
                animations: animations,
                completion: completion)
    }

    /// Perform a view animation without delay using the parameters.
    /// - Parameters:
    ///   - withDuration: the duration of the animation (in seconds).
    ///   - options: the options of the animation.
    ///   - animations: this function describes the animation. This can happen immediately or with the given duration.
    ///   - completion: this function gets called after the animation finishes. If there is no duration (or less than `0.000001`), then this will called immediately. By default does nothing.
    class func animate(withDuration duration: TimeInterval,
                       options: AnimationOptions,
                       animations: @escaping () -> Void,
                       completion: @escaping (Bool) -> Void = { _ in }) {
        UIView.animate(withDuration: duration,
                       delay: .zero,
                       options: options,
                       animations: animations,
                       completion: completion)
    }

    /// Perform a view animation without delay using the parameters.
    /// - Parameters:
    ///   - withDuration: the duration of the animation (in seconds).
    ///   - usingSpringWithDamping: the damping ratio of the animation. To smoothly decelerate the animation without oscillation, use a value of `1`. A damping ratio closer to zero is increasing oscillation.
    ///   - initialSpringVelocity: the initial velocity of the animation. A value of `1` corresponds to the total animation distance traversed in one second. For example, if the total animation distance is 200 points and you want the start of the animation to match a view velocity of 100 pt/s, use a value of `0.5`.
    ///   - options: the options of the animation.
    ///   - animations: this function describes the animation. This can happen immediately or with the given duration.
    ///   - completion: this function gets called after the animation finishes. If there is no duration (or less than `0.000001`), then this will called immediately. By default does nothing.
    class func animate(withDuration duration: TimeInterval,
                       usingSpringWithDamping: CGFloat,
                       initialSpringVelocity: CGFloat,
                       options: AnimationOptions,
                       animations: @escaping () -> Void,
                       completion: @escaping (Bool) -> Void = { _ in }) {
        UIView.animate(withDuration: duration,
                       delay: .zero,
                       usingSpringWithDamping: usingSpringWithDamping,
                       initialSpringVelocity: initialSpringVelocity,
                       options: options,
                       animations: animations,
                       completion: completion)
    }
}
