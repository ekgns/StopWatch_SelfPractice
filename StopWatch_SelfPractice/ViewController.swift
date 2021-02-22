//
//  ViewController.swift
//  StopWatch_SelfPractice
//
//  Created by 다훈김 on 2021/02/20.
//

import UIKit

/*  스톱워치
        - 시간 세기
        - 시간 멈춤
        - 시간 초기화
    준비물
        - 시계
        - 버튼 3개 (시작, 멈춤, 초기화)
        - 시간을 보여줄 화면
 */

class ViewController: UIViewController {
    @IBOutlet weak var 스톱워치라벨: UILabel!
    @IBOutlet weak var 시작버튼: UIButton!
    @IBOutlet weak var 정지버튼: UIButton!
    @IBOutlet weak var 끝버튼: UIButton!
    
    
    // 시계
    var 시계: Timer?
    
    // 시간카운트
    var 시간카운트 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        시작버튼.isEnabled = true
        정지버튼.isEnabled = false
        끝버튼.isEnabled = false
       
    }
    
    @IBAction func 시작(_ sender: Any) {
        버튼중복클릭방지()
        
        시계 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(_) in
            self.시간카운트 += 1
            DispatchQueue.main.async {
                let 시간문자열 = self.시간문자열변형(카운트: self.시간카운트)
                self.스톱워치라벨.text = 시간문자열
            }
                                      })
    }
    
    @IBAction func 멈춤(_ sender: Any) {
        버튼중복클릭방지()
        
        시계?.invalidate()
        시계 = nil
    }
    
    @IBAction func 끝(_ sender: Any) {
        시작버튼.isEnabled = true
        정지버튼.isEnabled = false
        끝버튼.isEnabled = false
        
        시계?.invalidate()
        시계 = nil
        
        시간카운트 = 0
        스톱워치라벨.text = "00 : 00 : 00"
        
    }
    
    func 시간문자열변형(카운트: Int) -> (String) {
        let 초 = 카운트 % 60
        let 분 = 카운트 / 60 % 60
        let 시 = 카운트 / (60 * 60)
        
        let 초_문자열 =  "\(초)".count == 1 ? "0\(초)" : "\(초)"
        let 분_문자열 = "\(분)".count == 1 ? "0\(분)" : "\(분)"
        let 시_문자열 = "\(시)".count == 1 ? "0\(시)" : "\(시)"
        return ("\(시_문자열) : \(분_문자열) : \(초_문자열)")
    }
    
    func 버튼중복클릭방지() {
        if 시작버튼.isEnabled == true {
            시작버튼.isEnabled = false
            정지버튼.isEnabled = true
            끝버튼.isEnabled = true
        } else if 정지버튼.isEnabled == true {
            시작버튼.isEnabled = true
            정지버튼.isEnabled = false
            끝버튼.isEnabled = true
        }
    }
    
   
    
}


