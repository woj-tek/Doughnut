//
//  SubscribeViewController.swift
//  Doughnut
//
//  Created by Chris Dyer on 15/10/2017.
//  Copyright © 2017 Chris Dyer. All rights reserved.
//

import Cocoa

class SubscribeViewController: NSViewController, NSTextFieldDelegate {
  let reducedHeight: CGFloat = 120.0
  var initialHeight: CGFloat = 0
  
  @IBOutlet weak var urlTxt: NSTextField!
  @IBOutlet weak var loadingIndicator: NSProgressIndicator!
  
  @IBOutlet weak var imageView: NSImageView!
  @IBOutlet weak var feedTitleTxt: NSTextField!
  @IBOutlet weak var feedDescriptionTxt: NSTextField!
  
  @IBOutlet weak var loadBtn: NSButton!
  @IBOutlet weak var cancelBtn: NSButton!
  @IBOutlet weak var subscribeBtn: NSButton!
  
  override func viewDidLoad() {
    initialHeight = view.frame.height
    
    preferredContentSize = CGSize(width: view.frame.size.width, height: reducedHeight)
    
    loadingIndicator.stopAnimation(self)
    
    imageView.isHidden = true
    feedTitleTxt.isHidden = true
    feedDescriptionTxt.isHidden = true
    subscribeBtn.isHidden = true
    
    // Check pasteboard for feed
    if let pastedUrl = NSPasteboard.general.string(forType: .string) {
      if pastedUrl.starts(with: "http") {
        urlTxt.stringValue = pastedUrl
        loadFeed(self)
      }
    }
  }
  
  @IBAction func loadFeed(_ sender: Any) {
    loadBtn.isEnabled = false
    loadingIndicator.startAnimation(self)
    
    
  }
  
  @IBAction func subscribe(_ sender: Any) {
  }
  
  func expand() {
    loadBtn.isHidden = true
    cancelBtn.isHidden = true
    
    imageView.isHidden = false
    feedTitleTxt.isHidden = false
    feedDescriptionTxt.isHidden = false
    subscribeBtn.isHidden = false
    
    preferredContentSize = CGSize(width: view.frame.size.width, height: initialHeight)
  }
  
  override func controlTextDidChange(_ obj: Notification) {
    if urlTxt.stringValue.starts(with: "http") && urlTxt.stringValue.contains(".") {
      loadBtn.isEnabled = true
    } else {
      loadBtn.isEnabled = false
    }
  }
}
