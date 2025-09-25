import json;
import os;
with entry {
    TODO_FILE = 'todos.json';
}
"""Load todos from file"""
def load_todos() {
    if os.path.exists(TODO_FILE) {
        with open(TODO_FILE, 'r') as file  {
            return json.load(file);
        }
    }
    return [];
}
"""Save todos to file"""
def save_todos(todos: Any) {
    with open(TODO_FILE, 'w') as file  {
        json.dump(todos, file, indent=2);
    }
}
"""Add a new todo item"""
def add_todo(todos: Any) {
    task = input('Enter your task: ');
    todo = {'id' : (len(todos) + 1) , 'task' : task , 'completed' : False };
    todos.append(todo);
    save_todos(todos);
    print(f" '✓ Added: ' {task} ");
}
"""View all todos"""
def view_todos(todos: Any) {
    if not todos {
        print('No tasks found!');
        return;
    }
    print('\nYour To-Do List:');
    print(('-' * 30));
    for todo in todos {
        status = '✓' if todo['completed'] else '○';
        print(f" {todo['id']} '. [' {status} '] ' {todo['task']} ");
    }
}
"""Mark a todo as completed"""
def complete_todo(todos: Any) {
    view_todos(todos);
    try {
        todo_id = int(input('\nEnter task ID to mark as complete: '));
        for todo in todos {
            if (todo['id'] == todo_id) {
                todo['completed'] = True;
                save_todos(todos);
                print(f" '✓ Completed: ' {todo['task']} ");
                return;
            }
        }
        print('Task ID not found!');
    } except ValueError {
        print('Please enter a valid number!');
    }
}
def main() {
    todos = load_todos();
    while True {
        print('\n=== To-Do List Manager ===');
        print('1. Add Task');
        print('2. View Tasks');
        print('3. Mark Task Complete');
        print('4. Exit');
        choice = input('Choose an option (1-4): ');
        if (choice == '1') {
            add_todo(todos);
        } elif (choice == '2') {
            view_todos(todos);
        } elif (choice == '3') {
            complete_todo(todos);
        } elif (choice == '4') {
            print('Goodbye!');
            break;
        } else {
            print('Invalid choice! Please try again.');
        }
    }
}
with entry {
    if (__name__ == '__main__') {
        main();
    }
}

