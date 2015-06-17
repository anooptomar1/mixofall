//
//  ControlsTableViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/15/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ControlsTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var contentGravityLabel: UILabel!
    @IBOutlet weak var gravityPicker: UIPickerView!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var colors: [UILabel]!
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet weak var borderColorPanel: UIView!

    enum Row: Int{
        case ContentsGravity, ContentsGravityPicker, DisplayContents, GeometryFlipped, Hidden, Opacity, CornerRadius, BorderWidth, BorderColor, BorderColorPanel,BackgroundColor, ShadowOpacity, ShadowOffset, ShadowRadius, ShadowColor, MagnificationFilter
    }
    
    enum Switch: Int{
        case DisplayContents, GeometryFlipped, Hidden
    }
    
    enum Slider: Int{
        case Opacity, CornerRadius, BorderWidth
    }
    
    enum ColorSlider: Int{
        case Red, Blue, Green
    }
    
    var contentsGravityValues = [kCAGravityCenter, kCAGravityTop, kCAGravityBottom, kCAGravityLeft, kCAGravityRight, kCAGravityTopLeft, kCAGravityTopRight, kCAGravityBottomLeft, kCAGravityBottomRight, kCAGravityResize, kCAGravityResizeAspect, kCAGravityResizeAspectFill] as NSArray
    
    var calVC: CALViewController?
    var contentGravityPickerVisible = false
    var borderColorPanelVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gravityPicker.dataSource = self
        gravityPicker!.delegate = self
        relayoutTableView()
    }
    
    @IBAction func onSwitch(sender: UISwitch) {
        let theSwitch = Switch(rawValue: (switches as NSArray).indexOfObject(sender))!
        
        switch theSwitch{
        case Switch.DisplayContents:
            calVC!.layer.contents = sender.on ? calVC!.star : nil
            
        case Switch.GeometryFlipped:
            calVC!.layer.geometryFlipped = sender.on
            
        case Switch.Hidden:
            calVC!.layer.hidden = sender.on
            
        default: break
        }
    }
    
    @IBAction func onSlide(sender: UISlider){
        let theSlider = Slider(rawValue: (sliders as NSArray).indexOfObject(sender))!
        
        switch theSlider{
        case Slider.Opacity:
            calVC?.layer.opacity = sender.value
        
        case Slider.CornerRadius:
            calVC?.layer.cornerRadius = CGFloat(sender.value)
            
        case Slider.BorderWidth:
            calVC?.layer.borderWidth = CGFloat(sender.value)
        default: break
        }
    }
    
    @IBAction func onColorSlide(sender: UISlider){
        let red = CGFloat(colorSliders[0].value)
        let blue = CGFloat(colorSliders[1].value)
        let green = CGFloat(colorSliders[2].value)
        colors[0].text = String(format: "R: %.0f", red)
        colors[2].text = String(format: "G: %.0f", green)
        colors[1].text = String(format: "B: %.0f", blue)
        calVC?.layer.borderColor = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).CGColor
    }
    
    func showContentGravityPicker(){
        contentGravityPickerVisible = true
        relayoutTableView()
        let index = contentsGravityValues.indexOfObject(calVC!.layer.contentsGravity)
        gravityPicker.selectRow(index, inComponent: 0, animated: false)
        gravityPicker.hidden = false
        gravityPicker.alpha = 0.0
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.gravityPicker.alpha = 1.0
        })
    }

    func hideContentGravityPicker(){
        if contentGravityPickerVisible{
            tableView.userInteractionEnabled = false
            contentGravityPickerVisible = false
            relayoutTableView()
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.gravityPicker.alpha = 0.0
            }, completion: { (finished Bool) -> Void in
                self.gravityPicker.hidden = true
                self.tableView.userInteractionEnabled = true
            })
        }
    }
    
    func toggleColorPanel(){
        if borderColorPanelVisible{
            tableView.userInteractionEnabled = false
            borderColorPanelVisible = false
            relayoutTableView()
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.borderColorPanel.alpha = 0.0
            }, completion: { (
                finished Bool) -> Void in
                self.borderColorPanel.hidden = true
                self.tableView.userInteractionEnabled = true
            })
        }else{
            borderColorPanelVisible = true
            relayoutTableView()
            let borderColorComponents = CGColorGetComponents(calVC?.layer.borderColor)
            let red = ceil(borderColorComponents[0]*255)
            let green = ceil(borderColorComponents[1]*255)
            let blue = ceil(borderColorComponents[2]*255)
            
            colors[0].text = "R: \(red)"
            colors[2].text = "G: \(green)"
            colors[1].text = "B: \(blue)"
            
            colorSliders[0].value = Float(red)
            colorSliders[2].value = Float(green)
            colorSliders[1].value = Float(blue)
            
            borderColorPanel.hidden = false
            borderColorPanel.alpha = 0.0
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.borderColorPanel.alpha = 1.0
                self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: Row.BorderColorPanel.rawValue, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            })
        }
    }
    
    func updateGravityPickerLabel(){
        contentGravityLabel.text = calVC!.layer.contentsGravity as String
    }
    
    func relayoutTableView(){
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = Row(rawValue: indexPath.row)!
        if row == Row.ContentsGravityPicker{
            return contentGravityPickerVisible ? 162.0 : 0.0
        }else if row == Row.BorderColorPanel {
            return borderColorPanelVisible ? 162.0 : 0.0
        }else{
            return 44.0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = Row(rawValue: indexPath.row)!
        switch(row){
        case Row.ContentsGravity where !contentGravityPickerVisible:
            showContentGravityPicker()
        case Row.BorderColor:
            toggleColorPanel()
        default:
            hideContentGravityPicker()
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contentsGravityValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return contentsGravityValues[row] as! String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        calVC!.layer.contentsGravity = contentsGravityValues[row] as! String
        updateGravityPickerLabel()
    }

}
