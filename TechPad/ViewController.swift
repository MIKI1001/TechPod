//
//  ViewController.swift
//  TechPad
//
//  Created by 篠田弥樹 on 2015/10/04.
//  Copyright (c) 2015年 篠田弥樹. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var table: UITableView!
    
    //曲名を入れるための配列
    var songNameArray = [String]()
    //曲のファイル名を入れるための配列
    var fileNameArray = [String]()
    //音楽家の画像名を入れるための配列
    var imageNameArray = [String]()
    //音楽を再生させるための変数
    var audioPlayer: AVAudioPlayer!
    var currentSong: Int!
    
    @IBOutlet var songTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.dataSource = self
        
        //UITableViewが持っているデリゲードメゾットの処理の委託先をViewController.swiftに設定
        table.delegate = self
        
        //songNameArrayに曲名を入れていく
        songNameArray = ["カノン","エリーゼのために","G線上のアリア"]
        
        //fileNameArrayに曲のファイルを入れていく
        fileNameArray = ["cannon","elise","aria"]
        
        //imageArrayに音楽家の画像を入れていく
        imageNameArray = ["Pachelbel.jpg","Beethoven.jpg","Bach.jpg"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セルの数を指定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songNameArray.count
    }
    
    //ID付きセルを取得して、セル付属のtextLabelに「テスト」と表示させてみる
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        cell.textLabel?.text = songNameArray[indexPath.row]
        cell.imageView?.image = UIImage(named: imageNameArray[indexPath.row])
        return cell
    }
    
    //セルが押されたときに呼ばれるデリゲートメゾット
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("%@が選ばれました", songNameArray[indexPath.row])
        
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileNameArray[indexPath.row],ofType: "mp3")!)
        audioPlayer = AVAudioPlayer(contentsOfURL: audioPath, error:nil)
        audioPlayer.prepareToPlay()
        
        audioPlayer.play()
    }
    @IBAction func stop() {
        if audioPlayer.playing == true {
            audioPlayer.pause()
        }else{
            audioPlayer.play()
        }
    }
    @IBAction func back() {
        if currentSong > 0 {
            currentSong = currentSong - 1
        }
        prepareSongWithIndexPath(NSIndexPath(forRow: currentSong, inSection: 0))
        audioPlayer.play()
        self.selectRow(NSIndexPath(forRow: currentSong, inSection: 0))
        
    }
    @IBAction func go() {
        if currentSong < songTableView.numberOfRowsInSection(0) - 1 {
            currentSong = currentSong + 1
        }
        prepareSongWithIndexPath(NSIndexPath(forRow: currentSong, inSection: 0))
        audioPlayer.play()
        self.selectRow(NSIndexPath(forRow: currentSong, inSection: 0))
    }
    


}

