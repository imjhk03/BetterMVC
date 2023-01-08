//
//  TableViewController.swift
//  BetterMVC
//
//  Created by Joohee Kim on 2023/01/09.
//

import UIKit

final class TableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    var barButtonItem: UIBarButtonItem?
    private lazy var dataSource = TableDataSource(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        barButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = barButtonItem
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = dataSource
        tableView.dropDelegate = dataSource
    }
    
    @objc private func editTapped() {
        if tableView.isEditing {
            barButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
            navigationItem.rightBarButtonItem = barButtonItem
            tableView.setEditing(false, animated: true)
        } else {
            barButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(editTapped))
            navigationItem.rightBarButtonItem = barButtonItem
            tableView.setEditing(true, animated: true)
        }
    }
}
