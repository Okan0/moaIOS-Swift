//
//  MenueView.swift
//  BeerGameKA
//
//  Created by John on 10.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit

class MenueView : UIViewController {
    var host=String()
    var token=String()
    
    //Diese Funktion wird ausgeführt wenn auf einen der Buttons geklickt wird
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "MenuCreateSegue") {
            let temp = segue.destinationViewController as! createGame
            temp.host = host
            temp.token = token
        }
        else if (segue.identifier == "MenuJoinSegue") {
            let temp = segue.destinationViewController as! joinGame
            temp.host = host
            temp.token = token
        }
        else if (segue.identifier == "MenuMyGamesSegue") {
            let temp = segue.destinationViewController as! myGames
            temp.host = host
            temp.token = token
        }
    }
}