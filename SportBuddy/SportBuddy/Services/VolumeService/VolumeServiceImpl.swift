//
//  VolumeServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 11. 16..
//

import MediaPlayer

final class VolumeServiceImpl { }

// MARK: - VolumeService

extension VolumeServiceImpl: VolumeService {
    func set(volume: CGFloat) {
        let view = MPVolumeView()
        let slider = view.subviews.filter { NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as? UISlider
        slider?.setValue(volume.float, animated: false)
    }
}
