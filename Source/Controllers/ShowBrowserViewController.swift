import UIKit

class ShowBrowserViewController: UIDocumentBrowserViewController {
    
    var transitionController: UIDocumentBrowserTransitionController?
    var hasRestored = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        allowsDocumentCreation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        #if targetEnvironment(simulator)
        if !hasRestored { openShow(at: Show.defaultURL, animated: false) }
        #endif
    }
    
    func openShow(at url: URL, animated: Bool = true) {
        let show = Show(fileURL: url)
        show.open { success in
            if success { self.present(show, animated: animated) }
        }
    }
    
    func present(_ show: Show, animated: Bool) {
        Show.shared = show
        
        guard
            let storyboard = storyboard,
            let rootVC = storyboard.instantiateViewController(withIdentifier: "Root View Controller") as? UINavigationController,
            let playbackVC = rootVC.topViewController as? PlaybackViewController
        else { return }
        
        rootVC.transitioningDelegate = self
        transitionController = transitionController(forDocumentAt: show.fileURL)
        transitionController?.targetView = playbackVC.view
        
        present(rootVC, animated: animated)
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        if presentedViewController != nil {
            let showURL = Show.shared.fileURL
            
            let didStartAccessing = showURL.startAccessingSecurityScopedResource()
            defer {
                if didStartAccessing { showURL.stopAccessingSecurityScopedResource() }
            }
            
            if let bookmarkData = try? showURL.bookmarkData() {
                coder.encode(bookmarkData, forKey: "showBookmarkData")
            }
        }
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        if let bookmarkData = coder.decodeObject(forKey: "showBookmarkData") as? Data {
            var isStale = false
            if let url = try? URL(resolvingBookmarkData: bookmarkData, bookmarkDataIsStale: &isStale), url.isFileURL {
                hasRestored = true
                openShow(at: url, animated: false)
            }
        }
        
        super.decodeRestorableState(with: coder)
    }
}


// MARK: UIDocumentBrowserViewControllerDelegate
extension ShowBrowserViewController: UIDocumentBrowserViewControllerDelegate {
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        guard
            let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else {
            importHandler(nil, .none)
            return
        }
        
        let show = Show(fileURL: cacheURL.appendingPathComponent("Show.stkshow"))
        if !FileManager.default.fileExists(atPath: show.fileURL.path) {
            show.save(to: show.fileURL, for: .forCreating) { sucess in
                importHandler(show.fileURL, .move)
            }
        } else {
            importHandler(show.fileURL, .move)
        }
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let url = documentURLs.first, url.isFileURL else { return }
        openShow(at: url)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        guard destinationURL.isFileURL else { return }
        openShow(at: destinationURL)
    }
}


//
extension ShowBrowserViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionController
    }
}
