//
//  ViewController.swift
//  BucketList
//
//  Created by Raquel Domingo on 9/12/17.
//  Copyright © 2017 Raquel Domingo. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate{

    var items = ["Go to the moon", "Eat a candy bar", "Swin in the Amazon", "Ride a motorbike in Tokyo"]
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected")
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let addItemTableController = navigationController.topViewController as! AddItemTableViewController
            addItemTableController.delegate = self

        if segue.identifier == "EditItemSegue" {
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableController.item = item
            addItemTableController.indexPath = indexPath
        }
    }
    
    
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        print("I'm the hidden controller, BUT I am responding to the cancel button press on the top view controller")
        dismiss(animated: true, completion: nil)
    }
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        
        if let ip = indexPath{
            
            items[ip.row] = text
            
        }else {
            
            items.append(text)
            
        }
        
        tableView.reloadData()
        print("Received text from top view: \(text)")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

