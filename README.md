## Todo Board — Minimalist Task Manager

Todo Board is a lightweight, terminal-based task manager, standalone shell executable. It was designed for those who value a clean, distraction-free workflow and want to manage their daily tasks without leaving the command line.

The core philosophy of this project is practicality and minimalism. Instead of complex interfaces, it uses simple ASCII frames and ANSI colors to keep your list organized, fast, and intuitive.
🚀 Installation

The tool is now a single, portable executable. No complex installers or .bashrc bloat required.
Bash

# Clone the repository
git clone https://github.com/Hocksz/todo-board
cd todo-board

# Grant execution permission
chmod +x todo

# Optional: Install globally to use 'todo' from anywhere
sudo mv todo /usr/local/bin/

⌨️ Commands & Usage

The interface uses a centralized command structure. Everything is managed through the todo binary.
Basic Interaction

    todo — Display the active board

    todo "New task" — Add a task (use quotes for multi-word tasks)

    todo [Category] Task — Categorize your entry (e.g., todo [Urgent] Fix bug)

Management

    todo del X — Remove task by its index number (X)

    todo clear — Wipe the entire board (requires confirmation)

    todo rename My New Board — Change the board title (supports spaces)

    todo credits — Display project metadata and authors

📁 Architecture & Storage
Plaintext

todo-board/
├── todo           # The standalone shell executable
├── README.md      # Project documentation
└── .gitignore     # Git exclusion rules

    System Integration: This tool follows the XDG Base Directory Specification. All persistent data (tasks and titles) is stored in $HOME/.cache/todo/, keeping your home directory clutter-free.

🤝 Credits

Lead Developer: Hocks

Refined by: TypoMustakes

This project is an evolving space for shell scripting mastery. Contributions, forks, and feedback are always welcome.
