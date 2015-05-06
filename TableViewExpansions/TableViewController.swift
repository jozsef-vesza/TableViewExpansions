//
//  TableViewController.swift
//  TableViewExpansions
//
//  Created by Vesza Jozsef on 05/05/15.
//  Copyright (c) 2015 Vesza Jozsef. All rights reserved.
//

import UIKit

let mainCellIdentifier = "MainCell"
let detailCellIdentifier = "DetailsCell"

class TableViewController: UITableViewController {
    
    let viewModel = TableViewModel()
    
    var expandedIndex: NSIndexPath? {
        didSet {
            switch expandedIndex {
            case .Some(let index):
                tableView.insertRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Top)
            case .None:
                tableView.deleteRowsAtIndexPaths([oldValue!], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top = 20
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expandedIndex != nil ?
            viewModel.count() + 1 :
            viewModel.count()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        switch expandedIndex {
            
        case .Some(let index) where index.row == indexPath.row:
            cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier) as! UITableViewCell
            cell.textLabel?.text = viewModel.detailsForIndex(index.row - 1)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
        case .Some(let index) where index.row < indexPath.row:
            cell = tableView.dequeueReusableCellWithIdentifier(mainCellIdentifier) as! UITableViewCell
            cell.textLabel?.text = viewModel.itemForIndex(indexPath.row - 1)
            
        default:
            cell = tableView.dequeueReusableCellWithIdentifier(mainCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = viewModel.itemForIndex(indexPath.row)
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch expandedIndex {
        case .None:
            expandedIndex = NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)
            
        case .Some(let index) where index.row == indexPath.row:
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            
        case .Some(let index) where index.row == indexPath.row + 1:
            expandedIndex = nil
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            
        case .Some(let index) where index.row < indexPath.row:
            expandedIndex = nil
            self.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: max(0,indexPath.row - 1), inSection: indexPath.section))
        default:
            expandedIndex = nil
            expandedIndex = NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)
        }
    }
}
