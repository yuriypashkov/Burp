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
    
    var maxDb: Float = -160.0
    
    var labelStatus: UILabel!
    var labelAbout: UILabel!
    var mainImage: UIImageView!
    
    var labelVolume: UILabel!
    var labelDuration: UILabel!
    var labelForVolume: UILabel!
    var labelForDuration: UILabel!
    
    var countOfAnimation = 0
    
    
    var testGuys: [String: (String, String)] = ["Bruce": ("about", "imagename")] // вот так в словарь можно вложить и описание, и картинку
    
    var guys: [String: String] = ["Брюс Рыглис": "Своей отрыжкой ты можешь расколоть и гнусного террориста, и гигантский астероид!",
    "Сильвестр Рыглоне": "Твоя отрыжка отправит в нокаут как профессионального боксёра, так и хмыря за соседним столиком.",
    "Стивен Рыгал": "Ты в рыгальной осаде. Плохие парни окружили тебя, но у них нет ни единого шанса.",
    "Джейсон Рыгхэм": "Ты настоящая адреналиново-рыгающая машина. Будь осторожен, без рыгания тебе придет конец!",
    "Жан-Клод Рыг Вам": "Отрыжка в шпагате - вот твой конёк. Всегда помни об этом!",
    "Александр Рыгский": "Пиво внутри, отрыжка снаружи. Ю вона бёрп - летс бёрп!",
    "Данила Рыгловский": "Прости, братан, это не уровень Рыгливуда. Тебе явно нужна ещё пара пив.",
    "Арнольд Шварцрыгер": "Тебя явно прислали из будущего. И тебе нужны новая отрыжка, одежда и ещё одно пиво",
    "Киану Рыгс": "Светлое или тёмное? Выпьешь светлое - и сказке конец. Выберешь тёмное - попадешь в страну чудес и отрыжки. Но запомни одно - ты Избранный.",
    "Джон Рыголта": "Ты крепкий специалист в области отрыжки, весёлых танцев в носках и спасении обнюханных женщин.",
    "Мухаммед Рыгли": "Рыгай как бабочка, жаль что ты не очень. Выпей три лагера и попробуй снова.",
    "Рыгакоп": "Сразу слышно, что тебя собрали из остатков человека, объединив с новейшими разработками робототехники. Светлое или тёмное, ты рыгаешь со мной!",
    "Квентин Рыгантино": "Говорят, что ты знаменит максимальным количеством отрыжки в своих работах. Не останавливайся!",
    "Данни Трэхо": "Ты просто отрыжечный пацан. Для тебя даже ничего придумывать не надо.",
    "Рыгающий по лезвию": "Ты главный герой рыгопанка, вычисляешь репликантов по отрыжке. Опасайся Рыгера Х.",
    "Стас Рыгайлов": "Всё для тебя, отрыжка и пивасы. Все девчонки за 40 твои.",
    "Фифти Рыгс": "Ты король рыготного свэга. Тачки, тёлки, брюлики, модная рыгота - это всё ты.",
    "Элвис Рыгcли": "Ты настоящий король рыг-н-ролла. Все визжат, услышав как ты мелодично рыгаешь.",
    "Фрэнк Рыгатра": "Ты совсем рядом с рыготной мафией. Не увлекайся, или твоя джазовая отрыжка не спасет тебя.",
    "Зэ Рыглс": "Ты один стоишь всей рыглпульской четверки. Рыгломания охватила всю планету только благодаря тебе.",
    "Боб Рыглей": "Ты настоящая звезда музыки рыгги. Вавилон падёт!",
    "Леонид Рыгутин": "Хоп-хей лалалей, себе пивка ещё налей. Ты явно парень непохожий на слабака.",
    "Бритни Срыгс": "Упс, ты опять облажался. Сорян, браток.",
    "Мэрилин Рыгло": "Рыгая, ты сохраняешь своё очарование. Отличный повод взять ещё пива.",
    "Оззи Рыгосборн": "Ты настоящий князь тьмы. Продолжай закусывать летучими мышами.",
    "Леонардо Ры Гаприо": "Продолжай в том же духе. Рано или поздно твой Рыгоскар тебя найдет!",
    "Брыг Питт": "Ты - это не твоя работа. Ты это не сколько денег у тебя в банке. Ты - это поющая и танцующая отрыжка этого мира.",
    "Криштиану Рыгалду": "Стоит рядом рыгнуть - и ты уже корчишься от боли. Не надо так, время повзрослеть.",
    "Диего Рыгадона": "Ты обладатель отрыжки бога. Особенно круто, что ты всегда бодрый и веселый.",
    "Фродо Рыгинс": "На тебя можно положиться, ты всегда донесёшь пивко и спасешь Рыгоземье.",
    "Мэл Рыгсон": "Ты хорош в любых амплуа: и безумный  Рыгс, и лейтенант Рыгс, и свободолюбивый Виллем Рыголес. Всё тебе по плечу!",
    "Рыгейрис Рыгорожденная": "Ты дамочка с характером, которая была рождена в отрыжке дракона. Твоё рыгание способно повернуть историю вспять.",
    "Рыгги Поттер": "Ты мальчик, который выпил. Не вытаскивай свою волшебную палочку без надобности.",
    "Железный рыговек": "Гений, миллиардер, плейбой, филантроп.",
    "Рыгомаха": "Твой рыгомантиевый скелет может выдержать многое. Но будь осторожен, Рыгнетто может быть совсем рядом!",
    "Оби Рыг Кеноби": "Почувствуй Силу. Используй Силу. Рыгай.",
    "Рыгзилла": "Ты настоящее рыгающее кайдзю. Kill ‘Em all!",
    "Большой Рыгловски": "Ваше Рыгачество, Эль Рыгачиньо, Рыгакер - называй себя как хочешь, главное не забудь глотнуть коктейль белый рыгский.",
    "Жан Рыгло": "Бом-бом, ну ты француз! Девчонки влюбляются только услышав отголосок твоей отрыжки!",
    "Рыгачу": "Рыгы-рыга! Такой маленький и милый, как и твоя отрыжка.",
    "Алла Рыгачёва": "Ах аррыгино аррыгино, нужно быть крутым для всех. Ты просто примадоннна русской рыгательной сцены",
    "Михаил Крыг": "Ты почти что русский Фрэнк Рыгатра. Хорошие отрыжки для хороших людей.",
    "Рыг и Рвоти": "Рыгаешь за двоих! Ты сразу также громок как старый дед, и также дерзок как молодой внук!",
    "Форрыг Гамп": "Рыгай, Форрыг, рыгай!",
    "Фредди Рыггер": "Твоя отрыжка найдёт свои цели и в ночных кошмарах!",
    "Рыгальт из Рыгии": "Длинноволосый красавчик, орудующий двумя мечами и смертоносной отрыжкой. Берегись нечисть!",
    "Рыголас": "Прекрасное создание, уничтожающее сотню орков в минуту своей отрыжкой.",
    "Чудовище Франкенрыга": "Жуткое создание, слепленное из отрыжек тысячи людей. Оно живо и рыгает!",
    "Астерыгс и Оберыгс": "Ты как будто упал в котёл с рыготным зельем, так сильна твоя отрыжка! Рыгаллия будет свободной!",
    "Рыгальф": "Что может быть лучше, чем отрыгнуть свежим котёнком и запить всё пивком?",
    "Тираннозавр Рыгс": "Доисторическое существо, уничтожающее травоядных мощнейшей отрыжкой. Да-да, это ты!",
    "Папа Рыгский": "Ты главный в своём собственном государстве, помешанном на отрыжке. Аве!",
    "Клинт Рыгсвуд": "Хороший, плохой, рыгающий. За пригоршню орешков к пивку готов прорыгать что-нибудь из Морриконе.",
    "Неверыгятный Рыгк": "Ты готов в любой момент превратиться в отвратительное рыгающее существо зелёного цвета. Не злись, старина!",
    "Губка Рыг Рыготные штаны": "Кто прорыгает на дне океана? Именно этот милый, но отрыгительный парень!",
    "Джон Рыг": "Смертоносный убийца. Известен также как Баба Рыга. Не трожь его пса!",
    "Рыгабло": "Ты рыгающий демон, вылезший в Рыгуарий из бездны ада, чтобы уничтожить всё живое.",
    "Конор МакРыгор": "Ты прям звезда РыгЭфСи, самый провокационный рыгатор в легком весе.",
    "Майк Рыгсон": "Ты можешь откусить человеку ухо, отрыгнуть, сесть в тюрьму и всё равно будешь лучшим!",
    "Антонио Бандерыгс": "Ты настоящий Эль Маррыгачи, красавец и ловелас!",
    "Доктор Рыгус": "Судя по всему, у тебя рыгчанка! Срочно надо взять пункцию отрыжки. И пиво!",
    "Граф Дрыгула": "Вместо пивка ты требуешь пинту кровушки, но отрыжку это не портит!",
    "Рыгулху": "Ты похож на древнего монстра, лежащего на дне океана и ждущего как бы разрушить мир своей рыготой.",
    "Рыгакл": "В тебе течёт кровь богов, так что совершить двенадцать отрыжечных подвигов для тебя раз плюнуть!",
    "Рыгина Рыговицкая": "Ты главарь самого рыготного шабаша на свете. Настоящий Рыгающий дьявол в женском обличии.",
    "Рыгги Поп": "Я просто хочу быть твоей отрыжкой, так погнали!",
    "Чак Рыггис": "Ты настоящий рыгахский рейнджер. Услышав твою отрыжку все резко учатся делить на ноль.",
    "Лемми Рыгмистер": "В твоей рыг-колоде всегда найдётся туз пик. Уважаемый человек, твоя харизма говорит сама за себя!",
    "Мик Рыггер": "Ты явно любитель красить двери в чёрный и рыгать на них. Завязывай с этим, браток.",
    "Ры Геварра": "Ты рыгаешь, а все слышат: «Но пасаран! Рыга Ля Куба!»",
    "Царь Рыгонид": "Ну вы поняли...",
    "Рыгопатра": "Красота твоего рыгания сводит с ума всех вокруг. Никому не устоять перед этой магией.",
    "Жанна Д'Рыг": "«Франция будет свободной!» - рыгаешь ты. Опасайся открытого огня, кстати.",
    "Фрида Рыгло": "Твоя отрыжка - настоящий шедевр, достойный самых известных музеев современного искусства.",
    "Старуха Рыгокляк": "Твоей хорошей отрыжкой можно прославиться. Не то что хорошими делами, это каждый знает!",
    "Рыгатерина II": "Поумерь свои аппетиты. Фавориты и пиво это, конечно, классно, но и о простом люде забывать не стоит.",
    "Рыгли Квинн": "Твоя отрыжка выдаёт в тебе оторву-суперзлодейку. Укради ещё пивка себе и друзьям!",
    "Скарлет О'Рыга": "Рыгать рыгай, но только смотри, чтобы тебя не унесло ветром!",
    "Ерыгзавета I": "Твоя величественная отрыжка явно знатных кровей. В твоих руках целая империя. Империя пива!",
    "Эллен Рыгли": "Своей отрыжкой ты способна победить даже Рыголеву Чужих. А ещё ты отлично управляешься со всеми видами огненных жидкостей.",
    "Рыгадриэль": "Отрыжка самой могущественной из эльфийских вождей, владычицы Рыголориэна. Рыгоземье может спать спокойно.",
    "Фаина Рыгевская": "Уж сколько лет прошло, а твою отрыжку до сих пор цитируют как в рыготных кабаках, так и в высшем свете!",
    "Рыгафисента": "Отрыжка милой юной феи, лёгкая и прелестная.",
    "Роза Рыгсенбург": "Твоя отрыжка приводит в ужас проклятых буржуев-капиталистов. Будь осторожна, жандармы могут быть повсюду!",
    "Рыголева Чужих": "В твоей отрыжке вся мощь и ужас роя рыгоморфов. Но опасайся женщин с огнемётами, они хитры и коварны!"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(testGuys["Bruce"]!.1)
        
        // добавим одно значение в массив чтобы не было ошибок при касании на долю секунды по кнопке
        arrayOfDb.append(-150.0)
        
        var sum: Float = 0
        for db in arrayOfDb {
            if db >= -150 {
                sum += db
                //print(db)
            }
        }
        maxDb = sum / Float(arrayOfDb.count)
        
        getCharacter()
        //print("dB = \(maxDb + 200)")
        //print("Duration = \(burpDuration)")
        
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
            labelStatus.adjustsFontSizeToFitWidth = true
            labelStatus.minimumScaleFactor = 0.5
            
            // описание
            labelAbout = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 150))
            labelAbout.center = CGPoint(x: view.frame.size.width / 2, y: 3.2 * view.frame.size.height / 4)
            labelAbout.textAlignment = .center
            labelAbout.text = String(about).uppercased()
            labelAbout.textColor = UIColor(red: 68/255, green: 45/255, blue: 0/255, alpha: 1.0)
            labelAbout.numberOfLines = 4
            labelAbout.font = UIFont.init(name: "v_Billy The Flying Robot BB", size: aboutSize)
            labelAbout.adjustsFontSizeToFitWidth = true
            labelAbout.minimumScaleFactor = 0.5
            
        }
        
        func createVolumeAndDuration(fontSize: CGFloat) {
            // надпись Громкость
            labelForVolume = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
            labelForVolume.center = CGPoint(x: view.frame.size.width / 6, y: view.frame.size.height / 2)
            labelForVolume.textAlignment = .center
            labelForVolume.text = "ШУМ"
            labelForVolume.textColor = .black
            labelForVolume.font = UIFont.init(name: "v_Billy The Flying Robot BB", size: fontSize + 4)
            
            // значение громкость
            labelVolume = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
            labelVolume.center = CGPoint(x: view.frame.size.width / 6, y: view.frame.size.height / 2 + 30)
            labelVolume.textAlignment = .center
            let temp = String(format: "%.1f", maxDb + 76)
            labelVolume.text = maxDb == -150.0 ? "0 dB" : "\(temp) dB"
            labelVolume.textColor = UIColor(red: 68/255, green: 45/255, blue: 0/255, alpha: 1.0)
            labelVolume.font = UIFont.init(name: "v_Billy The Flying Robot BB", size: fontSize)
            
            // Надпись Время
            labelForDuration = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
            labelForDuration.center = CGPoint(x: 5 * view.frame.size.width / 6, y: view.frame.size.height / 2)
            labelForDuration.textAlignment = .center
            labelForDuration.text = "ВРЕМЯ"
            labelForDuration.textColor = .black
            labelForDuration.font = UIFont.init(name: "v_Billy The Flying Robot BB", size: fontSize + 4)
            
            // значение время
            let tempDuration = String(format: "%.1f", burpDuration)
            labelDuration = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
            labelDuration.center = CGPoint(x: 5 * view.frame.size.width / 6, y: view.frame.size.height / 2 + 30)
            labelDuration.textAlignment = .center
            labelDuration.text = "\(tempDuration) с."
            labelDuration.textColor = UIColor(red: 68/255, green: 45/255, blue: 0/255, alpha: 1.0)
            labelDuration.font = UIFont.init(name: "v_Billy The Flying Robot BB", size: fontSize)
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
            
            createVolumeAndDuration(fontSize: 22)

        }
        // для остальных побольше
        else {
            createRounds(withRadius: 45)
            createLabelsAndImage(labelMargin: 60)
            
            // картинка
            mainImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 180, height: 204))
            mainImage.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
            mainImage.image = UIImage(named: imageName)
            
            createStatusAndAbout(width: 315, statusSize: 32, aboutSize: 20)
            
            createVolumeAndDuration(fontSize: 26)
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
        
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }
        
        restartButton.layer.cornerRadius = restartButton.frame.width / 2
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        countOfAnimation += 1
        if countOfAnimation >= 4 {
            view.addSubview(labelStatus)
            view.addSubview(labelAbout)
            view.addSubview(mainImage)
            view.addSubview(labelVolume)
            view.addSubview(labelForVolume)
            view.addSubview(labelForDuration)
            view.addSubview(labelDuration)
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
        let tempDb = 150 + maxDb
        switch tempDb {
        case 0..<105:
            technics = (100 * Double.random(in: 0.1...0.8)).rounded() / 100
            artistry = (100 * Double.random(in: 0.1...0.8)).rounded() / 100
            skill = (100 * Double.random(in: 0.1...0.8)).rounded() / 100
            charisma = (100 * Double.random(in: 0.1...0.8)).rounded() / 100
        case 105..<110:
            technics = (100 * Double.random(in: 0.5...2.0)).rounded() / 100
            artistry = (100 * Double.random(in: 0.5...2.0)).rounded() / 100
            skill = (100 * Double.random(in: 0.5...2.0)).rounded() / 100
            charisma = (100 * Double.random(in: 0.5...2.0)).rounded() / 100
        case 110..<115:
            technics = (100 * Double.random(in: 1.5...3.0)).rounded() / 100
            artistry = (100 * Double.random(in: 1.5...3.0)).rounded() / 100
            skill = (100 * Double.random(in: 1.5...3.0)).rounded() / 100
            charisma = (100 * Double.random(in: 1.5...3.0)).rounded() / 100
        case 115..<120:
            technics = (100 * Double.random(in: 3.0...5.5)).rounded() / 100
            artistry = (100 * Double.random(in: 3.0...5.5)).rounded() / 100
            skill = (100 * Double.random(in: 3.0...5.5)).rounded() / 100
            charisma = (100 * Double.random(in: 3.0...5.5)).rounded() / 100
        case 120..<125:
            technics = (100 * Double.random(in: 5.0...6.0)).rounded() / 100
            artistry = (100 * Double.random(in: 5.0...6.0)).rounded() / 100
            skill = (100 * Double.random(in: 5.0...6.0)).rounded() / 100
            charisma = (100 * Double.random(in: 5.0...6.0)).rounded() / 100
        case 125..<130:
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
            technics += (100 * Double.random(in: 0.5...0.7)).rounded() / 100
            artistry += (100 * Double.random(in: 0.5...0.7)).rounded() / 100
            skill += (100 * Double.random(in: 0.5...0.7)).rounded() / 100
            charisma += (100 * Double.random(in: 0.5...0.7)).rounded() / 100
        case 3..<5:
            technics += (100 * Double.random(in: 0.7...1.0)).rounded() / 100
            artistry += (100 * Double.random(in: 0.7...1.0)).rounded() / 100
            skill += (100 * Double.random(in: 0.7...1.0)).rounded() / 100
            charisma += (100 * Double.random(in: 0.7...1.0)).rounded() / 100
        case 5..<9:
            technics += (100 * Double.random(in: 1.0...2.0)).rounded() / 100
            artistry += (100 * Double.random(in: 1.0...2.0)).rounded() / 100
            skill += (100 * Double.random(in: 1.0...2.0)).rounded() / 100
            charisma += (100 * Double.random(in: 1.0...2.0)).rounded() / 100
        default:
            technics += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            artistry += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            skill += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
            charisma += (100 * Double.random(in: 0.1...0.5)).rounded() / 100
        }
        characterSum = technics + artistry + skill + charisma
        //characterSum = 3
        switch characterSum {
            
        // first range
        case 0..<4:
            status = "Данила Рыгловский"
            imageName = "danila_ryglovsky"
        case 4..<4.4:
            status = "Александр Рыгский"
            imageName = "rygskiy"
        case 4.4..<4.8:
            status = "Бритни Срыгс"
            imageName = "britney_srygs"
        case 4.8..<5.2:
            status = "Стивен Рыгал"
            imageName = "rygal"
        case 5.2..<5.6:
            status = "Рыгина Рыговицкая"
            imageName = "rygovitskaya"
        case 5.6..<6:
            status = "Рыгальф"
            imageName = "rygalf"
        case 6..<6.4:
            status = "Губка Рыг Рыготные штаны" 
            imageName = "gubka_ryg"
        case 6.4..<6.8:
            status = "Криштиану Рыгалду"
            imageName = "rigaldu"
        case 6.8..<7.2:
            status = "Рыгафисента"
            imageName = "rygafisenta"
        case 7.2..<7.6:
            status = "Рыгачу"
            imageName = "rygachu"
        case 7.6..<8:
            status = "Мухаммед Рыгли"
            imageName = "muh_rygly"
        case 8..<8.4:
            status = "Рыгли Квинн"
            imageName = "rygley_qnn"
        case 8.4..<8.8:
            status = "Мик Рыггер"
            imageName = "mic_ryger"
        case 8.8..<9.2:
            status = "Жанна Д'Рыг"
            imageName = "zhanna_dryg"
        case 9.2..<9.6:
            status = "Рыгатерина II"
            imageName = "rygaterina_second"
        case 9.6..<10:
            status = "Конор МакРыгор"
            imageName = "connor"
            
        //second range
        case 10..<10.5:
            status = "Сильвестр Рыглоне"
            imageName = "ryglone"
        case 10.5..<11:
            status = "Жан-Клод Рыг Вам"
            imageName = "ryg_vamm"
        case 11..<11.5:
            status = "Мэрилин Рыгло"
            imageName = "mer_ryglo"
        case 11.5..<12:
            status = "Рыгомаха"
            imageName = "rygomaha"
        case 12..<12.5:
            status = "Жан Рыгло"
            imageName = "ryglo"
        case 12.5..<13:
            status = "Михаил Крыг"
            imageName = "kryg"
        case 13..<13.5:
            status = "Скарлет О'Рыга"
            imageName = "scarlet_ryga"
        case 13.5..<14:
            status = "Фредди Рыггер"
            imageName = "freddy_ryger"
        case 14..<14.5:
            status = "Чудовище Франкенрыга"
            imageName = "frankenryga"
        case 14.5..<15:
            status = "Фрида Рыгло"
            imageName = "frida_ryglo"
        case 15..<15.5:
            status = "Папа Рыгский"
            imageName = "papa_rygskiy"
        case 16..<16.5:
            status = "Форрыг Гамп"
            imageName = "forryg_gump"
        case 16.5..<17:
            status = "Стас Рыгайлов"
            imageName = "rygailov"
        case 17..<17.5:
            status = "Доктор Рыгус"
            imageName = "rygaus"
        case 17.5..<18:
            status = "Граф Дрыгула"
            imageName = "rygacula"
        case 18..<18.3:
            status = "Рыгги Поп"
            imageName = "ryggy_pop"
        case 18.3..<18.6:
            status = "Рыгопатра"
            imageName = "rygopatra"
        case 18.6..<19:
            status = "Старуха Рыгокляк"
            imageName = "rygoklyak"
            
        // third range
        case 19..<19.5:
            status = "Фифти Рыгс"
            imageName = "50_rygs"
        case 19.5..<20:
            status = "Элвис Рыгcли"
            imageName = "rygsley"
        case 20..<20.5:
            status = "Фрэнк Рыгатра"
            imageName = "rygatra"
        case 20.5..<21:
            status = "Боб Рыглей"
            imageName = "rygley"
        case 21..<21.5:
            status = "Леонид Рыгутин"
            imageName = "rygutin"
        case 21.5..<22:
            status = "Брыг Питт"
            imageName = "bryg_pitt"
        case 22..<22.5:
            status = "Диего Рыгадона"
            imageName = "rygadona"
        case 22.5..<23:
            status = "Рыгейрис Рыгорожденная"
            imageName = "ryggeris"
        case 23..<23.5:
            status = "Железный рыговек"
            imageName = "iron_rygovek"
        case 23.5..<24:
            status = "Оби Рыг Кеноби"
            imageName = "ryg_kenobi"
        case 24..<24.5:
            status = "Большой Рыгловски"
            imageName = "ryglovsky"
        case 24.5..<25:
            status = "Рыголас"
            imageName = "rygolas"
        case 25..<25.3:
            status = "Джон Рыг"
            imageName = "john_ryg"
        case 25.3..<25.6:
            status = "Рыгакл"
            imageName = "rygakl"
        case 25.6..<25.9:
            status = "Ерыгзавета I"
            imageName = "ryglyveta_first"
        case 25.9..<26.2:
            status = "Ры Геварра"
            imageName = "ry_gevarra"
        case 26.2..<26.6:
            status = "Эллен Рыгли"
            imageName = "rigley"
        case 26.6..<27:
            status = "Царь Рыгонид"
            imageName = "rygonid"
            
        //fourth range
        case 27..<27.3:
            status = "Джон Рыголта"
            imageName = "rygolta"
        case 27.3..<27.6:
            status = "Рыгакоп"
            imageName = "rygocop"
        case 27.9..<28.2:
            status = "Фаина Рыгевская"
            imageName = "rygevskaya"
        case 28.2..<28.5:
            status = "Квентин Рыгантино"
            imageName = "rygantino"
        case 28.5..<28.8:
            status = "Рыгающий по лезвию"
            imageName = "ryg_runner"
        case 28.8..<29.1:
            status = "Роза Рыгсенбург"
            imageName = "rygsenburg"
        case 29.1..<29.4:
            status = "Зэ Рыглс"
            imageName = "rygls"
        case 29.4..<29.7:
            status = "Оззи Рыгосборн"
            imageName = "ozzi"
        case 29.7..<30:
            status = "Леонардо Ры Гаприо"
            imageName = "leo_rygaprio"
        case 30..<30.3:
            status = "Фродо Рыгинс"
            imageName = "frodo_ryggins"
        case 30.3..<30.6:
            status = "Мэл Рыгсон"
            imageName = "rygson"
        case 30.6..<30.9:
            status = "Рыгги Поттер"
            imageName = "ryggy_potter"
        case 30.9..<31.2:
            status = "Алла Рыгачёва"
            imageName = "rygachova"
        case 31.2..<31.5:
            status = "Рыгальт из Рыгии"
            imageName = "rygalt"
        case 31.5..<31.8:
            status = "Астерыгс и Оберыгс"
            imageName = "asterygs"
        case 31.8..<32.1:
            status = "Майк Рыгсон"
            imageName = "mike_rygson"
        case 32.1..<32.4:
            status = "Антонио Бандерыгс"
            imageName = "rygeros"
        case 32.4..<32.7:
            status = "Рыгадриэль"
            imageName = "rygadriel"
            
        // fifth range 0.2
        case 32.7..<33:
            status = "Неверыгятный Рыгк"
            imageName = "rygalk"
        case 33..<33.3:
            status = "Джейсон Рыгхэм"
            imageName = "ryghem"
        case 33.3..<33.6:
            status = "Арнольд Шварцрыгер"
            imageName = "scvarcrigley"
        case 33.6..<33.9:
            status = "Чак Рыггис"
            imageName = "chak_ryggys"
        case 33.9..<34.2:
            status = "Рыголева Чужих"
            imageName = "rygoleva"
        case 34.2..<34.5:
            status = "Лемми Рыгмистер"
            imageName = "lemmy"
            charisma = 10
        case 34.5..<34.8:
            status = "Рыг и Рвоти"
            imageName = "ryg_rvoti"
        case 34.8..<35.1:
            status = "Рыгулху"
            imageName = "rygulhu"
        case 35.1..<35.4:
            status = "Рыгабло"
            imageName = "rygablo"
        case 35.4..<35.7:
            status = "Тираннозавр Рыгс"
            imageName = "rygs"
        case 35.7..<36:
            status = "Рыгзилла"
            imageName = "rygzilla"
        case 36..<36.3:
            status = "Киану Рыгс"
            imageName = "kianu_rygs"
        case 36.3..<36.6:
            status = "Данни Трэхо"
            imageName = "rygeho"
        case 36.6..<36.9:
            status = "Клинт Рыгсвуд"
            imageName = "rygswood"
            
        default:
            status = "Брюс Рыглис"
            imageName = "ryglis"
        }
        
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
        if UIGraphicsGetCurrentContext() != nil {
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
            var statusAttributes = [NSAttributedString.Key : NSObject?]()
            if String(status).count < 20 {
                statusAttributes = [
                    NSAttributedString.Key.font : UIFont.init(name: "v_Billy The Flying Robot BB", size: 82),
                    NSAttributedString.Key.foregroundColor : UIColor.black
                    ]
            } else {
               statusAttributes = [
                    NSAttributedString.Key.font : UIFont.init(name: "v_Billy The Flying Robot BB", size: 72),
                    NSAttributedString.Key.foregroundColor : UIColor.black
                    ]
            }
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
                NSAttributedString.Key.font : UIFont.init(name: "v_Billy The Flying Robot BB", size: 54),
                NSAttributedString.Key.foregroundColor : UIColor(red: 68/255, green: 45/255, blue: 0/255, alpha: 1.0),
                NSAttributedString.Key.paragraphStyle : nsParStyle
            ]
            //let aboutSize = about.size(withAttributes: aboutAttributes as [NSAttributedString.Key : Any])
            about.draw(in: CGRect(x: 100, y: 1500, width: 900, height: 400), withAttributes: aboutAttributes as [NSAttributedString.Key : Any])
        
            let characterImage = UIImage(named: imageName)
            let rectImage = CGRect(x: 290 , y: 830, width: 500, height: 568)
            characterImage?.draw(in: rectImage, blendMode: .normal, alpha: 1.0)
            
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
          (newStatus) in
              PHPhotoLibrary.shared().performChanges({
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
