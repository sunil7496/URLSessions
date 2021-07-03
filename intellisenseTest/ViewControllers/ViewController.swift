//
//  ViewController.swift
//  intellisenseTest
//
//  Created by TrivialWorks on 03/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var categoryColectionView: UICollectionView!
    @IBOutlet weak var subcategoryCollectionView: UICollectionView!
    @IBOutlet weak var detailsCategoryCollectionView: UICollectionView!
    
    //MARK:- variables
    var categorydata = Category(dictionary: NSDictionary())
    var categorydataArr = CategoryResult(dictionary: NSDictionary())
    var subcategory = SubCategory(dictionary: NSDictionary())
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryColectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        subcategoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        detailsCategoryCollectionView.register(UINib(nibName: "SubcategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubcategoryCollectionViewCell")
        service()
    }

}

//MARK:- collectionView Delegates & datasourse
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryColectionView{
            if self.categorydata?.result?.count ?? 0 > 0{
                return self.categorydata?.result?.count ?? 0
            }else{
                return 0
            }
        }else if collectionView == subcategoryCollectionView{
            if categorydata?.result?[0].subCategories?.count ?? 0 > 0{
                return categorydata?.result?[0].subCategories?.count ?? 0
            }else{
                return 0
            }
        }else{
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryColectionView{
            let cell = categoryColectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            let data = categorydata?.result?[indexPath.row]
            cell.categoryLbl.text = data?.name
            return cell
        }else if collectionView == subcategoryCollectionView{
            let cell = subcategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            let data = categorydata?.result?[indexPath.row].subCategories?[indexPath.row]
            cell.categoryLbl.text = data?.name
            
            return cell
        }else{
            let cell = detailsCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "SubcategoryCollectionViewCell", for: indexPath) as! SubcategoryCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryColectionView{
            
        }else if collectionView == subcategoryCollectionView{
            
        }else{
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryColectionView{
            return CGSize(width: 150, height: 50)
        }else if collectionView == subcategoryCollectionView{
            return CGSize(width: 150, height: 50)
        }else{
            let layout = detailsCategoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.minimumInteritemSpacing = 0
            let cellWidth = (self.view.frame.width - 30) / 2
            detailsCategoryCollectionView.contentInset.top = 22
            detailsCategoryCollectionView.contentInset.bottom = 12
            return CGSize(width: cellWidth, height: cellWidth)
        }
    }
}

extension ViewController{
    func service(){
        let url = URL(string: "http://intellisensetechnology.host/remix/remix_api/api/item/get_items_by_store_new")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "storeId": 38
        ]
        request.httpBody = parameters.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                var dictonary:NSDictionary?
                if let data = dataString.data(using: .utf8) {
                    do {
                        dictonary =  try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                        if let myDictionary = dictonary
                        {
                            self.categorydata = Category(dictionary: myDictionary)!
                            DispatchQueue.main.async {
                                self.categoryColectionView.reloadData()
                                self.subcategoryCollectionView.reloadData()
                                self.detailsCategoryCollectionView.reloadData()
                            }
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

