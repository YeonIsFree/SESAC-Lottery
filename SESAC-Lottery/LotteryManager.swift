//
//  LotteryManager.swift
//  SESAC-Lottery
//
//  Created by Seryun Chun on 2024/01/16.
//

import UIKit
import Alamofire

struct LotteryManager {
    
    func callRequest(drawNumber: Int, completionHandler: @escaping ([Int]) -> Void) {
        let url: String = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drawNumber)"
        
        AF
            .request(url, method: .get)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let success):
                    
                    let numbers: [Int] = [
                        success.drwtNo1,
                        success.drwtNo2,
                        success.drwtNo3,
                        success.drwtNo4,
                        success.drwtNo5,
                        success.drwtNo6,
                        success.bnusNo
                    ]
                    
                    completionHandler(numbers)
                    
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}
