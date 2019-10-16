//
//  ViewController.swift
//  twoTableViews
//
//  Created by apcs2 on 8/23/17.
//  Copyright © 2017 apcs2. All rights reserved.

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var secondTableView: UITableView!
    var selectedTop = [SelectedToppings]()
    var top = [Toppings]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        firstTableView.allowsSelection = true
        let firstTop = Toppings(t: "Cheese")
        let secondTop = Toppings(t: "Spinach")
        let thirdTop = Toppings(t: "Mushroom")
        let fourthTop = Toppings(t: "Peperoni")
        top.append(firstTop)
        top.append(secondTop)
        top.append(thirdTop)
        top.append(fourthTop)
        let firstSelected = SelectedToppings(s: "\(top)")
        selectedTop.append(firstSelected)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var count:Int?
        
        if tableView == self.firstTableView
        {
            count = top.count
        }
        
        if tableView == self.secondTableView
        {
            count =  selectedTop.count
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell!
        if tableView == self.firstTableView
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath)
            cell!.textLabel!.text = top[indexPath.row].topping
        }
        
        else if tableView == self.secondTableView
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath)
            cell!.textLabel!.text = selectedTop[indexPath.row].selected
        }
        
        if cell!.isSelected == true
        {
            selectedTop[indexPath.row].selected.append(top[indexPath.row].topping)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        selectedTop[indexPath.row].selected.append(top[indexPath.row].topping)
        secondTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            selectedTop.remove(at: indexPath.row)
            secondTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath)
    {
        let itemToMove = selectedTop[fromIndexPath.row]
        selectedTop.remove(at: fromIndexPath.row)
        selectedTop.insert(itemToMove, at: toIndexPath.row)
        secondTableView.reloadData()
    }

    @IBAction func editBarButton(_ sender: UIBarButtonItem)
    {
        if sender.tag == 0
        {
            secondTableView.isEditing = true
            sender.tag = 1
        }
        else
        {
            secondTableView.isEditing = false
            sender.tag = 0
        }
    }
    
}
//        tableView.allowsMultipleSelection = true
//        let firstCell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath)
//        let secondCell = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath)
//        firstCell.textLabel?.text = toppings[indexPath.row]
//        secondCell.textLabel?.text = selectedTop[indexPath.row]
//        return firstCell
