//
//  TableDataSource.swift
//  BetterMVC
//
//  Created by Joohee Kim on 2023/01/09.
//

import UIKit

final class TableDataSource: NSObject {
    
    var itemName = Array(repeating: "", count: 20)
    
    init(tableView: UITableView) {
        let nib = UINib(nibName: "SimpleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SimpleTableViewCell")
    }
}

extension TableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleTableViewCell", for: indexPath) as? SimpleTableViewCell else {
            fatalError("Failed to dequeue SimpleTableViewCell")
        }
        cell.titleLabel.text = "\(indexPath.row + 1)번 Cell"
        cell.selectionStyle = .blue
        return cell
    }
    
}

extension TableDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .insert
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            print("delete")
            self.itemName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else {
            print("insert")
            self.itemName.insert(self.itemName[indexPath.row], at: indexPath.row + 1)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let targetItem: String = self.itemName[sourceIndexPath.row]
        self.itemName.remove(at: sourceIndexPath.row)
        self.itemName.insert(targetItem, at: destinationIndexPath.row)
    }
}

extension TableDataSource: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        [UIDragItem(itemProvider: NSItemProvider())]
    }
}

extension TableDataSource: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        //
    }
}
