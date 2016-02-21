//
//  joinGame.swift
//  BeerGameKA
//
//  Created by John on 10.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit
import SwiftyJSON

struct showGame{
    var id:String
    var name:String
    var count:String
}

class joinGame : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var gamesTableView: UITableView!
    var token = String()
    var host = String()
    var gameId = String()
    
    var games : [showGame] = []
    
    func handler(val: AnyObject?){
        if (val != nil)
        {
            let json = JSON(val!)
            for (var i : Int = 0; i < json.count; i++ ){
                self.games.append(showGame(id: json[i, "GameId"].stringValue, name: json[i, "GameName"].stringValue, count: json[i, "PlayerCount"].stringValue))
            }
        }
        self.gamesTableView.reloadData()
    }
    
    //Diese Funktion wird beim laden der View aufgerufen
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO alle offenen Spiele holen
        gamesTableView.delegate = self
        gamesTableView.dataSource = self
        RestClient.getOpenGames(handler)
    }
    
    //Diese Funktion wird ausgeführt, wenn eine andere View aufgerufen werden soll und...
    //...die Überprüfung erfolgreich war.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "chooseRoleSegue") {
            let temp = segue.destinationViewController as! chooseRoleView
            temp.host = host
            temp.token = token
            temp.gameID = games[self.gamesTableView.indexPathForSelectedRow!.row].id
        }
    }
    
    //Wird fuer die TableView benoetigt
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Anzahl der Elemente in der TableView
        return games.count
    }
    
    //Diese Funktion füllt die Tabelle mit "Leben"
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Der Identifier "Cell" ist fuer die Prototype Cell
        let cell = self.gamesTableView.dequeueReusableCellWithIdentifier("gamesCell",forIndexPath: indexPath) as! openGameCell
        
        cell.gameName.text = games[indexPath.row].name
        cell.playerCount.text = "(\(games[indexPath.row].count)/4)"
        
        return cell
    }
    
    //Diese Funktion wird ausgeführt, wenn ein Element in der Tabelle ausgewählt wird
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        gameId = games[indexPath.row].id
    }
}
