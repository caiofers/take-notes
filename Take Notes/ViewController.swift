//
//  ViewController.swift
//  Take Notes
//
//  Created by Caio Fernandes on 31/03/21.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    var listOfNotes: [NSManagedObject] = []
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }

    
    func getNotes() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        do {
            let notesResult = try context.fetch(request)
            listOfNotes = notesResult as! [NSManagedObject]
        } catch let error as Error {
            print("Error: \(error.localizedDescription)")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getNotes()
        tableView.reloadData()
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
    
        let note = listOfNotes[indexPath.row]
        cell.textLabel?.text = note.value(forKey: "text") as! String
        
        return cell
    }
    

}

