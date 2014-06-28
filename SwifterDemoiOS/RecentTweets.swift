import UIKit
import SwifteriOS

// RecentTweets inherits from UIViewController and implements the UITableViewDelegate and UITableViewDataSource protocols
class RecentTweets: UIViewController, UITableViewDelegate, UITableViewDataSource
{
  // Not sure if this should be cast as JSONValue or what now?!
  var stream : JSONValue[] = []
  
  // You ctrl+dragged this outlet in from your storyboard right?
  @IBOutlet var tableView : UITableView
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
  // As defined in the protocol, we need to provide the number of rows in this table
  func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
  {
    // If stream is JSON type, i lose the ability to count items
    return stream.count
  }
  
  // Another protocol method, allowing us to control the data created in each cell
  // Note that UITableView has a ! at the end
  func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
  {
    // Grab the data in the recentTweets array based on the index of the cell
    // Tell the program what type of data it is so that we can drill into this generic object
    let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
    
    cell.textLabel.text = stream[indexPath.row]["text"].string
    
    return cell
  }
}