//
//  joinGame.swift
//  BeerGameKA
//
//  Created by John on 10.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit

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
    
    //Diese Funktion wird beim laden der View aufgerufen
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO alle offenen Spiele holen
        gamesTableView.delegate = self
        games.append(showGame(id: "1", name: "Ein Spiel", count: "1"))
        games.append(showGame(id: "2", name: "Ein weiteres Spiel", count: "3"))
        games.append(showGame(id: "3", name: "Ein neues Spiel", count: "2"))
        games.append(showGame(id: "4", name: "Ein letztes Spiel", count: "2"))
        gamesTableView.dataSource = self
    }
    
    //Diese Funktion wird ausgeführt, wenn eine andere View aufgerufen werden soll und...
    //...die Überprüfung erfolgreich war.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "chooseRoleSegue") {
            let temp = segue.destinationViewController as! chooseRoleView
            temp.host = host
            temp.token = token
            temp.gameID = gameId
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
