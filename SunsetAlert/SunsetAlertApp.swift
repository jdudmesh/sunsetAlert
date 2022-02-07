//
//  MenuBarPopoverApp.swift
//  MenuBarPopover
//
//  Created by Zafer Arıcan on 8.07.2020.
// Modified by John Dudmesh 7/2/2022
//
// Icons from here: https://www.flaticon.com/free-icon/sunrise_1852515?term=sunset&page=1&position=3&page=1&position=3&related_id=1852515&origin=tag#

import SwiftUI

@main
struct SunsetAlertApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
      AppDelegate.shared = self.appDelegate
    }
    /*  For #2 I followed the solution in https://stackoverflow.com/a/65789202/827681 */
    var body: some Scene {
        Settings{
            EmptyView()
        }
    }
}
class AppDelegate: NSObject, NSApplicationDelegate {
    var popover = NSPopover.init()
    var statusBarItem: NSStatusItem?
    static var shared : AppDelegate!
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let contentView = ContentView()

        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.behavior = .transient
        popover.animates = false
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        popover.contentViewController?.view.window?.makeKey()
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.button?.image = #imageLiteral(resourceName: "sunrise16x16.png")
        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))
    }
    @objc func showPopover(_ sender: AnyObject?) {
        if let button = statusBarItem?.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
//            !!! - displays the popover window with an offset in x in macOS BigSur.
        }
    }
    @objc func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }
    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}