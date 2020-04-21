import UIKit
import Photos

class ResultViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func restartButtonClick(_ sender: Any) {
        arrayOfDb.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    var technics = 0.0
    var artistry = 0.0
    var skill = 0.0
    var charisma = 0.0
    var characterSum = 0.0
    
    var status: NSString = ""
    var about: NSString = ""
    var imageName = ""
    
    var maxDb = arrayOfDb[0]
    
    var labelStatus: UILabel!
    var labelAbout: UILabel!
    var mainImage: UIImageView!
    
    var countOfAnimation = 0
    
    
    var testGuys: [String: (String, String)] = ["Bruce": ("about", "imagename")] // вот так в словарь можно вложить и описание, и картинку
    
    var guys: [String: String] = ["Брюс Рыглис": "Своей отрыжкой ты можешь расколоть и гнусного террориста, и гигантский астероид",
                                  "Сильвестр Рыглоне": "Твоя отрыжка отправит в нокаут как и профессионального боксера, так и хмыря за соседним столиком",
                                  "Стивен Рыгал": "Ты в рыгальной осаде. Плохие парни окружили тебя, но у них нет ни единого шанса",
                                  "Джейсон Рыгхэм": "Ты настоящая адреналиново-рыгающая машина. Будь осторожен, без рыгания тебе придет конец!",
                                  "Жан-Клод Рыг Вам": "Отрыжка в шпагате - вот твой конёк. Всегда помни об этом!",
                                  "Александр Рыгский": "Пиво внутри, отрыжка снаружи. Ю вона берп - летс берп!",
                                  "Данила Рыгловский": "Прости, братан, это не уровень Рыгливуда. Тебе явно нужны еще пара пив",
                                  "Арнольд Шварцрыгер": "Тебя явно прислали из будущего. И тебе нужны новая отрыжка, одежда и еще одно пиво",
                                  "Киану Рыгс": "Светлое или темное? Выпьешь светлое - и сказке конец. Выберешь темное - попадешь в страну чудес и отрыжки. Но запомни одно - ты Избранный",
                                  "Джон Рыголта": "Ты крепкий специалист в области отрыжки, веселых танцев в носках и спасении обнюханных женщин",
                                  "Мухаммед Рыгли": "Рыгай как бабочка, жаль что ты лох. Выпей три лагера и попробуй снова",
                                  "Рыгакоп": "Сразу слышно, что тебя собрали из остатков человека, объединив с новейшими разработками робототехники. Светлое или темное, ты рыгаешь со мной",
                                  "Квентин Рыгантино": "Говорят, что ты знаменит максимальным количеством отрыжки в своих работах. Не останавливайся!",
                                  "Данни Трэхо": "Ты просто отрыжечный пацан. Для тебя даже ничего придумывать не надо",
                                  "Рыгающий по лезвию": "Ты главный герой рыгопанка, вычисляешь репликантов по отрыжке. Опасайся Рыгера Х.",
                                  "Стас Рыгайлов": "Всё для тебя, отрыжка и пивасы. Все девчонки за 40 твои",
                                  "Фифти Рыгс": "Ты король рыготного свэга. Тачки, тёлки, брюлики, модная рыгота - это всё ты",
                                  "Элвис Рыгcли": "Ты настоящий король рыгнролла. Все визжат, услышав как ты мелодично рыгаешь",
                                  "Фрэнк Рыгатра": "Ты совсем рядом с рыготной мафией. Не увлекайся, или твоя джазовая отрыжка не спасет тебя",
                                  "Зэ Рыглс": "Ты один стоишь всей рыглпульской четверки. Рыгломания охватила всю планету только благодаря тебе",
                                  "Боб Рыглей": "Ты настоящая звезда музыки рыгги. Вавилон падет!",
                                  "Леонид Рыгутин": "Хоп-хей лалалей, себе пивка еще налей. Ты явно парень непохожий на слабака",
                                  "Бритни Срыгс": "Упс, ты опять обосрался. Сорян, браток",
                                  "Мэрилин Рыгло": "Рыгая, ты сохраняешь свое очарование. Отличный повод взять еще пива",
                                  "Оззи Рыгосборн": "Ты настоящий князь тьмы. Продолжай закусывать летучими мышами",
                                  "Леонардо Ры Гаприо": "Продолжай в том же духе. Рано или поздно твой Рыгоскар тебя найдет",
                                  "Брыг Питт": "Ты - это не твоя работа. Ты это не сколько денег у тебя в банке. Ты - это поющая и танцующая отрыжка этого мира",
                                  "Криштиану Рыгалду": "Стоит рядом рыгнуть - и ты уже корчишься от боли. Не надо так, время повзрослеть",
                                  "Диего Рыгадона": "Ты обладатель отрыжки бога. Особенно круто, что ты всегда бодрый и веселый",
                                  "Фродо Рыгинс": "На тебя можно положиться, ты всегда донесешь пивко и спасешь Рыгоземье",
                                  "Мэл Рыгсон": "Ты хорош в любых амплуа: и безумный  Рыгс, и лейтенант Рыгс, и свободолюбивый Виллем Рыголес. Всё тебе по плечу",
                                  "Рыгейрис Рыгорожденная": "Ты дамочка с характером, которая была рождена в отрыжке дракона. Твоё рыгание способно повернуть историю вспять",
                                  "Рыгги Поттер": "Ты мальчик, который выпил. Не вытаскивай свою волшебную палочку без надобности",
                                  "Железный рыговек": "Гений, миллиардер, плейбой, филантроп",
                                  "Рыгомаха": "Твой рыгомантиевый скелет может выдержать многое. Но будь осторожен, Рыгетто может быть совсем рядом",
                                  "Оби Рыг Кеноби": "Почувствуй Силу. Используй Силу. Рыгай",
                                  "Рыгзилла": "Ты настоящее рыгающее кайдзю. Kill ‘Em all!",
                                  "Большой Рыгловски": "Ваше рыгачество, эль рыгачиньо, рыгакер - называй себя как хочешь, главное не забудь глотнуть коктейль белый рыгский",
                                  "Жан Рыгло": "Бом-бом, ну ты француз! Девчонки влюбляются только услышав отголосок твоей отрыжки",
                                  "Рыгачу": "Рыгы-рыга! Такой маленький и милый, как и твоя отрыжка",
                                  "Алла Рыгачёва": "Ах аррыгино аррыгино, нужно быть крутым для всех. Ты просто примадоннна русской рыгательной сцены",
                                  "Михаил Крыг": "Ты почти что русский Фрэнк Рыгатра. Хорошие отрыжки для хороших людей",
                                  "Рыг и Рвоти": "Рыгаешь за двоих! Ты сразу также громок как старый дед, и также дерзок как молодой внук!",
                                  "Форрыг Гамп": "Рыгай, Форрыг, рыгай!",
                                  "Фредди Рыггер": "Твоя отрыжка найдет свои цели и в ночных кошмарах!",
                                  "Рыгальт из Рыгии": "Длинноволосый красавчик, орудующий двумя мечами и смертоносной отрыжкой. Берегись нечисть!",
                                  "Рыголас": "Прекрасное создание, уничтожающее сотню орков в минуту своей отрыжкой",
                                  "Чудовище Франкенрыга": "Жуткое создание, слепленное из отрыжек тысячи людей. Оно живо и рыгает!",
                                  "Астерыгс и Оберыгс": "Ты как будто упал в котел с рыготным зельем, так сильна твоя отрыжка! Рыгаллия будет свободной!",
                                  "Рыгальф": "Что может быть лучше, чем отрыгнуть свежим котенком и запить все пивком?",
                                  "Тираннозавр Рыгс": "Доисторическое существо, уничтожающее травоядных мощнейшей отрыжкой. Да-да, это ты",
                                  "Папа Рыгский": "Ты главный в своем собственном государстве, помешанном на отрыжке. Аве!",
                                  "Клинт Рыгсвуд": "Хороший, плохой, рыгающий. За пригоршню орешков к пивку готов прорыгать что-нибудь из Морриконе",
                                  "Неверыгятный Рыгк": "Ты готов в любой момент превратиться в отвратительное рыгающее существо зелёного цвета. Не злись, старина!",
                                  "Губка Рыг Рыготные штаны": "Кто прорыгает на дне океана? Именно этот милый, но отрыгительный парень",
                                  "Джон Рыг": "Смертоносный убийца. Известен также как Баба Рыга. Не трожь его пса!",
                                  "Рыгабло": "Ты рыгающий демон, вылезший в Рыгуарий из бездны ада, чтобы уничтожить все живое"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(testGuys["Bruce"]!.1)
        
        // заполняющаяся линия
        //        let linePath = UIBezierPath()
        //        linePath.move(to: CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2))
        //        linePath.addLine(to: CGPoint(x: view.frame.size.width / 2 + 200, y: view.frame.size.height / 2))
        //        testLine.path = linePath.cgPath
        //        testLine.lineWidth = 4
        //        testLine.fillColor = UIColor.red.cgColor
        //        testLine.strokeColor = UIColor.black.cgColor
        //        testLine.strokeEnd = 0
        //        view.layer.addSublayer(testLine)
        
        for db in arrayOfDb {
            if db > maxDb {
                maxDb = db
            }
        }
        
        getCharacter()
//        print("dB = \(maxDb + 200)")
//        print("Duration = \(burpDuration)")
        
        var shapeLayerOne = CAShapeLayer()
        var shapeLayerTwo = CAShapeLayer()
        var shapeLayerThree = CAShapeLayer()
        var shapeLayerFour = CAShapeLayer()
        
        func createRounds(withRadius: CGFloat) {
            let yellowColor = UIColor(red: 254/255, green: 218/255, blue: 0/255, alpha: 1.0)
            shapeLayerOne = createShapeLayer(x: view.frame.size.width / 4, y: view.frame.size.height / 6, color: yellowColor, radius: withRadius)
            view.layer.addSublayer(shapeLayerOne)
            
            shapeLayerTwo = createShapeLayer(x: 3 * view.frame.size.width / 4, y: view.frame.size.height / 6, color: yellowColor, radius: withRadius)
            view.layer.addSublayer(shapeLayerTwo)
            
            shapeLayerThree = createShapeLayer(x: view.frame.size.width / 4, y: 1.8 * view.frame.size.height / 5, color: yellowColor, radius: withRadius)
            view.layer.addSublayer(shapeLayerThree)
            
            shapeLayerFour = createShapeLayer(x: 3 * view.frame.size.width / 4, y: 1.8 * view.frame.size.height / 5, color: yellowColor, radius: withRadius)
            view.layer.addSublayer(shapeLayerFour)
        }
        
        var labelTechnics: LabelShapeLayer!
        var labelCharisma: LabelShapeLayer!
        var labelSkill: LabelShapeLayer!
        var labelArtistry: LabelShapeLayer!
        
        func createLabelsAndImage(labelMargin: CGFloat) {
            labelTechnics = LabelShapeLayer(x: view.frame.size.width / 4, y: view.frame.size.height / 6, label: "ТЕХНИКА", margin: labelMargin)
            view.addSubview(labelTechnics.myLabel)
            view.addSubview(labelTechnics.myValue)
            
            labelCharisma = LabelShapeLayer(x: 3 * view.frame.size.width / 4, y: view.frame.size.height / 6, label: "ХАРИЗМА", margin: labelMargin)
            view.addSubview(labelCharisma.myLabel)
            view.addSubview(labelCharisma.myValue)
            
            labelSkill = LabelShapeLayer(x: view.frame.size.width / 4, y: 1.8 * view.frame.size.height / 5, label: "МАСТЕРСТВО", margin: labelMargin)
            view.addSubview(labelSkill.myLabel)
            view.addSubview(labelSkill.myValue)
            
            labelArtistry = LabelShapeLayer(x: 3 * view.frame.size.width / 4, y: 1.8 * view.frame.size.height / 5, label: "АРТИСТИЗМ", margin: labelMargin)
            view.addSubview(labelArtistry.myLabel)
            view.addSubview(labelArtistry.myValue)
        }
        
        func createStatusAndAbout(width: CGFloat, statusSize: CGFloat, aboutSize: CGFloat) {
            
            // твое имя
            labelStatus = UILabel(frame: CGRect(x: 0, y: 0, width: width + 10, height: 40))
            labelStatus.center = CGPoint(x: view.frame.size.width / 2, y: 2.1 * view.frame.size.height / 3)
            labelStatus.textAlignment = .center
            labelStatus.text = String(status).uppercased()
            labelStatus.textColor = .black
            labelStatus.font = UIFont.init(name: "v_Billy The Flying Robot BB", size: statusSize)
            
            // описание
            labelAbout = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 150))
            labelAbout.center = CGPoint(x: view.frame.size.width / 2, y: 3.2 * view.frame.size.height / 4)
            labelAbout.textAlignment = .center
            labelAbout.text = String(about).uppercased()
            labelAbout.textColor = UIColor(red: 68/255, green: 45/255, blue: 0/255, alpha: 1.0)
            labelAbout.numberOfLines = 4
            labelAbout.font = UIFont.init(name: "v_Billy The Flying Robot BB", size: aboutSize)
            
        }
        
        // для iPhoneSE все делаем поменьше
        if UIScreen.main.bounds.height < 667 {
            createRounds(withRadius: 30)
            createLabelsAndImage(labelMargin: 50)
            
            // картинка
            mainImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 170))
            mainImage.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
            mainImage.image = UIImage(named: imageName)
            
            createStatusAndAbout(width: 300, statusSize: 28, aboutSize: 17)

        }
        // для остальных побольше
        else {
            createRounds(withRadius: 45)
            createLabelsAndImage(labelMargin: 60)
            
            // картинка
            mainImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 180, height: 204))
            mainImage.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
            mainImage.image = UIImage(named: imageName)
            
            createStatusAndAbout(width: 310, statusSize: 32, aboutSize: 20)
        }
        

        
        // без runAfter нифига не работает
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = false
            basicAnimation.delegate = self
            
            // анимация и заполнение цифр маркера Техника
            self.getTimer(value: self.technics, label: labelTechnics)
            basicAnimation.duration = self.technics
            basicAnimation.toValue = self.technics / 10
            shapeLayerOne.add(basicAnimation, forKey: "strokeOne")
            
            // анимация и заполнение цифр маркера Харизма
            self.getTimer(value: self.charisma, label: labelCharisma)
            basicAnimation.duration = self.charisma
            basicAnimation.toValue = self.charisma / 10
            shapeLayerTwo.add(basicAnimation, forKey: "strokeTwo")
            
            // анимация и заполнение цифр маркера Мастерство
            self.getTimer(value: self.skill, label: labelSkill)
            basicAnimation.duration = self.skill
            basicAnimation.toValue = self.skill / 10
            shapeLayerThree.add(basicAnimation, forKey: "strokeThree")
            
            // анимация и заполнение цифр маркера Артистизм
            self.getTimer(value: self.artistry, label: labelArtistry)
            basicAnimation.duration = self.artistry
            basicAnimation.toValue = self.artistry / 10
            shapeLayerFour.add(basicAnimation, forKey: "strokeFour")
//            basicAnimation.toValue = 0.8
//            self.testLine.add(basicAnimation, forKey: "testLine")
            
        }
        
        
        self.isModalInPresentation = true // свойство для того чтобы нельзя было смахнуть экран
        restartButton.layer.cornerRadius = restartButton.frame.width / 2
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        countOfAnimation += 1
        if countOfAnimation >= 4 {
            view.addSubview(labelStatus)
            view.addSubview(labelAbout)
            view.addSubview(mainImage)
        }
    }
    
    
    func getTimer(value: Double, label: LabelShapeLayer) {
        var counter = 0.00
        let _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            counter += 0.01
            label.myValue.text = "\(String(format: "%.2f", counter))"
            if counter >= value {
                timer.invalidate()
                label.myValue.text = "\(String(format: "%.2f", value))"
            }
        })
    }
    
    func createShapeLayer(x: CGFloat, y: CGFloat, color: UIColor, radius: CGFloat) -> CAShapeLayer {
        let result = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.systemGray.cgColor
        trackLayer.opacity = 0.5
        trackLayer.lineWidth = 6
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        result.fillColor = UIColor.clear.cgColor
        result.path = circularPath.cgPath
        result.lineWidth = 6
        result.strokeColor = color.cgColor
        result.strokeEnd = 0
        result.lineCap = .round
        
        return result
    }
    
    func getCharacter() {
        let tempDb = 200 + maxDb
        switch tempDb {
        case 0..<170:
            technics = (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            artistry = (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            skill = (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            charisma = (100 * Double.random(in: 0.1...0.5)).rounded() / 100
        case 170..<180:
            technics = (100 * Double.random(in: 0.5...2.0)).rounded() / 100
            artistry = (100 * Double.random(in: 0.5...2.0)).rounded() / 100
            skill = (100 * Double.random(in: 0.5...2.0)).rounded() / 100
            charisma = (100 * Double.random(in: 0.5...2.0)).rounded() / 100
        case 180..<184:
            technics = (100 * Double.random(in: 1.5...3.0)).rounded() / 100
            artistry = (100 * Double.random(in: 1.5...3.0)).rounded() / 100
            skill = (100 * Double.random(in: 1.5...3.0)).rounded() / 100
            charisma = (100 * Double.random(in: 1.5...3.0)).rounded() / 100
        case 184..<188:
            technics = (100 * Double.random(in: 3.0...5.5)).rounded() / 100
            artistry = (100 * Double.random(in: 3.0...5.5)).rounded() / 100
            skill = (100 * Double.random(in: 3.0...5.5)).rounded() / 100
            charisma = (100 * Double.random(in: 3.0...5.5)).rounded() / 100
        case 188..<192:
            technics = (100 * Double.random(in: 5.0...6.5)).rounded() / 100
            artistry = (100 * Double.random(in: 5.0...6.5)).rounded() / 100
            skill = (100 * Double.random(in: 5.0...6.5)).rounded() / 100
            charisma = (100 * Double.random(in: 5.0...6.5)).rounded() / 100
        case 192..<195:
            technics = (100 * Double.random(in: 6.0...7.5)).rounded() / 100
            artistry = (100 * Double.random(in: 6.0...7.5)).rounded() / 100
            skill = (100 * Double.random(in: 6.0...7.5)).rounded() / 100
            charisma = (100 * Double.random(in: 6.0...7.5)).rounded() / 100
        default:
            technics = (100 * Double.random(in: 7.0...8.0)).rounded() / 100
            artistry = (100 * Double.random(in: 7.0...8.0)).rounded() / 100
            skill = (100 * Double.random(in: 7.0...8.0)).rounded() / 100
            charisma = (100 * Double.random(in: 7.0...8.0)).rounded() / 100
        }
        
        switch burpDuration {
        case 0..<3:
            technics += (100 * Double.random(in: 0.5...1)).rounded() / 100
            artistry += (100 * Double.random(in: 0.5...1)).rounded() / 100
            skill += (100 * Double.random(in: 0.5...1)).rounded() / 100
            charisma += (100 * Double.random(in: 0.5...1)).rounded() / 100
        case 3..<5:
            technics += (100 * Double.random(in: 1...1.5)).rounded() / 100
            artistry += (100 * Double.random(in: 1...1.5)).rounded() / 100
            skill += (100 * Double.random(in: 1...1.5)).rounded() / 100
            charisma += (100 * Double.random(in: 1...1.5)).rounded() / 100
        case 5..<9:
            technics += (100 * Double.random(in: 1.5...2.0)).rounded() / 100
            artistry += (100 * Double.random(in: 1.5...2.0)).rounded() / 100
            skill += (100 * Double.random(in: 1.5...2.0)).rounded() / 100
            charisma += (100 * Double.random(in: 1.5...2.0)).rounded() / 100
        default:
            technics += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            artistry += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            skill += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            charisma += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
        }
        characterSum = technics + artistry + skill + charisma
        //characterSum = 5.6
        switch characterSum {
        case 0..<6:
            status = "Данила Рыгловский"
            imageName = "danila_ryglovsky"
        case 6..<7:
            status = "Александр Рыгский"
            imageName = "rygskiy"
        case 7..<8:
            status = "Бритни Срыгс"
            imageName = "britney_srygs"
        case 8..<9:
            status = "Стивен Рыгал"
            imageName = "rygal"
        case 9..<10:
            status = "Рыгальф"
            imageName = "rygalf"
        case 10..<10.5:
            status = "Губка Рыг Рыготные штаны" // не влезает
            imageName = "gubka_ryg"
        case 10.5..<11:
            status = "Криштиану Рыгалду"
            imageName = "rigaldu"
        case 11..<11.5:
            status = "Рыгачу"
            imageName = "rygachu"
        case 11.5..<12:
            status = "Мухаммед Рыгли"
            imageName = "muh_rygly"
        case 12..<12.5:
            status = "Сильвестр Рыглоне"
            imageName = "ryglone"
        case 12.5..<13:
            status = "Жан-Клод Рыг Вам"
            imageName = "ryg_vamm"
        case 13..<13.5:
            status = "Мэрилин Рыгло"
            imageName = "mer_ryglo"
        case 13.5..<14:
            status = "Рыгомаха"
            imageName = "rygomaha"
        case 13.5..<14:
            status = "Жан Рыгло"
            imageName = "ryglo"
        case 13.5..<14:
            status = "Михаил Крыг"
            imageName = "kryg"
        case 13.5..<14:
            status = "Фредди Рыггер"
            imageName = "freddy_ryger"
        case 13.5..<14:
            status = "Чудовище Франкенрыга"
            imageName = "frankenryga"
        case 14..<14.5:
            status = "Папа Рыгский"
            imageName = "papa_rygskiy"
        case 14.5..<15:
            status = "Форрыг Гамп"
            imageName = "forryg_gump"
        case 15..<15.5:
            status = "Стас Рыгайлов"
            imageName = "rygailov"
        case 15.5..<16:
            status = "Фифти Рыгс"
            imageName = "50_rygs"
        case 16..<16.5:
            status = "Элвис Рыгcли"
            imageName = "rygsley"
        case 16.5..<17:
            status = "Фрэнк Рыгатра"
            imageName = "rygatra"
        case 17..<17.5:
            status = "Боб Рыглей"
            imageName = "rygley"
        case 17.5..<18:
            status = "Леонид Рыгутин"
            imageName = "rygutin"
        case 18..<18.5:
            status = "Брыг Питт"
            imageName = "bryg_pitt"
        case 18.5..<19:
            status = "Диего Рыгадона"
            imageName = "rygadona"
        case 19..<19.5:
            status = "Рыгейрис Рыгорожденная" // не влезает
            imageName = "ryggeris"
        case 19.5..<20:
            status = "Железный рыговек"
            imageName = "iron_rygovek"
        case 20..<20.5:
            status = "Оби Рыг Кеноби"
            imageName = "ryg_kenobi"
        case 20.5..<21:
            status = "Большой Рыгловски"
            imageName = "ryglovsky"
        case 21..<21.5:
            status = "Рыголас"
            imageName = "rygolas"
        case 21.5..<22:
            status = "Джон Рыг"
            imageName = "john_ryg"
        case 22..<22.5:
            status = "Джон Рыголта"
            imageName = "rygolta"
        case 22.5..<23:
            status = "Рыгакоп"
            imageName = "rygocop"
        case 23..<23.5:
            status = "Квентин Рыгантино"
            imageName = "rygantino"
        case 23.5..<24:
            status = "Рыгающий по лезвию"
            imageName = "ryg_runner"
        case 24..<24.5:
            status = "Зэ Рыглс"
            imageName = "rygls"
        case 24.5..<25:
            status = "Оззи Рыгосборн"
            imageName = "ozzi"
        case 25..<25.5:
            status = "Леонардо Ры Гаприо"
            imageName = "leo_rygaprio"
        case 25.5..<26:
            status = "Фродо Рыгинс"
            imageName = "frodo_ryggins"
        case 26..<26.5:
            status = "Мэл Рыгсон"
            imageName = "rygson"
        case 26.5..<27:
            status = "Рыгги Поттер"
            imageName = "ryggy_potter"
        case 27..<27.5:
            status = "Алла Рыгачёва"
            imageName = "rygachova"
        case 27.5..<28:
            status = "Рыгальт из Рыгии"
            imageName = "rygalt"
        case 28..<28.5:
            status = "Астерыгс и Оберыгс"
            imageName = "asterygs"
        case 28.5..<29.5:
            status = "Неверыгятный Рыгк"
            imageName = "rygalk"
        case 29.5..<30.5:
            status = "Джейсон Рыгхэм"
            imageName = "ryghem"
        case 30.5..<31.5:
            status = "Арнольд Шварцрыгер"
            imageName = "scvarcrigley"
        case 31.5..<32.5:
            status = "Рыг и Рвоти"
            imageName = "ryg_rvoti"
        case 32.5..<33.5:
            status = "Рыгабло"
            imageName = "rygablo"
        case 33.5..<34.5:
            status = "Тираннозавр Рыгс"
            imageName = "rygs"
        case 34.5..<35:
            status = "Рыгзилла"
            imageName = "rygzilla"
        case 35..<36:
            status = "Киану Рыгс"   // описание не влазит 
            imageName = "kianu_rygs"
        case 36..<37:
            status = "Данни Трэхо"
            imageName = "rygeho"
        case 37..<38:
            status = "Клинт Рыгсвуд"
            imageName = "rygswood"
            
        default:
            status = "Брюс Рыглис"
            imageName = "ryglis"
        }
        
        //status = "Леонардо Ры Гаприо"
        
        about = guys[String(status)]! as NSString
//        print("Technics = \(technics)")
//        print("Charisma = \(charisma)")
//        print("Skill = \(skill)")
//        print("Artistry = \(artistry)")
//        print("Sum = \(characterSum)")
    }
    
    @IBAction func instButtonClick(_ sender: Any) {
        createImageForStory { (image, error) in
            if let myImage = image {
                shareOnInstagram(image: myImage)
            }
        }
    }
    
    @IBAction func shareButtonClick(_ sender: Any) {
        createImageForStory { (image, error) in
            if let myImage = image {
                let vc = UIActivityViewController(activityItems: [myImage], applicationActivities: [])
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    
    func createImageForStory(completion: @escaping (_ result: UIImage?, _ error: String?) -> Void) {
        let size = CGSize.init(width: 1080, height: 1920)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            let image = UIImage(named: "back_burp_result_2")
            image?.draw(in: rect)
            
            func drawStr(number: Double, x: CGFloat, y: CGFloat) {
                let technicsStr = "\(String(format: "%.2f", number))" as NSString
                
                let technicsAttributes = [
                    NSAttributedString.Key.font : UIFont.init(name: "v_Billy The Flying Robot BB", size: 80),
                    NSAttributedString.Key.foregroundColor : UIColor(red: 68/255, green: 45/255, blue: 0/255, alpha: 1.0)
                ]
                let technicsSize = technicsStr.size(withAttributes: technicsAttributes as [NSAttributedString.Key : Any])
                technicsStr.draw(
                    in: CGRect(x: x, y: y, width: technicsSize.width, height: technicsSize.height
                    ),
                    withAttributes: technicsAttributes as [NSAttributedString.Key : Any]
                )
            }
            
            // поле Техника
            drawStr(number: technics, x: 180, y: 560)
            // поле Харизма
            drawStr(number: charisma, x: 750, y: 560)
            // поле Мастерство
            drawStr(number: skill, x: 180, y: 770)
            // поле Артистизм
            drawStr(number: artistry, x: 750, y: 770)
            // поле имя
            let statusAttributes = [
                NSAttributedString.Key.font : UIFont.init(name: "v_Billy The Flying Robot BB", size: 82),
                NSAttributedString.Key.foregroundColor : UIColor.black
            ]
            let statusSize = status.size(withAttributes: statusAttributes as [NSAttributedString.Key : Any])
            status.draw(
                in: CGRect(x: size.width / 2 - statusSize.width / 2, y: 1420, width: statusSize.width, height: statusSize.height
                ),
                withAttributes: statusAttributes as [NSAttributedString.Key : Any]
            )
            // поле описание
            let nsParStyle = NSMutableParagraphStyle()
            nsParStyle.alignment = .center
            let aboutAttributes = [
                NSAttributedString.Key.font : UIFont.init(name: "v_Billy The Flying Robot BB", size: 60),
                NSAttributedString.Key.foregroundColor : UIColor(red: 68/255, green: 45/255, blue: 0/255, alpha: 1.0),
                NSAttributedString.Key.paragraphStyle : nsParStyle
            ]
            //let aboutSize = about.size(withAttributes: aboutAttributes as [NSAttributedString.Key : Any])
            about.draw(in: CGRect(x: 100, y: 1500, width: 900, height: 400), withAttributes: aboutAttributes as [NSAttributedString.Key : Any])
        
            let profileImage = UIImage(named: imageName)
                    let rectImage = CGRect(x: 290 , y: 830, width: 500, height: 568)
                    //let bezierPath = UIBezierPath(arcCenter: CGPoint(x: rectImage.midX, y: rectImage.midY), radius: 98, startAngle: 0, endAngle: 2.0*CGFloat(Double.pi), clockwise: true)
                    //context.addPath(bezierPath.cgPath)
                    //context.clip()
                    profileImage?.draw(in: rectImage)
            
                    if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
                        UIGraphicsEndImageContext()
                        completion(newImage, nil)
                    }
                    else {
                        UIGraphicsEndImageContext()
                        completion(nil, "Error 1")
                    }
            }
            else {
                completion(nil, "Error 3")
            }
            UIGraphicsEndImageContext()
        }
        
    }
    
    func shareOnInstagram(image:UIImage) {
      PHPhotoLibrary.requestAuthorization({
          (newStatus) in PHPhotoLibrary.shared().performChanges({
                  PHAssetChangeRequest.creationRequestForAsset(from: image)
              }, completionHandler: { success, error in
                  let fetchOptions = PHFetchOptions()
                  fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                  let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                  if let lastAsset = fetchResult.firstObject {
                      let localIdentifier = lastAsset.localIdentifier
                      let u = "instagram://library?LocalIdentifier=" + localIdentifier
                      DispatchQueue.main.async {
                          UIApplication.shared.open(URL(string: u)!, options: [:], completionHandler: nil)
                      }
                  }
              })
      })
    }
