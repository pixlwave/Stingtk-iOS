import UIKit

class StingViewController: UIViewController {
    
    // access the music
    let engine = Engine.shared
    
    enum Bound { case lower, upper }
    
    var sting: Sting!
    var waveformView: FDWaveformView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var waveformLoadingView: UIView!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var loopSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load track info
        updateLabels()
        if engine.playingSting != nil { previewButton.setTitle("Stop", for: .normal) }
        loopSwitch.isOn = sting.loops
        
        // set up the waveform view
        waveformView = FDWaveformView(frame: .zero)
        waveformView.delegate = self
        waveformView.doesAllowScrubbing = true
        waveformView.doesAllowScroll = true
        waveformView.doesAllowStretch = true
        waveformView.boundToScrub = .lower
        waveformView.wavesColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1.0)
        waveformView.progressColor = UIColor(red: 0.25, green: 0.25, blue: 1.0, alpha: 1.0)
        
        // render the waveform
        waveformView.audioURL = sting.url
        view.addSubview(waveformView)
    }
    
    override func viewWillLayoutSubviews() {
        waveformView.frame = waveformLoadingView.frame
    }
    
    func updateLabels() {
        if let name = sting.name {
            titleLabel.text = name
            subtitleLabel.text = sting.songTitle
        } else {
            titleLabel.text = sting.songTitle
            subtitleLabel.text = sting.songArtist
        }
    }
    
    @IBAction func boundControlChanged(_ sender: UISegmentedControl) {
        waveformView.boundToScrub = sender.selectedSegmentIndex == 0 ? .lower : .upper
    }
    
    
    @IBAction func togglePreview() {
        if engine.playingSting == nil {
            previewButton.setTitle("Stop", for: .normal)
            engine.play(sting)
        } else {
            previewButton.setTitle("Preview", for: .normal)
            engine.stopSting()
        }
    }
    
    @IBAction func zoomWaveOut() {
        waveformView.zoomSamples = Range(0...waveformView.totalSamples)
    }
    
    @IBAction func toggleLoop(_ sender: UISwitch) {
        sting.loops = sender.isOn
        engine.show.updateChangeCount(.done)
    }
    
    @IBAction func done() {
        dismiss(animated: true)
    }
}


// MARK: FDWaveformViewDelegate
extension StingViewController: FDWaveformViewDelegate {
    
    func waveformViewDidLoad(_ waveformView: FDWaveformView) {
        // once the audio file has loaded (and totalSamples is known), set the highlighted samples
        waveformView.highlightedSamples = Int(sting.startSample)..<Int(sting.endSample)
    }
    
    func waveformViewDidRender(_ waveform: FDWaveformView) {
        waveformView.frame = waveformLoadingView.frame
        waveformLoadingView.isHidden = true
    }
    
    func waveformDidEndScrubbing(_ waveformView: FDWaveformView) {
        sting.startSample = Int64(waveformView.highlightedSamples?.lowerBound ?? 0)
        sting.endSample = Int64(waveformView.highlightedSamples?.upperBound ?? waveformView.totalSamples)
        engine.show.updateChangeCount(.done)
    }
    
}
