
import UIKit

struct Post {
    let image: UIImage
    let name: String
    let likes: String
    let views: String
    var description: String? = nil
}

struct PostSection {
    //let title: String
    let posts: [Post]
    var footer: String? = nil
}

struct Storage {
   // static var cart: [Post] = []
    
    static let tableModel = [
        PostSection(
           // title: "New iMacs & Mac Pro's",
            posts: [
                Post(image: #imageLiteral(resourceName: "witcher"), name: "vedmak.official", likes: "Likes: 240", views: "Views: 312", description:"Новые кадры со съемок второго сезона сериала 'Ведьмак'"),
                Post(image: #imageLiteral(resourceName: "netology"), name: "Нетология. Меняем Карьеру через образование", likes: "Likes: 766", views: "Views: 893", description: "От \u{00AB}Hello, World!\u{00BB} до первого сложного iOS-приложения \u{2014} всего один курс. Если чувствуете в себе силу для покорения топов AppStore \u{2014} пора начинать дейтвовать! Профессия \u{00AB}iOS-разработчик\" \u{2014} тот самый путь, по которому стоит пройти до самого конца. Вы научитесь создавать приожения на языке Swift с нуля: от начинки до интерфейса. Чтобы закрепить знания на практике, каждый студент подготовит дипломную работу \u{2014} VK-like приложение с возможностью публиковать фотографии, использовать фильтры, ставить лайки и подписываться на других пользователей."),
//                Device(image: #imageLiteral(resourceName: "mac_mini"), name: "mac mini", price: "999 $", description: "Created by Alex Kolovatov on 27.05.2020.Copyright © 2020 Alex Kolovatov. All rights reserved."),
//                Device(image: #imageLiteral(resourceName: "mac_pro"), name: "mac Pro", price: "6 200 $"),
            ]
        ),
        
        PostSection(
           // title: "New iMacs & Mac Pro's",
            posts: [
                Post(image: #imageLiteral(resourceName: "ip_man"), name: "Ип Ман. Учитель Брюса Ли, человек открывший миру стиль Вин-Чун", likes: "Likes: 280", views: "Views: 634", description:"В 50-х — 60-х годах XX века в Гонконге Ип Ман первым начал открытое преподавание кунг-фу Вин Чун, которое до той поры оставалось клановым. В Европе и Америке известен также как учитель киноактера Брюса Ли, познакомившего Западный мир с китайскими боевыми искусствами. Неофициально именуется патриархом Вин Чун"),
               Post(image: #imageLiteral(resourceName: "bruce_lee"), name: "Брюс Ли. Человек-легенда", likes: "Likes: 820", views: "Views: 1233", description: "\u{00AB}Я говорю, опустоши свой ум, будь аморфным, бесформенным, как вода. Ты наливаешь воду в чашку, она становится чашкой. Ты наливаешь воду в бутылку, она становится бутылкой. Ты наливаешь воду в чайник, она становится чайником. Вода может течь, а может крушить. Будь водой, друг мой...\u{00BB} Философия Брюса Ли"),
            ]
        )
//        
//        DeviceSection(
//            title: "Fresh iPhones to sale",
//            devices: [
//                Device(image: #imageLiteral(resourceName: "pro_gold"), name: "iPhone 11 Pro Gold", price: "1 200"),
//                Device(image: #imageLiteral(resourceName: "pro_green"), name: "iPhone 11 Pro Green", price: "1 200 $", description: "Created by Alex Kolovatov on 27.05.2020.Copyright © 2020 Alex Kolovatov. All rights reserved."),
//                Device(image: #imageLiteral(resourceName: "xr_blue"), name: "iPhone XR Blue", price: "799 $"),
//                Device(image: #imageLiteral(resourceName: "se_red"), name: "iPhone SE Product Red", price: "499 $"),
//            ]
//        )
//        
    ]
    
}
