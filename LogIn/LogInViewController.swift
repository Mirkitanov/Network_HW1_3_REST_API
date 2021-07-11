import UIKit
import RealmSwift

class LogInViewController: UIViewController {
    
    @IBOutlet var logInScrollView: UIScrollView!
    
    @IBOutlet var logoImageView: UIImageView!
    
    @IBOutlet var bigFieldForTwoTextFieldsImageView: UIImageView!
    
    @IBOutlet var emailOrPhoneTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    
    private let wrapperView = UIView()
    
    var authorizationDelegate: LoginViewControllerDelegate?
    
    var currentUserIndex: Int?
    
    var warning: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warning.text = ""
        
        authorizationDelegate = LoginInspector()
        
        guard let allUsers = authorizationDelegate?.checkUsers() else {
            return
        }
        
        print("All users: \(String(describing: allUsers.self))")
        
        if  !allUsers.isEmpty {
            
            for (index, user) in allUsers.enumerated() {
                
                if user.isCurrentUser == true {
                    currentUserIndex = index
                    print("Current User: \(String(describing: allUsers[index]))")
                    warning.text = "Выполняется вход"
                    pushToPostViewController()
                    break
                }
            }
            
        } else {
            
            warning.text = "Введите Логин и Пароль"
        }
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailOrPhoneTextField.becomeFirstResponder()
    }

    private func setupViews(){
        
        navigationController?.navigationBar.isHidden = true
        
        let longLine: UIView = {
            let line = UIView()
            line.backgroundColor = .lightGray
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()
        
        logInScrollView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        bigFieldForTwoTextFieldsImageView.translatesAutoresizingMaskIntoConstraints = false
        emailOrPhoneTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        logInScrollView.contentInsetAdjustmentBehavior = .automatic
        logInScrollView.backgroundColor = .white
        
        logoImageView.image = #imageLiteral(resourceName: "logo")
        
        bigFieldForTwoTextFieldsImageView.backgroundColor = .systemGray6
        bigFieldForTwoTextFieldsImageView.layer.cornerRadius = 10
        bigFieldForTwoTextFieldsImageView.layer.borderWidth = 0.5
        bigFieldForTwoTextFieldsImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.setTitleColor(.darkGray, for: .selected)
        logInButton.setTitleColor(.darkGray, for: .highlighted)
        logInButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        logInButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        logInButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        logInButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        logInButton.layer.cornerRadius = 10
        logInButton.layer.masksToBounds = true
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        
        view.addSubview(logInScrollView)
        logInScrollView.addSubview(wrapperView)
        wrapperView.addSubviews(logoImageView,
                                bigFieldForTwoTextFieldsImageView,
                                emailOrPhoneTextField,
                                passwordTextField,
                                logInButton,
                                longLine,
                                warning
        )
        
        let constraints = [
            logInScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logInScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logInScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            logInScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            wrapperView.topAnchor.constraint(equalTo: logInScrollView.topAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: logInScrollView.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: logInScrollView.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: logInScrollView.bottomAnchor),
            wrapperView.widthAnchor.constraint(equalTo: logInScrollView.widthAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            
            bigFieldForTwoTextFieldsImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            bigFieldForTwoTextFieldsImageView.heightAnchor.constraint(equalTo: logoImageView.heightAnchor, constant: 0),
            bigFieldForTwoTextFieldsImageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            bigFieldForTwoTextFieldsImageView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            
            emailOrPhoneTextField.topAnchor.constraint(equalTo: bigFieldForTwoTextFieldsImageView.topAnchor, constant: 16),
            emailOrPhoneTextField.leadingAnchor.constraint(equalTo: bigFieldForTwoTextFieldsImageView.leadingAnchor, constant: 16),
            emailOrPhoneTextField.trailingAnchor.constraint(equalTo: bigFieldForTwoTextFieldsImageView.trailingAnchor, constant: -16),
            
            passwordTextField.bottomAnchor.constraint(equalTo: bigFieldForTwoTextFieldsImageView.bottomAnchor, constant: -16),
            passwordTextField.leadingAnchor.constraint(equalTo: bigFieldForTwoTextFieldsImageView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: bigFieldForTwoTextFieldsImageView.trailingAnchor, constant: -16),
            
            longLine.topAnchor.constraint(equalTo: bigFieldForTwoTextFieldsImageView.topAnchor, constant: 49.75),
            longLine.leadingAnchor.constraint(equalTo: bigFieldForTwoTextFieldsImageView.leadingAnchor),
            longLine.trailingAnchor.constraint(equalTo: bigFieldForTwoTextFieldsImageView.trailingAnchor),
            longLine.bottomAnchor.constraint(equalTo: bigFieldForTwoTextFieldsImageView.bottomAnchor, constant: -49.75),
            
            warning.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            warning.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Keyboard observers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        emailOrPhoneTextField.text = ""
        passwordTextField.text = ""
        warning.text = "Введите Логин и Пароль"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            logInScrollView.contentInset.bottom = keyboardSize.height
            logInScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        logInScrollView.contentInset.bottom = .zero
        logInScrollView.verticalScrollIndicatorInsets = .zero
    }
    
    // MARK: - Auth
    @objc private func logInButtonPressed() {
        
        warning.text = ""
        
        guard let userDelegate = authorizationDelegate else {
            warning.text = "Authorization delegate is nil"
            return
        }
        
        guard let login = emailOrPhoneTextField.text,
              let password = passwordTextField.text else {
            warning.text = "Введите Логин и Пароль"
            return
        }
        
        guard let users = authorizationDelegate?.checkUsers() else {
            warning.text = "Incorrect data"
            return
        }
        
        func createNewUser(){
            
            if userDelegate.creteUser(id: UUID().uuidString, login: emailOrPhoneTextField.text, password: passwordTextField.text, failure: self.showAlert) {
                self.warning.text = "Выполняется вход"
                print("Вход выполнен успешно")
                print ("Новый пользователь. Логин - \(String(describing: emailOrPhoneTextField.text!)). Пароль - \(String(describing: passwordTextField.text!))")
                
                pushToPostViewController()
                
            } else {
                warning.text = "Введите Логин и Пароль"
                return
            }
        }
        
        func showCreateAccounts(email: String, password: String){
            
            let alert = UIAlertController(title: "Создать Аккаунт",
                                          message: "Вы желаете создать аккаунт?",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Продолжить",
                                          style: .default,
                                          handler: { _ in
                                            createNewUser()
                                            self.currentUserIndex = users.count
                                          }))
            alert.addAction(UIAlertAction(title: "Отмена",
                                          style: .cancel,
                                          handler: { _ in
                                          }))
            present(alert, animated: true)
        }
        
        if users.isEmpty{
            warning.text = "Необходимо авторизоваться"
            createNewUser()
            currentUserIndex = 0
            
        }  else {
            
            // Выставляем флаг "Пользователь не найден"
            var userNotFound: Bool = true
            
            
            for (index, user) in users.enumerated() {
                
                if user.login == emailOrPhoneTextField.text && user.password == passwordTextField.text {
                    
                    //Если Пользователь с введенным Логином и Паролем найден, то
                    //Сохраняем значение текущего индекса Пользователя
                    currentUserIndex = index
                    
                    //Выставляем отрицательное значение флага "Пользователь не найден", поскольку Пользователь найден успешно
                    userNotFound = false
                    
                    warning.text = "Выполняется вход"
                    // Выводим в консоль информацию об активном Пользователе
                    print("Вход выполнен успешно")
                    print ("Действующий пользователь. Логин - \(user.login). Пароль - \(user.password)")
                    
                    //Выполняем переход на экран PostViewController()
                    pushToPostViewController()
                    break
                    
                } else {
                    
                    if user.login != emailOrPhoneTextField.text {
                        userNotFound = true
                        
                    } else if user.password != passwordTextField.text {
                        userNotFound = false
                        print("Введеный Логин найден. Пароль введен некорректно. Для входа введите пароль")
                        print ("Найден пользователь с Логином. Логин - \(user.login). Пароль - \(user.password)")
                        warning.text = "Пароль введен неверно"
                        
                        break
                    }
                }
            }
            
            
             // Проходим циклом по всем Пользователям и сбрасываем флаг "Текущий Пользователь"
             for (index, _) in users.enumerated() {
             userDelegate.resetCurrentUser(id: users[index].id)
             }
            
            if userNotFound {
                print("User Not Found!")
                // show account creation
                // Если Пользователь с введенным Логином не найден, предлагаем создать Нового Пользователя
                showCreateAccounts(email: login, password: password)
                
                //При успешном создании нового Пользователя активируем у него флаг "Текущий Пользователь" и запоминаем индекс
                return
            } else {
                // запоминаем индекс
                guard let currentIndex = currentUserIndex else  {
                    return
                }
                
                // Если Пользователь с введенным Логином успешно найден, фиксируем успешно вошедшего пользователя
                print ("Fixing current user: \(users[currentIndex].login)")
                
                //запоминаем id
                let currentId = users[currentIndex].id
                
                // активируем у Пользователя флаг "Текущий Пользователь" и
                userDelegate.setCurrentUser(id: currentId)
            }
        }
    }
    
    func showAlert(error: Errors) {
        var message = ""
        switch error {
        case .incorrectData:
            message = "Введены неверные данные. Введите Пароль"
        case .shortPassword:
            message = "Пароль должен содержать минимум 6 символов"
        case .incorrectEmail:
            message = "Введены неверные данные. Введите Логин"
        case .noData:
            message = "Пожалуйста, введите Логин и Пароль"
        }
        
        let alertController = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK")
        }
        alertController.addAction(okAction)
        navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func pushToPostViewController(){
        
        let postsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PostsViewController")
        self.navigationController?.pushViewController(postsViewController, animated: true)
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
