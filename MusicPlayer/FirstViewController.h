//
//  FirstViewController.h
//  MusicPlayer
//
//  Created by atsushi.ito on 2014/06/10.
//  Copyright (c) 2014年 atsushi.ito. All rights reserved.
//

#import <UIKit/UIKit.h>

// mediaplayerをインクルードします
#import <MediaPlayer/MediaPlayer.h>

@interface FirstViewController : UIViewController


// 06/25: 楽曲情報の値を受け取る assign/strongは省略します
@property (nonatomic) NSNumber *persistentId;
@property (nonatomic) NSString *singer_name;
@property (nonatomic) NSString *song_name;

@end
    