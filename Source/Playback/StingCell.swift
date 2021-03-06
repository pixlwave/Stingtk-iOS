import UIKit

class StingCell: UICollectionViewCell {
    
    @IBOutlet weak var playbackIndicator: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    
    var color: Sting.Color = .default {
        didSet {
            backgroundColor = color.object
            layer.borderColor = color.object.cgColor
        }
    }
    
    var isPlaying = false {
        didSet {
            updatePlaybackIndicator()
        }
    }
    
    var isCued = false {
        didSet {
            updatePlaybackIndicator()
        }
    }
    
    var isMissing = false {
        didSet {
            updatePlaybackIndicator()
        }
    }
    
    func updatePlaybackIndicator() {
        if isMissing {
            playbackIndicator.image = UIImage(systemName: "exclamationmark.octagon.fill")
            playbackIndicator.tintColor = UIColor.white.withAlphaComponent(0.8)
        } else if isPlaying {
            playbackIndicator.image = UIImage(systemName: "play.circle.fill")
            playbackIndicator.tintColor = .white
        } else if isCued{
            playbackIndicator.image = UIImage(systemName: "smallcircle.fill.circle")
            playbackIndicator.tintColor = .white
        } else {
            playbackIndicator.image = UIImage(systemName: "circle")
            playbackIndicator.tintColor = .backgroundColor
        }
    }
    
}
