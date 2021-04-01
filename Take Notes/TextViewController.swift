//
//  TextViewController.swift
//  Take Notes
//
//  Created by Caio Fernandes on 31/03/21.
//

import UIKit
import CoreData

class TextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var context: NSManagedObjectContext!
    var note: NSManagedObject!
    
    @IBAction func saveText(_ sender: Any) {
        if note != nil {
            updateNote()
        } else {
            saveNote()
        }
        
        // Retorna para tela anterior
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init Setup
        textView.becomeFirstResponder()
        
        if note != nil {
            if let text = note.value(forKey: "text") {
                textView.text = text as? String
            }
        } else {
            textView.text = ""
        }
        
        

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    func saveNote() {
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context)
        
        newNote.setValue(textView.text, forKey: "text")
        newNote.setValue(Date(), forKey: "date")
        
        do {
            try context.save()
            print("Saved!")
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func updateNote() {
        note.setValue(textView.text, forKey: "text")
        note.setValue(Date(), forKey: "date")
        
        do {
            try context.save()
            print("Saved!")
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }

}
