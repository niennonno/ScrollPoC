//
//  ViewController.swift
//  ScrollPoC
//
//  Created by Aditya Vikram Godawat on 1/17/18.
//  Copyright © 2018 Aditya Vikram Godawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var headerView = DoubtsTableViewHeaderView()
    var tableHeaderHeight: CGFloat = 150
    var headerMaskLayer: CAShapeLayer!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        headerView = Bundle.main.loadNibNamed("DoubtsTableViewHeaderView", owner: nil, options: nil)?.first as! DoubtsTableViewHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
        headerView.awakeFromNib()
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        
        headerView = tableView.tableHeaderView as! DoubtsTableViewHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.bringSubview(toFront: headerView)
        
        tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        updateHeaderView()
        
//        headerMaskLayer = CAShapeLayer()
//        headerMaskLayer.fillColor = UIColor.clear.cgColor
//        headerView.layer.mask = headerMaskLayer
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -tableHeaderHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        
        headerRect.origin.y = tableView.contentOffset.y
        headerRect.size.height = -tableView.contentOffset.y
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height))
        headerMaskLayer?.path = path.cgPath
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 19
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Previous Doubts"
        } else {
            cell.textLabel?.text = "\(indexPath.row)"
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}
