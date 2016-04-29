
//
//  FitController.swift
//  FitNote
//
//  Created by Gary Ghayrat on 4/14/16.
//  Copyright © 2016 FitPeople. All rights reserved.
//

import UIKit

class FitController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dailyAveg: UIImageView!
    @IBOutlet weak var daysCount: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var activitiesPicker: UIPickerView!
    @IBOutlet weak var secondPicker: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    
    var pickerData: [[String]] = [[String]]()
    var secondPickerData: [[String]] = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.activitiesPicker.delegate = self
        self.activitiesPicker.dataSource = self
        
        self.secondPicker.delegate = self
        self.secondPicker.dataSource = self
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        // Input data into the Array:
        pickerData = [["Swimming", "Running", "Exercising", "Lifting", "Sleeping"]]
        secondPickerData = [["1", "2", "3", "4", "5", "6", "7", "8"],
                            [",", ":", ";"],
                            ["8", "9", "10", "11", "12"]]
    }
//   [",", ":", ";"],
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == self.activitiesPicker {
            return 1
        }
        else {
        return 3
        }
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
  //      return 5
  //      return pickerData.count
        if pickerView == self.activitiesPicker {
        return pickerData[component].count
        }
        else {
        return secondPickerData[component].count
        }
    }
    
//    func rowSizeForComponent(0, component: Int) -> CGSize
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.activitiesPicker {
        return pickerData[component][row]
        }
        else {
        return secondPickerData[component][row]
        }
    }
    
    // Catpure the picker view selection
    
    var first: String = "Exercise"
    var secondfirst: Int = 0
    var secondsecond: String = ":"
    var secondsecondsecond: String = "secs"
    var secondthird: Int = 0
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if pickerView == self.activitiesPicker {
            switch row {
            case 0 : first = "Swimming"
            case 1 : first = "Running"
            case 2 : first = "Exercising"
            case 3 : first = "Lifting"
            case 4 : first = "Sleeping"
            default : first = "Exercising"
            }
        }
        else {
            if component == 0 {
                secondfirst = row
            }
            else if component == 1 {
                switch row {
                case 0 : secondsecond = "sets"
                secondsecondsecond = "times"
                case 1 : secondsecond = "hours"
                secondsecondsecond = "minutes"
                case 2 : secondsecond = ";"
                default : secondsecond = "-"
                }
            }
            else {
                secondthird = row
            }
        }
/*        if pickerView == self.activitiesPicker {
            print("1-" + "\(component)" + "\(row)")
        }
        else {
            print("2-" + "\(component)" + "\(row)")
        }
*/
    }

    //T         A           B           L           E       View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
            //Data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell", forIndexPath: indexPath)
        cell.textLabel!.text = first + "\(secondfirst+1)" + secondsecond + "\(secondthird+8)" + secondsecondsecond
        print("row \(indexPath.row)")
        return cell
    }
    var Data: [[String]] = [[String]]()
    var dataCount : Int = 0
    
    
    
    //Submit button
    @IBAction func submitPressed(sender: AnyObject) {
        print(first + " \(secondfirst+1) " + secondsecond + " \(secondthird+8) " + secondsecondsecond)
        Data.insert([first," \(secondfirst+1)", secondsecond, "\(secondthird+8)"], atIndex: dataCount)
        
        print(Data[dataCount][0])
        dataCount += 1
       // self.tableView.reloadData()
        
//        tableView.cell.textLabel!.text = first + "\(secondfirst+1)" + secondsecond + "\(secondthird+8)" + secondsecondsecond
    }
/*    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleData = pickerData[row]
        let myTitle = NSAttributedString([String]: titleData, attributes: [NSForegroundFontAttributeName: UIColor.redColor()])
        
        return myTitle
    }
*/
    
/*    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView
    {
        var pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.text = "1"
        // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 12) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
*/

}
