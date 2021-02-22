# 스톱워치 만들기!!!
### 목표 : 시간체크 할 수 있는 시계만들기
##### 기능 : 시간 카운트 멈추기 이어서 카운트하기  초기화 하기 
     준비물 : 시계, 버튼 3개 , 시간표시화면
    
    @IBOutlet weak var 스톱워치라벨: UILabel!
    @IBOutlet weak var 시작버튼: UIButton!
    @IBOutlet weak var 정지버튼: UIButton!
    @IBOutlet weak var 끝버튼: UIButton!
     
1. 시계를 움직이게 하자 (버튼을 누르면 시계가 움직이고 카운트 시작)


   시간을 표시해줄 Label추가 
   
   
   라벨 오토레이아웃 잡고 -> 아울렛 연결 
   
   
  - 시계 만들기
  ```
  var 시계: Timer?
  ```
  - 시간 카운터 할 변수 선언 
  ```
  var 시계: Timer?
  ```
  -  시작 버튼 클릭시 카운트 시작 
  -  시작 버튼 액션연결 


시간을 1초씩 증가 시키고 문자열로 변형해서 라벨에 넣어서 시간 출력(버튼 중복클릭 방지하기)
  ```
  @IBAction func 시작(_ sender: Any) {
        버튼중복클릭방지()   
        시계 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(_) in
            self.시간카운트 += 1
            DispatchQueue.main.async {
                let 시간문자열 = self.시간문자열변형(카운트: self.시간카운트)
                self.스톱워치라벨.text = 시간문자열
            }
  ```
  시간 문자열로 변환시키는 기능의 함수 
 ```
   func 시간문자열변형(카운트: Int) -> (String) {
        let 초 = 카운트 % 60
        let 분 = 카운트 / 60 % 60
        let 시 = 카운트 / (60 * 60)
        
        let 초_문자열 =  "\(초)".count == 1 ? "0\(초)" : "\(초)"
        let 분_문자열 = "\(분)".count == 1 ? "0\(분)" : "\(분)"
        let 시_문자열 = "\(시)".count == 1 ? "0\(시)" : "\(시)"
        return ("\(시_문자열) : \(분_문자열) : \(초_문자열)")
    }
```

  2. 시간멈추기
 ```
   @IBAction func 멈춤(_ sender: Any) {
        버튼중복클릭방지()
        
        시계?.invalidate()
        시계 = nil
    }
 ```
 3.   시계 초기화 끝 클릭시 초기화 하기
 ```
  @IBAction func 끝(_ sender: Any) {
        시작버튼.isEnabled = true
        정지버튼.isEnabled = false
        끝버튼.isEnabled = false
        
        시계?.invalidate()
        시계 = nil
        
        시간카운트 = 0
        스톱워치라벨.text = "00 : 00 : 00"
        
    }
 ```
- 버튼중복클릭방지 기능
   - 시작버튼 누르기전 까지 나머지 버튼 비활성화
   - 클릭된 버튼 비홯성화 나머지 버튼 활성화
 
```
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
    
```
### 전체 코드
```
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
```
<img src="https://user-images.githubusercontent.com/70513066/108709692-64942600-7556-11eb-98da-b783d226fa82.png" width="40%">
<img src="https://user-images.githubusercontent.com/70513066/108709661-580fcd80-7556-11eb-81f9-80e67f1b79d4.png" width="40%">


