import UIKit
import MediaPlayer

class PlaybackViewController: UICollectionViewController {
    
    private let engine = Engine.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make self delegate for sting players
        engine.setStingDelegates(self)
        
        // prevents scroll view from momentarily blocking the play button's action
        collectionView.delaysContentTouches = false; #warning("Test if this works or if the property needs to be set on the scroll view")
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .stingsDidChange, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.double(forKey: "WelcomeVersionSeen") < WelcomeViewController.currentVersion {
            showWelcomeScreen()
        }
    }
    
    #warning("Implement more efficient responses to changed data.")
    @objc func reloadData() {
        collectionView.reloadData()
    }
    
    func showWelcomeScreen() {
        // instantiate welcome controller and present
        let walkSB = UIStoryboard(name: "Welcome", bundle: nil)
        if let walkVC = walkSB.instantiateViewController(withIdentifier: "Welcome") as? WelcomeViewController {
            walkVC.modalTransitionStyle = .crossDissolve
            present(walkVC, animated:true, completion:nil)
            
            // record the version being seen to allow ui updates to be shown in future versions
            UserDefaults.standard.set(WelcomeViewController.currentVersion, forKey: "WelcomeVersionSeen")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return engine.stings.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Sting Cell", for: indexPath)
        
        guard let stingCell = cell as? StingCell else { return cell }
        
        stingCell.titleLabel.text = engine.stings[indexPath.item].title
        
        return stingCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.cellForItem(at: indexPath) as? StingCell)?.isPlaying != true {
            engine.playSting(indexPath.item)
        } else {
            engine.stopSting()
        }
    }
    
}


// MARK: StingDelegate
extension PlaybackViewController: StingDelegate {
    func stingDidStartPlaying(_ sting: Sting) {
        let index = engine.stings.firstIndex(of: sting)
        (collectionView.cellForItem(at: IndexPath(item: index ?? 0, section: 0)) as? StingCell)?.isPlaying = true
    }
    
    func stingDidStopPlaying(_ sting: Sting) {
        let index = engine.stings.firstIndex(of: sting)
        (collectionView.cellForItem(at: IndexPath(item: index ?? 0, section: 0)) as? StingCell)?.isPlaying = false
    }
}
