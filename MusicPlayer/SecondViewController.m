//
//  SecondViewController.m
//  MusicPlayer
//
//  Created by atsushi.ito on 2014/06/10.
//  Copyright (c) 2014年 atsushi.ito. All rights reserved.
//

#import "SecondViewController.h"

// 06/25 : 値を渡して画面遷移します
#import "FirstViewController.h"

// クラス拡張 ※ カテゴリ名のない記述形式
@interface SecondViewController (){
    UITableView *tbl_view;
    NSArray *musician;
    int list_count;
    
    
    // 06/25 : サウンドリストの変数をセットします
    NSMutableArray          *sectionPlayList;
    NSMutableArray          *sectionSongs;
    NSMutableDictionary     *playListSongs;
}
@end

@implementation SecondViewController

/*
 (1)必ず一つの指定イニシャライザを持つ(基本的に複数はナシ)
 (2)指定イニシャライザ以外のイニシャライザは、必ず指定イニシャライザ経由で初期化する
 (3)親クラスの指定イニシャライザは必ずオーバーライドする
 */
- (id)init
{
    if (self = [super init]) {

    }

    // plistのファイルパスを取得
    /*
    NSString* path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"];
    musician = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@",musician);

    list_count = musician.count;
    NSLog(@"%@", musician);
    */
    
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    NSLog(@"SecondViewController");
	

    /*
    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,200,100)];
    label.center   = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    label.text     = @"Second";
    label.font     = [UIFont fontWithName:@"Optima" size:24.0f];
    label.textAlignment = NSTextAlignmentCenter;
    //label.backgroundColor = [UIColor greenColor];

    [self.view addSubview:label];
    */
    
    // table view
    tbl_view = [[UITableView alloc] initWithFrame:[self.view bounds]];
    tbl_view.delegate = self;
    tbl_view.dataSource = self;
    tbl_view.rowHeight  = 80;//セルのサイズ設定します 06/25
    
    /* セルの色設定 */
    //tbl_view.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:1.0];

    [self.view addSubview:tbl_view];
    
    
    // ---------------
    //各セクション名と曲名用の配列の初期化
    sectionPlayList = @[].mutableCopy;
    playListSongs   = @{}.mutableCopy;
    
    //iPodの音楽ライブラリから取得
    MPMediaQuery *myPlaylistsQuery = [MPMediaQuery playlistsQuery];
    NSArray *playlists = [myPlaylistsQuery collections];
    NSLog(@"%@", playlists);
    
    for (MPMediaPlaylist *playlist in playlists) {
        
        //section名を配列にセット
        [sectionPlayList addObject:[playlist valueForProperty: MPMediaPlaylistPropertyName]];
        
        //各sectionにぶらさがる曲名用の配列を初期化
        sectionSongs  = @[].mutableCopy;
        
        for (MPMediaItem *song in [playlist items]) {
            
            //曲情報を配列にセット(曲ID、曲名、アーティスト名、アルバム名)
            NSArray* cellDataArray = [[NSArray alloc]init];
            cellDataArray = [NSArray arrayWithObjects:
                              [song valueForProperty: MPMediaItemPropertyPersistentID]
                             ,[song valueForProperty: MPMediaItemPropertyTitle]
                             ,[song valueForProperty: MPMediaItemPropertyArtist]
                             ,[song valueForProperty: MPMediaItemPropertyAlbumTitle]
                             ,nil];
            
            [sectionSongs addObject:cellDataArray];
            
        }
        
        //1section分のデータができたので、全体テーブル用の配列にセット
        [playListSongs setObject:sectionSongs forKey:[playlist valueForProperty: MPMediaPlaylistPropertyName]];
        
    }
}

//テーブルに含まれるセクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return 1;
    // replace
    return [sectionPlayList count];
}

// section毎
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    return [sectionPlayList objectAtIndex:section];
}

//セクションに含まれる行の数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return list_count;
    
    // replace
    id key = [sectionPlayList objectAtIndex:section];
    return [[playListSongs objectForKey:key]count];
}

//行に表示するデータの生成
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //　UITableViewCellStyleSubtitle　に変更する
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    /*
    cell.textLabel.text = [NSString stringWithFormat:@"%@",  [[musician objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    // ここでも色設定必要
    cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:1.0];
    
    */
    
    //セルにデータの割り当て
    // 楽曲名
    cell.textLabel.text =
    [[[playListSongs objectForKey:[sectionPlayList objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row]objectAtIndex:1];
    
    // アーティスト名
    cell.detailTextLabel.text =
    [[[playListSongs objectForKey:[sectionPlayList objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row]objectAtIndex:2];
    
    return cell;
}

// セルが選択された場合の処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* replcae
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除をします。
    
    NSLog(@"selected : %d", indexPath.row);

    // indexの値を元にplistのディクショナリより情報を取得する
    NSString *name = [[musician objectAtIndex:indexPath.row] objectForKey:@"name"];
    NSString *info = [[musician objectAtIndex:indexPath.row] objectForKey:@"info"];
    
    // アラートウィンドウを表示する
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:name message:info
                          delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    */
    
    
    //選択された曲を検索条件に指定
    NSNumber *persistentId = [[[playListSongs objectForKey:[sectionPlayList objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row]objectAtIndex:0];

    NSString *singerName =
    [[[playListSongs objectForKey:[sectionPlayList objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row]objectAtIndex:2];

    NSString *songName =
    [[[playListSongs objectForKey:[sectionPlayList objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row]objectAtIndex:1];
    
    
    FirstViewController *fvc = FirstViewController.new;
    fvc.persistentId = persistentId;
    fvc.singer_name = singerName;
    fvc.song_name = songName;
    
    [[self navigationController] pushViewController:fvc animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
