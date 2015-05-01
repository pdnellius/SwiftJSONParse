//
//  TableViewController.swift
//  JSONParsing
//
//  Created by Pete Nellius on 4/30/15.
//  Copyright (c) 2015 Pete Nellius. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var authorList:[String] = []
    var titles:[String] = []
    var links:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let session = NSURLSession.sharedSession()
        

        
        if let url = NSURL(string: "http://www.mashable.com/stories.json") {
            var completionHandler: (NSData!, NSURLResponse!, NSError!) -> Void = { (data, response, error) -> Void in
                
                
                var stringOfData = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                var error:NSError?
                
                var object = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error) as! [String:AnyObject]
                var newObject = object["new"] as! [[String:AnyObject]]
                
                for objectj in newObject {
                    self.authorList.append(String(stringInterpolationSegment: objectj["author"]!)
                    )
                    self.titles.append(String(stringInterpolationSegment: (objectj["title"]!)))
                    self.links.append(String(stringInterpolationSegment: (objectj["link"]!)))
                    
                }
                println(self.authorList)
                println(self.titles)
                println(self.links)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
                

                
            }
            

            
            let task = session.dataTaskWithURL(url, completionHandler: completionHandler)
            
            task.resume()
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return authorList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = authorList[indexPath.row]
        
        

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "webViewSegue") {
            var webView = segue.destinationViewController as! ViewController
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPathForCell(cell){
                let url = links[indexPath.row]
                webView.url = url
            }
            
        }
    }

}
