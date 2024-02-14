//
//  NewTaskViewController.swift
//  Lesson_3.36_6
//
//  Created by Dmitry Parhomenko on 13.02.2024.
//

import UIKit

///. 12
final class NewTaskViewController: UIViewController {
    /// 14. Создаем taskTextField через ленивую переменную  и сразу ей присваиваем значение
    /// =  { значение } и его сразу инициализируем () --> = {...}()   т.е. мы создаем объект сразу
    /// с настраиваемыми параметрами
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        /// отключаем параметр, что бы отвязаться от StoryBoard (для работы с констрейтами)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    /// 20. Создаем кнопку "Save Task"
    private lazy var saveButton: UIButton = {
        /// Устанавиваем атрибуты для реботы с текстом
        var attributes = AttributeContainer()
        /// задаем жирный текст размер 18
        attributes.font = UIFont.boldSystemFont(ofSize: 18)
        
        /// Создаем объект конфигурации для настройки параметров кнопки
        /// для UIButton эьл структура Сonfiguration (.filled синяя кнопка)
        var buttonConfig = UIButton.Configuration.filled()
        /// фон кнопки
        buttonConfig.baseBackgroundColor = .lightGreen
        ///  Конфигурируем текст кнопки на онове параметров attributes
        buttonConfig.attributedTitle = AttributedString("Save Task", attributes: attributes)
        /// Присваиваем buttonConfig для кнопки button
        /// в UIAction прописываем наше действие save()
        let button = UIButton(configuration: buttonConfig, primaryAction: UIAction { [unowned self] _ in
            save()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// 23. Создаем кнопку "Cancel" по аналогии 20.
    private lazy var cancelButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 18)
        
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.baseBackgroundColor = .lightRed
        buttonConfig.attributedTitle = AttributedString("Cancel", attributes: attributes)
        let button = UIButton(configuration: buttonConfig, primaryAction: UIAction { [unowned self] _ in
            save()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    ///13.
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        /// 16. Размещаем taskTextField на view через специально для этого созданным
        /// методом  privateSubviews
        privateSubviews(taskTextField, saveButton, cancelButton)
        /// 19. Метод размещения taskTextField
        ///  ВАЖНО последовательность --> сначала 16. за ним 19. !!!
        setConstraints()
    }
    
    /// 21. Метод для кнопки "Save Task"
    private func save() {
        /// закрываем экран
        dismiss(animated: true)
    }
}

//MARK: - Setup UI
private extension NewTaskViewController {
    ///17. метод размещения наших subviews на UIView
    func privateSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    /// 18. Метод работы с констрейтами
    func setConstraints() {
        NSLayoutConstraint.activate([
                /// задаем констрейт от верха нашего текстового поля (taskTextField.topAnchor)
                /// до верха View ( equalTo: view.topAnchor) и значение 80
                taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
                /// левый край
                taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                ///правый край
                taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)])
        /// 22. Размещаем кнопку "Save Task"
        NSLayoutConstraint.activate([
                saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
                saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            ])
        /// 24. Размещаем кнопку "Cancel"
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            ])
    }
}

/// 15.
#Preview {
    NewTaskViewController()
}
