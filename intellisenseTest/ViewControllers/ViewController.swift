//
//  ViewController.swift
//  intellisenseTest
//
//  Created by UttamTech on 03/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var categoryColectionView: UICollectionView!
    @IBOutlet weak var subcategoryCollectionView: UICollectionView!
    @IBOutlet weak var detailsCategoryCollectionView: UICollectionView!
    @IBOutlet weak var noRecord: UILabel!
    
    //MARK:- variables
    var categorydata = Category(dictionary: NSDictionary())
    var detailsCategory = SubCategory(dictionary: NSDictionary())
    var selectedCategory = NSMutableArray()
    var selectedSubCategory = NSMutableArray()
    var indexCategory = 0
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryColectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        subcategoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        detailsCategoryCollectionView.register(UINib(nibName: "SubcategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubcategoryCollectionViewCell")
        categoryService(storeId: 38)
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
            if selectedCategory.count > 0{
                indexCategory = selectedCategory[0] as! Int
            }
            if categorydata?.result?[indexCategory].subCategories?.count ?? 0 > 0{
                return categorydata?.result?[indexCategory].subCategories?.count ?? 0
            }else{
                return 0
            }
        }else{
            if self.detailsCategory?.result?.count ?? 0 > 0{
                return self.detailsCategory?.result?.count ?? 0
            }else{
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryColectionView{
            let cell = categoryColectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            let data = categorydata?.result?[indexPath.row]
            cell.categoryLbl.text = data?.name
            if selectedCategory.count > 0{
                let index = selectedCategory[0]
                if indexPath.row == index as! Int{
                    cell.mainView.layer.backgroundColor = UIColor.systemOrange.cgColor
                }else{
                    cell.mainView.layer.backgroundColor = UIColor.white.cgColor
                }
            }else{
                if indexPath.row == 0{
                    cell.mainView.layer.backgroundColor = UIColor.systemOrange.cgColor
                }else{
                    cell.mainView.layer.backgroundColor = UIColor.white.cgColor
                }
            }
            return cell
        }else if collectionView == subcategoryCollectionView{
            let cell = subcategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            let data = categorydata?.result?[indexCategory].subCategories?[indexPath.row]
            cell.categoryLbl.text = data?.name
            if selectedSubCategory.count > 0{
                let index = selectedSubCategory[0]
                if indexPath.row == index as! Int{
                    cell.mainView.layer.backgroundColor = UIColor.systemOrange.cgColor
                }else{
                    cell.mainView.layer.backgroundColor = UIColor.white.cgColor
                }
            }else{
                if indexPath.row == 0{
                    cell.mainView.layer.backgroundColor = UIColor.systemOrange.cgColor
                }else{
                    cell.mainView.layer.backgroundColor = UIColor.white.cgColor
                }
            }
            return cell
        }else{
            let cell = detailsCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "SubcategoryCollectionViewCell", for: indexPath) as! SubcategoryCollectionViewCell
            let data = detailsCategory?.result?[indexPath.row]
            if let url = URL(string: data?.featuredImage ?? ""){
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            cell.imageProduct.image = UIImage(data: data)
                        }
                    }
                }
            }
            cell.productName.text = data?.name
            cell.productPrice.text = data?.regularPrice
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryColectionView{
            if selectedCategory.count > 0{
                selectedCategory = NSMutableArray()
                selectedCategory.add(indexPath.row)
            }else{
                selectedCategory.add(indexPath.row)
            }
            categoryColectionView.reloadData()
            
            selectedSubCategory = NSMutableArray()
            selectedSubCategory.add(0)
            subcategoryCollectionView.reloadData()
            
            let data = categorydata?.result?[indexPath.row].subCategories?[0]
            detailsCategoryService(subCatId: (Int((data?.categoryId)!) ?? 0), parentCatId: (Int((data?.parentId)!) ?? 0))
        }else if collectionView == subcategoryCollectionView{
            if selectedSubCategory.count > 0{
                selectedSubCategory = NSMutableArray()
                selectedSubCategory.add(indexPath.row)
            }else{
                selectedSubCategory.add(indexPath.row)
            }
            subcategoryCollectionView.reloadData()
            let data = categorydata?.result?[indexCategory].subCategories?[indexPath.row]
            detailsCategoryService(subCatId: (Int((data?.categoryId)!) ?? 0), parentCatId: (Int((data?.parentId)!) ?? 0))
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
            return CGSize(width: cellWidth, height: cellWidth + 30)
        }
    }
}

extension ViewController{
    func categoryService(storeId: Int){
        let url = URL(string: "http://intellisensetechnology.host/remix/remix_api/api/item/get_items_by_store_new")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "storeId": storeId
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
                            self.detailsCategoryService(subCatId: 15, parentCatId: 3)
                            DispatchQueue.main.async {
                                self.categoryColectionView.reloadData()
                                self.subcategoryCollectionView.reloadData()
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
    
    func detailsCategoryService(subCatId: Int, parentCatId:Int){
        let url = URL(string: "http://intellisensetechnology.host/remix/remix_api/api/item/get_items_by_category")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "subCatId":subCatId,
            "parentCatId":parentCatId,
            "userId":128,
            "storeId":38
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
                            self.detailsCategory = SubCategory(dictionary: myDictionary)!
                            if self.detailsCategory?.status == 1 && self.detailsCategory?.result?.count ?? 0 > 0{
                                DispatchQueue.main.async {
                                    self.detailsCategoryCollectionView.isHidden = false
                                    self.noRecord.isHidden = true
                                    self.detailsCategoryCollectionView.reloadData()
                                }
                            }else{
                                DispatchQueue.main.async {
                                    self.detailsCategoryCollectionView.isHidden = true
                                    self.noRecord.isHidden = false
                                }
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

