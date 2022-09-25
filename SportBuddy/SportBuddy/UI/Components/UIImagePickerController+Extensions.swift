//
//  ImagePickerController.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 19..
//

import UIKit

extension UIImagePickerController {
    struct MediaType: OptionSet {
        let rawValue: Int
        static let image = MediaType(rawValue: 1 << 0)
        static let movie = MediaType(rawValue: 1 << 1)

        init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    /// Set the available media types.
    /// - Parameters:
    ///   - mediaType: the media types.
    func setMediaType(mediaType: MediaType) {
        let movie = "public.movie"
        let image = "public.image"
        if mediaType.contains(.movie) {
            mediaTypes.append(movie)
        }
        if mediaType.contains(.image) {
            mediaTypes.append(image)
        }
    }
}

extension UIImagePickerController {
    // swiftlint:disable:next convenience_type
    private struct AssociatedObjectKeys {
        static var willDismiss = "willDismiss"
        static var didDismiss = "didDismiss"
        static var didTapCancel = "didTapCancel"
        static var didFinish = "didFinish"
    }

    private var willDismiss: ((UIImagePickerController) -> Void)? {
        get {
            getAssociatedObject(self, &AssociatedObjectKeys.willDismiss)
        }
        set {
            setAssociatedObject(self, &AssociatedObjectKeys.willDismiss, newValue)
        }
    }

    private var didDismiss: ((UIImagePickerController) -> Void)? {
        get {
            getAssociatedObject(self, &AssociatedObjectKeys.didDismiss)
        }
        set {
            setAssociatedObject(self, &AssociatedObjectKeys.didDismiss, newValue)
        }
    }

    private var didTapCancel: ((UIImagePickerController) -> Void)? {
        get {
            getAssociatedObject(self, &AssociatedObjectKeys.didTapCancel)
        }
        set {
            setAssociatedObject(self, &AssociatedObjectKeys.didTapCancel, newValue)
        }
    }

    private var didFinish: ((UIImagePickerController, [InfoKey: Any]) -> Void)? {
        get {
            getAssociatedObject(self, &AssociatedObjectKeys.didFinish)
        }
        set {
            setAssociatedObject(self, &AssociatedObjectKeys.didFinish, newValue)
        }
    }

    /// Use closures instead of delegates.
    /// - Parameters:
    ///   - willDismiss: this function will be called if the picker started to be dismissed interactively. This function can be called several times. By default does nothing.
    ///   - didDismiss: this function will be called if the picker dismissed interactively. This function will be called maximum once. By default does nothing.
    ///   - didTapCancel: this function will be called if the user tapped on the cancel button. This function can be called several times, but will be called only once if you dismiss the picker in this closure. By default does nothing.
    ///   - didFinish: this function will be called if the user selected a media. This function can be called several times, but will be called only once if you dismiss the picker in this closure. By default does nothing.
    /// - Note:
    /// Don't forget to dismiss the picker in the last two closures, if you don't want it to stay open.
    func set(willDismiss: @escaping (UIImagePickerController) -> Void = { _ in },
             didDismiss: @escaping (UIImagePickerController) -> Void = { _ in },
             didTapCancel: @escaping (UIImagePickerController) -> Void = { _ in },
             didFinish: @escaping (UIImagePickerController, [InfoKey: Any]) -> Void = { _, _ in }) {
        self.willDismiss = willDismiss
        self.didDismiss = didDismiss
        self.didTapCancel = didTapCancel
        self.didFinish = didFinish
        delegate = self
        presentationController?.delegate = self
    }
}

extension UIImagePickerController:
    UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    public func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        willDismiss?(self)
    }

    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        didDismiss?(self)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        didTapCancel?(picker)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [InfoKey: Any]) {
        didFinish?(picker, info)
    }
}
