//
//  HomeTableViewCell.swift
//  VideoPlayer
//
//  Created by jatin verma on 29/04/21.
//

import UIKit
import AVFoundation



class HomeTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    var playerView: VideoPlayerView!

    @IBOutlet weak var pauseImgView: UIImageView!{
        didSet{
            pauseImgView.alpha = 0
        }
    }
    
    // MARK: - Variables
    private(set) var isPlaying = false
    private(set) var liked = false
    var url: String?
    
    // MARK: LIfecycles
    override func prepareForReuse() {
        super.prepareForReuse()
        playerView.cancelAllLoadingRequest()
        resetViewsForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        playerView = VideoPlayerView(frame: self.contentView.frame)
        print(index)
        contentView.addSubview(playerView)
        contentView.sendSubviewToBack(playerView)
        
        let pauseGesture = UITapGestureRecognizer(target: self, action: #selector(handlePause))
        self.contentView.addGestureRecognizer(pauseGesture)
                
    }
    
    
    func configure(url: String){
        self.url = url
        playerView.configure(url: URL(string: url), fileExtension: ".mp4", size: (1080, 1920))
    }
    
    
    func replay(){
        if !isPlaying {
            playerView.replay()
            play()
        }
    }
    
    func play() {
        if !isPlaying {
            playerView.play()
            isPlaying = true
        }
    }
    
    func pause(){
        if isPlaying {
            playerView.pause()
            isPlaying = false
        }
    }
    
    @objc func handlePause(){
        if isPlaying {
            // Pause video and show pause sign
            UIView.animate(withDuration: 0.075, delay: 0, options: .curveEaseIn, animations: { [weak self] in
                guard let self = self else { return }
                self.pauseImgView.alpha = 0.35
                self.pauseImgView.transform = CGAffineTransform.init(scaleX: 0.45, y: 0.45)
            }, completion: { [weak self] _ in
                self?.pause()
            })
        } else {
            // Start video and remove pause sign
            UIView.animate(withDuration: 0.075, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                guard let self = self else { return }
                self.pauseImgView.alpha = 0
            }, completion: { [weak self] _ in
                self?.play()
                self?.pauseImgView.transform = .identity
            })
        }
    }
    
    func resetViewsForReuse(){
        pauseImgView.alpha = 0
    }
    
    
}
