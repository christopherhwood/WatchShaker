# WatchShaker

A quick and easy shaking gesture recognizer for the Apple Watch. 

Adjust sensor sensitivity with the `kThreshold` variable:

(note: too high and the watch face will turn off while shaking, too low and it picks up accidental shakes)
```swift
// The threshold for how much acceleration needs to happen before an event will register. Can tune to your liking, although I've found 1.2 to work pretty well.
    private let kShakeThreshold = 1.2
```

You can also adjust the time delay between registering shakes with the kShakeDelay variable:
```swift
// The time between shakes (useful for not counting a shake on the way up and then again on the way back down).
    private let kShakeDelay = 0.7
```

Use as you'd like and feel free to fork or send PRs if you'd like to expand on this further.
