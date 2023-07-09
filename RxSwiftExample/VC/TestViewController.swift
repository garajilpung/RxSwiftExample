//
//  TestViewController.swift
//  RxSwiftExample
//
//  Created by suhyup02 on 2022/02/14.
//

import UIKit
import RxSwift
import RxCocoa

struct Model {
  var number: Int
}

protocol ViewModelType {
  var tap: PublishRelay<Void> { get }
  var number: Driver<String> { get }
}

final class ViewModel: ViewModelType {
  // input
  let tap = PublishRelay<Void>()
    
  // output
  let number: Driver<String>
    
  private let model = BehaviorRelay<Model>(value: .init(number: 100))
    
  let disposeBag = DisposeBag()
    
  init() {
    self.number = self.model
      .map { "\($0.number)" }
      .asDriver(onErrorRecover: { _ in .empty() })
        
    self.tap
      .withLatestFrom(model)
      .map { model -> Model in
        var nextModel = model
        nextModel.number += 1
        return nextModel
      }.bind(to: self.model)
      .disposed(by: disposeBag)
  }
}

class TestViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var viewModel: ViewModelType
    var disposeBag = DisposeBag()
    
     init(viewModel: ViewModelType) {
        self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bind(viewModel: self.viewModel)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func bind(viewModel: ViewModelType) {
        self.viewModel.number
          .drive(self.label.rx.text)
          .disposed(by: self.disposeBag)
        
        self.button.rx.tap
          .bind(to: viewModel.tap)
          .disposed(by: self.disposeBag)
      }
}
