//
//  FirstViewController.m
//  MusicPlayer
//
//  Created by atsushi.ito on 2014/06/10.
//  Copyright (c) 2014年 atsushi.ito. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
{
    MPMusicPlayerController *player;
}
@end

@implementation FirstViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"FirstViewController");
	// Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor = [UIColor grayColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
 
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,100)];
    label.center   = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    label.text     = @"First";
    label.font     = [UIFont fontWithName:@"Optima" size:20.0f];
    label.textAlignment = NSTextAlignmentCenter;
    //label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label];
    
    
    
    // add
    UILabel* label_sub = [[UILabel alloc] initWithFrame:CGRectMake(0,0,200,100)];
    label_sub.center   = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-40.0f);
    label_sub.text     = @"Sub";
    label_sub.font     = [UIFont fontWithName:@"Optima" size:16.0f];
    label_sub.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview:label_sub];
    

    // add
    if(_persistentId){
        NSLog(@"player");
        
        label.text = _song_name;
        label_sub.text = _singer_name;
        
        
        
        MPMediaQuery *songQuery = [MPMediaQuery songsQuery];
        MPMediaPropertyPredicate *predicate = [MPMediaPropertyPredicate predicateWithValue:_persistentId forProperty:MPMediaItemPropertyPersistentID];
        [songQuery addFilterPredicate:predicate];
        player = [MPMusicPlayerController applicationMusicPlayer];
        [player setQueueWithQuery:songQuery];
        [player play];
        
        
        UIButton *_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _button.frame = CGRectMake(0,0,120,40);
        _button.center   = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2+80.0f);
        [_button setTitle:@"stop" forState:UIControlStateNormal];
        _button.layer.borderColor = [UIColor grayColor].CGColor;
        _button.layer.borderWidth = 1.0f;
        _button.layer.cornerRadius = 7.5f;
        
    
        //アクション追加
        [_button addTarget:self action:@selector(playStop:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_button];
    }
}

-(void)playStop:(UIButton *)sender{
    [player stop];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
