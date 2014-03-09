// Generated by IB v0.4.3 gem. Do not edit it manually
// Run `rake ib:open` to refresh

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate: UIResponder <UIApplicationDelegate>
-(IBAction) applicationDidEnterBackground:(id) application;
-(IBAction) applicationWillEnterForeground:(id) application;
-(IBAction) setMixingState:(id) state;

@end

@interface EditController: UIViewController

@property IBOutlet UIScrollView * editScrollView;
@property IBOutlet UIView * editView;
@property IBOutlet UILabel * titleLabel0;
@property IBOutlet UILabel * artistLabel0;
@property IBOutlet UIImageView * waveLoadImageView0;
@property IBOutlet UILabel * titleLabel1;
@property IBOutlet UILabel * artistLabel1;
@property IBOutlet UIImageView * waveLoadImageView1;
@property IBOutlet UILabel * titleLabel2;
@property IBOutlet UILabel * artistLabel2;
@property IBOutlet UIImageView * waveLoadImageView2;
@property IBOutlet UILabel * titleLabel3;
@property IBOutlet UILabel * artistLabel3;
@property IBOutlet UIImageView * waveLoadImageView3;
@property IBOutlet UILabel * titleLabel4;
@property IBOutlet UILabel * artistLabel4;
@property IBOutlet UIImageView * waveLoadImageView4;
@property IBOutlet UIPickerView * playlistPicker;

-(IBAction) viewDidLoad;
-(IBAction) dismiss;
-(IBAction) loadTrack;
-(IBAction) loadTrack0;
-(IBAction) loadTrack1;
-(IBAction) loadTrack2;
-(IBAction) loadTrack3;
-(IBAction) loadTrack4;
-(IBAction) updateLabels;
-(IBAction) updateWaveURL:(id) i;
-(IBAction) waveformViewDidRender:(id) waveformView;
-(IBAction) mediaPickerDidCancel:(id) mediaPicker;
-(IBAction) numberOfComponentsInPickerView:(id) pickerView;

@end

@interface StkController: UIViewController

@property IBOutlet UILabel * titleLabel0;
@property IBOutlet UILabel * titleLabel1;
@property IBOutlet UILabel * titleLabel2;
@property IBOutlet UILabel * titleLabel3;
@property IBOutlet UILabel * titleLabel4;
@property IBOutlet UITableView * playlistTable;
@property IBOutlet UIButton * ipodPlayButton;
@property IBOutlet UIScrollView * stingScrollView;
@property IBOutlet UIView * stingView;
@property IBOutlet UIPageControl * stingPage;
@property IBOutlet UILabel * playingLabel;

-(IBAction) viewDidLoad;
-(IBAction) viewWillAppear:(id) animated;
-(IBAction) viewDidAppear:(id) animated;
-(IBAction) viewWillDisappear:(id) animated;
-(IBAction) play;
-(IBAction) stop;
-(IBAction) iPodPlayPause;
-(IBAction) iPodPrevious;
-(IBAction) iPodNext;
-(IBAction) updateStingTitles;
-(IBAction) updateTable;
-(IBAction) playbackStateDidChange:(id) notification;
-(IBAction) updatePlayPause;
-(IBAction) playlistDidChange;
-(IBAction) showWalkthrough;
-(IBAction) scrollViewDidEndDecelerating:(id) scrollView;

@end

@interface WalkthroughController: UIViewController

@property IBOutlet UIImageView * walkthroughImageView;

-(IBAction) viewDidLoad;
-(IBAction) imageTapped;

@end

@interface Engine: NSObject
-(IBAction) initialize;
-(IBAction) playSting:(id) selectedSting;
-(IBAction) stopSting;
-(IBAction) playiPod;
-(IBAction) playiPodItem:(id) index;
-(IBAction) pauseiPod;

@end

@interface Music: NSObject
-(IBAction) initialize:(id) selectedPlaylist;
-(IBAction) play;
-(IBAction) pause;
-(IBAction) previous;
-(IBAction) next;
-(IBAction) playItem:(id) index;
-(IBAction) nowPlayingItem;
-(IBAction) isPlaying;
-(IBAction) refreshPlaylists;
-(IBAction) getNamedPlaylist:(id) name;
-(IBAction) getAllPlaylists;
-(IBAction) usePlaylist:(id) index;

@end

@interface Sting: NSObject
-(IBAction) play;
-(IBAction) stop;
-(IBAction) loadSting:(id) mediaItem;
-(IBAction) setCue:(id) cuePoint;
-(IBAction) getCue;
-(IBAction) audioPlayerBeginInterruption:(id) player;

@end

