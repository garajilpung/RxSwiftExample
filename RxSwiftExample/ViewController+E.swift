//
//  ViewController+E.swift
//  RxSwiftExample
//
//  Created by suhyup02 on 2022/02/03.
//

import Foundation
import RxSwift


extension ViewController {
    
    public func rxswiftJust() {
        example(of: "just") {
            let one = 1
            let two = 2
            let three = 3
            
            let observable = Observable<Int>.just(one)
            observable.subscribe { event in
                print(event)
            }.disposed(by: disposeBag)
            

            let observable2 = Observable<[Int]>.just([one, two, three])
            observable2.subscribe { event in
                print(event)
            }
        }
    }
    
    public func rxswiftOf() {
        example(of: "of") {
            let one = 1
            let two = 2
            let three = 3
            
            let observable = Observable.of(one, two, three)
            observable.subscribe { val in
                print(val)
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: disposeBag)

            let observable2 = Observable.of([one, two, three])
            observable2.subscribe { val in
                print(val)
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: disposeBag)
        }
    }
    
    public func rxswiftFrom(){
        example(of: "from") {
            let one = 1
            let two = 2
            let three = 3
            
            let _ = Observable.from([one, two, three]).subscribe { val in
                print(val)
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                
            } onDisposed: {
                
            }
        }
    }
    
    public func rxswfitCreate(){
        example(of: "create") {
            let disposeBag = DisposeBag()
            
            let observable = Observable<String>.create { (observer) -> Disposable in
                observer.onNext("1")
                
                observer.onCompleted()
                
                observer.onNext("?")
                
                return Disposables.create()
            }
            
            observable.subscribe { event in
                print(event)
            }
        }
    }
    
    public func rxswiftEmpty() {
        example(of: "empty") {
            let observable = Observable<Void>.empty()
            
            observable.subscribe { element in
                print(element)
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                
            }.disposed(by: disposeBag)

        }
    }
    
    public func rxswiftNever() {
        example(of: "never") {
            let observable = Observable<Any>.never()
            
            observable.subscribe { element in
                print(element)
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                
            }.disposed(by: disposeBag)

        }
    }
    
    public func rxswiftRange() {
        example(of: "range") {
            let observable = Observable<Int>.range(start: 1, count: 10)
            
            observable.subscribe { (i) in
                let n = Double(i)
                let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
                print(fibonacci)
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                
            }.disposed(by: disposeBag)

        }
    }
    
    
    public func rxswiftSingle() {
        example(of: "Single") {
             
             let disposeBag = DisposeBag()
             
             enum FileReadError: Error {
                 case fileNotFound, unreadable, encodingFailed
             }
             
             func loadText(from name: String) -> Single<String> {

                 return Single.create{ single in
                     
                     let disposable = Disposables.create()
                     
                     guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
                         single(.failure(FileReadError.fileNotFound))
                         return disposable
                     }
                     
                     guard let data = FileManager.default.contents(atPath: path) else {
                         single(.failure(FileReadError.unreadable))
                         return disposable
                     }
                     
                     guard let contents = String(data: data, encoding: .utf8) else {
                         single(.failure(FileReadError.encodingFailed))
                         return disposable
                     }
                     
                     single(.success(contents))
                     return disposable
                 }
             }
            
            // test
            loadText(from: "myFile")
                   .subscribe{
                       switch $0 {
                       case .success(let string):
                           print(string)
                       case .failure(let error):
                           print(error)
                       }
                   }
                   .disposed(by: disposeBag)
            
            // prints: fileNotFound
            
         }
    }
    
    public func rxswiftComletable() {
        example(of: "Completable") {
            
            let disposeBag = DisposeBag()
            
            enum FileReadError: Error {
                case fileNotFound, unreadable, encodingFailed
            }
            
            func loadText(from name: String) -> Completable {
                
                return Completable.create { completable in
                    
                    let disposable = Disposables.create()
                    
                    guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
                        completable(.error(FileReadError.fileNotFound))
                        return disposable
                    }
                    
                    guard let data = FileManager.default.contents(atPath: path) else {
                        completable(.error(FileReadError.unreadable))
                        return disposable
                    }
                    
                    guard let contents = String(data: data, encoding: .utf8) else {
                        completable(.error(FileReadError.encodingFailed))
                        return disposable
                    }
                    
                    print(contents)
                    
                    completable(.completed)
                    return disposable
                    
                }
                
            }
            
            // test
            loadText(from: "myFile")
                   .subscribe{
                       switch $0 {
                       case .completed:
                           print("success")
                       case .error(let error):
                           print(error)
                       }
                   }
                   .disposed(by: disposeBag)
            
            // prints: fileNotFound
            
        }
    }
    
    public func rxswiftMaybe() {
        example(of: "Maybe") {
            
            let disposeBag = DisposeBag()
            
            enum FileReadError: Error {
                case fileNotFound, unreadable, encodingFailed
            }
            
            func loadText(from name: String) -> Maybe<String> {
                
                return Maybe.create { maybe in
                    
                    let disposable = Disposables.create()
                    
                    guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
                        maybe(.error(FileReadError.fileNotFound))
                        return disposable
                    }
                    
                    guard let data = FileManager.default.contents(atPath: path) else {
                        maybe(.error(FileReadError.unreadable))
                        return disposable
                    }
                    
                    guard let contents = String(data: data, encoding: .utf8) else {
                        maybe(.error(FileReadError.encodingFailed))
                        return disposable
                    }
                    
                    maybe(.success(contents))
                    
                    maybe(.completed)
                    return disposable
                    
                }
                
            }
            
            // test
            loadText(from: "myFile")
                   .subscribe{
                       switch $0 {
                       case .success(let string):
                           print(string)
                       case .completed:
                           print("completed")
                       case .error(let error):
                           print(error)
                       }
                   }
                   .disposed(by: disposeBag)
            
            // prints: fileNotFound
            
        }
    }
    
    
    public func rxswiftPublish() {
        example(of: "PublishSubject") {
            let subject = PublishSubject<String>()
            subject.onNext("Is anyone listening?")

            // 첫 번째 구독 요청
            let subscriptionOne = subject
                .subscribe(onNext: { (string) in
                    print(string)
                })
            
            subject.on(.next("1"))
            subject.onNext("2")
            // prints : 1, 2

            // 두 번째 구독 요청
            let subscriptionTwo = subject
                .subscribe({ (event) in
                    print("2)", event.element ?? event)
                })
            subscriptionOne.dispose()
            
            subject.onNext("3") // print : 2) 3
            
            subject.onNext("4") // print : 2) 4
            
            subject.onCompleted() // print : 2) completed
            
            subject.onNext("5") // none of print

            subscriptionTwo.dispose()

            let disposeBag = DisposeBag()

            subject
                .subscribe {
                    print("3)", $0.element ?? $0) // print : 3) completed
            }
                .disposed(by: disposeBag)

            subject.onNext("?") // none of print
        }
    }
    
    public func rxswiftBehavior() {
        enum MyError: Error {
            case anError
        }

        example(of: "BehaviorSubject") {

            // BehaviorSubject는 초기값이 필수 이므로 초기화값을 삽입
            let subject = BehaviorSubject(value: "Initial value")
            let disposeBag = DisposeBag()
            
            subject.onNext("X")

            subject
                .subscribe{
                    print("1)", $0)
                }
                .disposed(by: disposeBag)
            // print : 1) next(X)
            
            subject.onError(MyError.anError)
            // print : 1) error(anError)
            
            subject
                .subscribe {
                    print("2)", $0)
                }
                .disposed(by: disposeBag)
            // print : 2) error(anError)
        }
    }
    
    public func rxswiftRelay(){
        enum MyError: Error {
            case anError
        }
        
        example(of: "ReplaySubject") {

            let subject = ReplaySubject<String>.create(bufferSize: 2)
            let disposeBag = DisposeBag()

            subject.onNext("1")
            subject.onNext("2")
            subject.onNext("3")

            subject
                .subscribe {
                    print("1)", $0)
                }
                .disposed(by: disposeBag)
            /* prints
             1) next(2)
             1) next(3)
             */
            
            subject
                .subscribe {
                    print("2)", $0)
                }
                .disposed(by: disposeBag)
            /* prints
             2) next(2)
             2) next(3)
             */
            
            
            subject.onNext("4")
            /* prints
             1) next(4)
             2) next(4)
             */
                        
            subject.onError(MyError.anError)
            /* prints
             1) error(anError)
             2) error(anError)
             */
           subject.dispose()
            
            subject.subscribe {
                print("3)", $0)
                }
                .disposed(by: disposeBag)
            /* prints:
             3) next(3)
             3) next(4)
             3) error(anError)
             */
        }
    }

    
    public func complete() {
        print("complete")
    }
}
