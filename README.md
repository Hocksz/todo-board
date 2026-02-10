Markdown

# Todo Board — Minimalist Task Manager

**Todo Board** is a lightweight, terminal-based task manager built with Bash. It was designed for those who value a clean, distraction-free workflow and want to manage their daily tasks without leaving the command line.

The core philosophy of this project is **practicality and minimalism**. Instead of complex interfaces, it uses simple ASCII frames and ANSI colors to keep your list organized, fast, and intuitive.

---

## 🚀 Installation

```bash
git clone [https://github.com/Hocksz/todo-board](https://github.com/Hocksz/todo-board)
cd todo-board
chmod +x install.sh
./install.sh
source ~/.bashrc
```
---
⌨️ Commands & Usage
Basic Interaction

    todo — View the active board

    todo [Task] — Add a quick task

    todo [Title] Task — Add a task with a specific category

---
Management

    todo-del X — Remove task by number (X)

    todo-clear — Clear the entire board

    rename-todo "Name" — Change the board's title

    credits-todo — Show author and project info

---
📁 Repository Structure
``` 
todo-board/
├── install.sh
├── README.md
└── .config/
    └── scripts/
        └── todo.sh
```

This tool is a space for me to learn and improve my scripting skills. Feel free to explore, take inspiration, or adapt it to your own setup.
