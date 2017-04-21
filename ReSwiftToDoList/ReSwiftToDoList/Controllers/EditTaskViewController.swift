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
import RxCocoa
import Action
import NSObject_Rx
import ReSwift

class EditTaskViewController: UIViewController{

    @IBOutlet var titleView: UITextView!
    @IBOutlet var okButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    
    var todo : ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.subscribe(self)
        
        titleView.text = todo?.title
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidLoad()
        store.unsubscribe(self)
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        guard let title = titleView.text, title.utf16.count > 0 else {
            return
        }
        
        let newTodo = ToDo(title:titleView.text)
        
        if let todo = self.todo{
            guard let toDoID = ToDoID(identifier: todo.toDoID.identifier)
                else { preconditionFailure("Invalid To-Do item identifier \(todo.toDoID.identifier).") }
            store.dispatch(ToDoAction.rename(toDoID, title: titleView.text))
        }else{
           store.dispatch(AddTaskAction(toDo: newTodo))
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelTask(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleView.becomeFirstResponder()
    }
}

extension EditTaskViewController : StoreSubscriber{
    func newState(state: ToDoListState) {
        
        
    }
}
