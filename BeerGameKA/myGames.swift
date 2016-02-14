//
//  myGames.swift
//  BeerGameKA
//
//  Created by John on 10.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit

struct myGame{
    var id:String
    var name:String
    var role:String
    var state:Int
}

class myGames : UIViewController, UITableViewDataSource, UITableViewDelegate {
    var token = String()
    var host = String()
    
    @IBOutlet weak var myGamesTableView: UITableView!
    private var games :[myGame] = []
    
    var gameId = String()
    
    //Diese Funktion wird beim laden der View aufgerufen
    override func viewDidLoad() {
        super.viewDidLoad()
        myGamesTableView.delegate = self
        myGamesTableView.dataSource = self
        
        //TODO meine Spiele aus der Datenbank holen und das Array füllen
        
        games.append(myGame(id: "1", name: "Mein Spiel", role: "Distributor", state: 1))
        games.append(myGame(id: "2", name: "Mein zweites Spiel", role: "Wholesaler", state: 2))
        games.append(myGame(id: "3", name: "Mein nächstes Spiel", role: "Distributor", state: 3))
        games.append(myGame(id: "4", name: "Mein letztes Spiel", role: "Distributor", state: 0))
    }
    
    //Diese Funktion wird ausgeführt, wenn eine andere View aufgerufen werden soll und...
    //...die Überprüfung erfolgreich war.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "waitForPlayerSegue") {
            let temp = segue.destinationViewController as! wait4Player
            temp.host = host
            temp.token = token
            temp.gameId = gameId
        }
        else if(segue.identifier == "gameIsFullSegue"){
//            let temp = segue.destinationViewController as! Playsheet
//            temp.host = host
//            temp.token = token
//            temp.gameId = gameId
        }
    }
    
    //Wird fuer die TableView benoetigt
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Anzahl der Elemente in der TableView
        return games.count
    }
    
    //Diese Funktion füllt die Tabelle mit "Leben"
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.myGamesTableView.dequeueReusableCellWithIdentifier("gamesCell",forIndexPath: indexPath) as! myGamesCell
        
        cell.gameName.text = games[indexPath.row].name
        cell.gameRole.text = games[indexPath.row].role
        
        if games[indexPath.row].state == 1{
            cell.backgroundColor = UIColor.orangeColor()
        }
        else if games[indexPath.row].state == 2{
            cell.backgroundColor = UIColor.greenColor()
        }
        else if games[indexPath.row].state == 3{
            cell.backgroundColor = UIColor.redColor()
        }
        
        return cell
    }
    
    //Diese Funktion wird ausgeführt, wenn ein Element in der Tabelle ausgewählt wird
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        gameId = games[indexPath.row].id
        if games[indexPath.row].state == 0 {
            self.performSegueWithIdentifier("waitForPlayerSegue", sender: self)
        }
        else{
            self.performSegueWithIdentifier("gameIsFullSegue", sender: self)
        }
    }

}
