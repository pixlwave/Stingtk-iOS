class AppDelegate

  attr_reader :window
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    # prevent device from going to sleep
    application.setIdleTimerDisabled(true)

    # allow music to play whilst muted
    AVAudioSession.sharedInstance.setCategory(AVAudioSessionCategoryPlayback, error:nil)

    # prevent app launch from killing iPod by allowing mixing
    setMixingState(true)

    # set up main window and begin!
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @storyboard = UIStoryboard.storyboardWithName("Storyboard", bundle:nil)
    @window.rootViewController = @storyboard.instantiateInitialViewController
    @window.makeKeyAndVisible

    true

  end

  def applicationDidEnterBackground(application)

    # disables mixing so that if a sting is playing and the user chooses to play something else, stingtk is faded out
    setMixingState(false) unless Engine.sharedClient.ipod.isPlaying

  end

  def applicationWillEnterForeground(application)

    # re-enables mixing so app launch doesn't kill iPod music
    setMixingState(true)

    # refresh playlists in case user has edited anything in the iPod app
    # doesn't work?! calling from edit controller but needs to be on app appearing again for complete consistency.
    # Engine.sharedClient.ipod.refreshPlaylists

  end

  def setMixingState(state)

    allowMixing = Pointer.new(:long)
    allowMixing[0] = state
    AudioSessionSetProperty(KAudioSessionProperty_OverrideCategoryMixWithOthers, 4, allowMixing)

  end

end