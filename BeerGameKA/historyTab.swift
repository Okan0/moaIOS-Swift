//
//  historyTab.swift
//  BeerGameKA
//
//  Created by John on 14.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit
class myHistoryCell : UITableViewCell{

    @IBOutlet weak var woche: UILabel!
}

class historyView : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var historyTableView: UITableView!
    var weeks:[String] = []
    var currentWeek : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeek = 20
        for var index = 1; index < 20; index++ {
            weeks.append("Woche \(index)")
        }
    }
    
    //Wird fuer die TableView benoetigt
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Anzahl der Elemente in der TableView
        return weeks.count
    }
    
    //Diese Funktion füllt die Tabelle mit "Leben"
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.historyTableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! myHistoryCell
        cell.woche.text = "Eine Woche"
        
        return cell
    }
    
    //Diese Funktion wird ausgeführt, wenn ein Element in der Tabelle ausgewählt wird
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //TODO andere View aufrufen und die benötigten Parameter übergeben
    }

}
