//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by suhyup02 on 2022/01/26.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btn1: UIButton!
    
    
    private var value11 : Int = 0
    
    var itemsToShow = [String]()
    let items = ["Saranac River", "Fort Moreau", "Oval", "Fort Brown",
    "Water Pollution Control Plant", "Fort Scott"]
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.rx.text.orEmpty.subscribe(
            onNext: { [unowned self] query in
                self.itemsToShow = self.items.filter { $0.hasPrefix(query) }
                self.tableView.reloadData()
            }, onError:{ error in
                print("\(error)")
            }, onCompleted: {

            }, onDisposed: {

            }).disposed(by: disposeBag)

        btn1.rx.tap.bind { [weak self] in
            self?.onTapButton()
        }.disposed(by: disposeBag)

        
        
        rxswiftJust()
        rxswiftOf()
        rxswiftFrom()
        
        rxswfitCreate()
        
        rxswiftEmpty()
        rxswiftNever()
        rxswiftRange()
        
        rxswiftSingle()
        rxswiftComletable()
        rxswiftMaybe()
        
        rxswiftPublish()
        rxswiftBehavior()
        rxswiftRelay()
    }
        
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsToShow.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"prototypeCell", for: indexPath)
        cell.textLabel?.text = itemsToShow[indexPath.row]
        return cell
    }
    
    private func onTapButton() { print("onTapButton") }

}

extension ViewController {
    
    public func example(of description: String, action: () -> Void) {
        print("\n--- Example of :", description, "---")
        action()
        print("\n--- Example of End :", description, "---")
    }
    
}
