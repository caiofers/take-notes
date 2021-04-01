//
//  ViewController.swift
//  Take Notes
//
//  Created by Caio Fernandes on 31/03/21.
//

import UIKit

class ViewController: UITableViewController {

    var listOfNotes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "reuseNoteCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath)
    
        cell.textLabel?.text = listOfNotes[indexPath.row]
        
        return cell
    }
    

}

