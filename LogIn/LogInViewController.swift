
import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet var logInScrollView: UIScrollView!
    
    @IBOutlet var logoImageView: UIImageView!
    
    @IBOutlet var bigFieldForTwoTextFieldsImageView: UIImageView!
    
    @IBOutlet var emailOrPhoneTextField: UITextField!
        
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    
    private let wrapperView = UIView()
    
    var authorizationDelegate: LoginViewControllerDelegate?
    
    var handle: AuthStateDidChangeListenerHandle?
    
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //выставляем все Views
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailOrPhoneTextField.becomeFirstResponder()
    }
    
    
    private func setupViews(){
        
        authorizationDelegate = LoginInspector()
        
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
        
                   Auth.auth().removeStateDidChangeListener(handle!)
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if user != nil {
                print("User e-mail: \(String(describing: user?.email))")
            }
        }
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
    
    @objc private func logInButtonPressed() {
                                
        /// Check that delegate is not nil
                guard self.authorizationDelegate != nil else {
                    warning.text = "Authorization delegate is nil"
                    return
                }
                
                guard let email = emailOrPhoneTextField.text, !email.isEmpty,
                      let passwd = passwordTextField.text, !passwd.isEmpty else {
                    warning.text = "Please input login and password"
                    return
                }
                
                /// Check that login is not empty
                guard let login = emailOrPhoneTextField.text, login != "" else {
                    warning.text = "Please input login"
                    return
                }
                
                /// Check that password is not empty
                guard let password = passwordTextField.text, password != "" else {
                    warning.text = "Please input password"
                    return
                }
                
        // Get auth instance
        // attept sign in
        // if failure, present alert to create account
        // if user continues, create account
        
        // check sign in on app launch
        
                FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password, completion: { [weak self] result, error in
                    
                    guard let strongSelf = self else {
                        return
                    }
                    
                    guard error == nil else {
                        // show account creation
                        strongSelf.showCreateAccounts(email: login, password: password)
                        return
                    }
                    
                    print ("You have signed in")
                    
                    // Go to PostsViewController
                    strongSelf.pushToPostViewController()
                    
                })
    }
    
    func showCreateAccounts(email: String, password: String){
        
        let alert = UIAlertController(title: "Create Account",
                                      message: "Would You like to create an account?",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .default,
                                      handler: { _ in
                                        
                                        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                                            
                                            guard let strongSelf = self else {
                                                return
                                            }
                                            
                                            guard error == nil else {
                                                // show account creation
                                                print ("Account creation failed")
                                                return
                                            }
                                            print ("You have signed in")
                                            
                                            // Go to PostsViewController
                                            strongSelf.pushToPostViewController()
                                        })
                                      }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: { _ in
                                      }))
        present(alert, animated: true)
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
