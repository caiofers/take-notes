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
        
        let orderByData = NSSortDescriptor(key: "date", ascending: false)
        
        request.sortDescriptors = [orderByData]
        
        do {
            let notesResult = try context.fetch(request)
            listOfNotes = notesResult as! [NSManagedObject]
        } catch let error {
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
        let text = note.value(forKey: "text")
        let date = note.value(forKey: "date")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy - hh:mm"
        
        cell.textLabel?.text = text as? String
        cell.detailTextLabel?.text = dateFormatter.string(from: date as! Date)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let note = listOfNotes[indexPath.row]
        
        performSegue(withIdentifier: "seeNote", sender: note)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeNote" {
            let destinyView = segue.destination as! TextViewController
            destinyView.note = sender as? NSManagedObject
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = listOfNotes[indexPath.row]
            
            context.delete(note)
            listOfNotes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try context.save()
                print("Deleted!")
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}

