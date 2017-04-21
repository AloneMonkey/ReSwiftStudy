/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import RxSwift
import RxDataSources
import Action
import NSObject_Rx
import ReSwift

class TasksViewController: UIViewController {
  
    @IBOutlet var tableView: UITableView!
    @IBOutlet var newTaskButton: UIBarButtonItem!
    
    var items = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        
        store.subscribe(self)
    }
}

extension TasksViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemCell", for: indexPath) as! TaskItemTableViewCell
        let item = items[indexPath.row]
        cell.title.text = item.title
        cell.finished = item.completion.isFinished
        cell.checkAction = {
            _ in
            let toDo = self.items[indexPath.row]
            guard let toDoID = ToDoID(identifier: toDo.toDoID.identifier)
                else { preconditionFailure("Invalid To-Do item identifier \(toDo.toDoID.identifier).") }
            let action: ToDoAction = {
                switch toDo.completion.isFinished {
                case true:  return ToDoAction.uncheck(toDoID)
                case false: return ToDoAction.check(toDoID)
                }
            }()
            
            store.dispatch(action)
        }
        return cell
    }
}

extension TasksViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = items[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditTask") as! EditTaskViewController
        vc.todo = todo
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TasksViewController : StoreSubscriber{
    func newState(state: ToDoListState) {
        
        items = state.toDoList.items
        
        tableView.reloadData()
    }
}
