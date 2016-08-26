//
//  EntitiesTableViewController.swift
//  Pair
//
//  Created by Patrick Ridd on 8/26/16.
//  Copyright © 2016 PatrickRidd. All rights reserved.
//

import UIKit
import CoreData

class EntitiesTableViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        EntityController.sharedController.fetchedResultsController.delegate = self
        
        // Do any additional setup after loading the view.
    }

  
    @IBAction func randomizeButtonTapped(sender: AnyObject) {
        
        
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        var  nameTextField = UITextField()
        
        let alert = UIAlertController(title: "What is the 'Name' for Entity", message: nil, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "enter name..."
            nameTextField = textField
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { (_) in
            guard let name = nameTextField.text where !(name.isEmpty) else {
                return
            }
            EntityController.sharedController.addEntity(name)
            
        }
        alert.addAction(cancelAction)
        alert.addAction(submitAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let sections =  EntityController.sharedController.fetchedResultsController.sections?.count else {
            return 1
        }
        return sections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections =  EntityController.sharedController.fetchedResultsController.sections else {
            return 0
        }

        return sections[section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entityCell", forIndexPath: indexPath)
        let entity =  EntityController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath)

        cell.textLabel?.text = entity.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            guard let entity = EntityController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Entity else {
                return
            }
            
            EntityController.sharedController.deleteEntity(entity)
           // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = EntityController.sharedController.fetchedResultsController.sections else {
            return nil
        }
        
        return sections[section].name
    }
    
    
    // MARK: - NSFetchedResultsController Delegate Methods
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default: break
        }

    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
       
        switch type {
        case .Delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Update:
            guard let indexPath = indexPath else { return }
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath, newIndexPath = newIndexPath else { return }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }

        
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
