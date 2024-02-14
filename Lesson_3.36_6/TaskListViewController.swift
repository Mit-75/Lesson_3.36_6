//
//  ViewController.swift
//  Lesson_3.36_6
//
//  Created by Dmitry Parhomenko on 13.02.2024.
//

import UIKit

/// 31. Cоздаем протокол
protocol NewTaskViewControllerDelegate: AnyObject {
    func reloadDate()
}

/// 5. Прописываем название класса и делаем UITableViewController
final class TaskListViewController: UITableViewController {
    
    /// 28. Создаем массив наших сохраненных данных
    private var taskList: [ToDoTask] = []
    private let cellID = "task"


    override func viewDidLoad() {
        super.viewDidLoad()
        /// 29. Задаем (прописываем) в  tableView ячейку cell и её идентефикатор
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        /// 6.
        view.backgroundColor = .systemBackground
        /// 9.
        setupNavigationBar()
        /// 31.
        fetchData()
    }
    
    /// 10. Метод действия кнопки "+"  -->  action: #selector(addNewTask)
    @objc private func addNewTask() {
        /// Cоздаем экземпляр класса куда мы хотим перейти
        let newTaskVC = NewTaskViewController()
        
        /// 34. Инициализируем делегата при переходе
        newTaskVC.delegate = self
        /// Передаем туда наш NewTaskViewController контроллер
        present(newTaskVC, animated: true)
    }
    /// 30. Метод получения записаннных данных
    private func fetchData() {
        /// (Костыль) создаем экземнляр класса AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        /// Задаем запрос к базе данных
        let fetchRequest = ToDoTask.fetchRequest()
        do {
            /// Получаем массив данных из база
            taskList = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
}

///27.
//MARK: - UITableViewDataSours
extension TaskListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let toDoTask = taskList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = toDoTask.title
        cell.contentConfiguration = content
        return cell
    }
}



//MARK: - Setup UI

/// 7.
extension TaskListViewController {
    /// 8.
    func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Navigation Bar Appearance
        /// Создаем объект конфигурации - экземпляр класса UINavigationBarAppearance
        /// который отвечает за настройку конфигурации
        let navBarAppearance = UINavigationBarAppearance()
        /// Метод что бы navBar был не прозрачный
        navBarAppearance.configureWithOpaqueBackground()
        /// цвет NavigationBar задали в Assets (+ Image Set -> создали lightGreen)
        navBarAppearance.backgroundColor = .lightGreen
        /// titleTextAttributes настройка текста со множеством параметров (см. документацию)
        /// .backgroundColor: UIColor.white - устанавливаем белый цвет
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        /// то же для большого текста
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        /// присваиваем наш созданный объект конфигурации нашему NavigationBar
        /// - Для стандартного состояния
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        /// - Для состояния когда находимся в режиме скроллинга
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        // Add button to Navigation bar
        
        /// добавляем кнопку
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            /// метод addNewTask (действия кнопки) создаем сами --> 9.
            action: #selector(addNewTask)
        )
        /// Задаем цве для всех элементов NavigationBar
        navigationController?.navigationBar.tintColor = .white
        
        /// 11.
        // Статус бар меняется в настройках: General -> Deployment info ->
        // Status Bar Stile -> Light Content
        // + Info -> Information property list -> + добавляем ->
        // View controller-based status bar appearance (NO)
        
    }
}
/// 32. Метод получает данные и перегружает tableView
extension TaskListViewController: NewTaskViewControllerDelegate {
    func reloadDate() {
        fetchData()
        tableView.reloadData()
    }
}
