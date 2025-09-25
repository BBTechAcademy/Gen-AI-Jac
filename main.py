import json
import os

TODO_FILE = "todos.json"

def load_todos():
    """Load todos from file"""
    if os.path.exists(TODO_FILE):
        with open(TODO_FILE, 'r') as file:
            return json.load(file)
    return []

def save_todos(todos):
    """Save todos to file"""
    with open(TODO_FILE, 'w') as file:
        json.dump(todos, file, indent=2)

def add_todo(todos):
    """Add a new todo item"""
    task = input("Enter your task: ")
    todo = {
        "id": len(todos) + 1,
        "task": task,
        "completed": False
    }
    todos.append(todo)
    save_todos(todos)
    print(f"✓ Added: {task}")

def view_todos(todos):
    """View all todos"""
    if not todos:
        print("No tasks found!")
        return
    
    print("\nYour To-Do List:")
    print("-" * 30)
    for todo in todos:
        status = "✓" if todo["completed"] else "○"
        print(f"{todo['id']}. [{status}] {todo['task']}")

def complete_todo(todos):
    """Mark a todo as completed"""
    view_todos(todos)
    try:
        todo_id = int(input("\nEnter task ID to mark as complete: "))
        for todo in todos:
            if todo["id"] == todo_id:
                todo["completed"] = True
                save_todos(todos)
                print(f"✓ Completed: {todo['task']}")
                return
        print("Task ID not found!")
    except ValueError:
        print("Please enter a valid number!")

def main():
    todos = load_todos()
    
    while True:
        print("\n=== To-Do List Manager ===")
        print("1. Add Task")
        print("2. View Tasks")
        print("3. Mark Task Complete")
        print("4. Exit")
        
        choice = input("Choose an option (1-4): ")
        
        if choice == "1":
            add_todo(todos)
        elif choice == "2":
            view_todos(todos)
        elif choice == "3":
            complete_todo(todos)
        elif choice == "4":
            print("Goodbye!")
            break
        else:
            print("Invalid choice! Please try again.")

if __name__ == "__main__":
    main()