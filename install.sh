#!/bin/bash

# Cores para o instalador
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RESET="\033[0m"

SCRIPT_DIR="$HOME/.config/scripts"
SCRIPT_PATH="$SCRIPT_DIR/todo.sh"
BASHRC="$HOME/.bashrc"

echo -e "${BLUE}➜ Starting Todo Board installation...${RESET}"

# 1. Criar diretório se não existir
mkdir -p "$SCRIPT_DIR"

# 2. Criar o arquivo todo.sh
cat << 'EOF' > "$SCRIPT_PATH"
#!/bin/bash

# --- TODO BOARD SCRIPT ---

todo() {
    local FILE="$HOME/.meu-todo.txt"
    local TITLE_FILE="$HOME/.todo_title"
    touch "$FILE"
    
    local BOARD_NAME=$(cat "$TITLE_FILE" 2>/dev/null || echo "TODO BOARD")

    local BLUE="\033[1;34m"
    local RESET="\033[0m"
    local GRAY="\033[0;90m"
    local YELLOW="\033[1;33m"
    local CYAN="\033[1;36m"
    local DIM_WHITE="\033[0;37m"

    local TOP="┌────────────────────────────────────────────────────────────┐"
    local MID="├────────────────────────────────────────────────────────────┤"
    local BOT="└────────────────────────────────────────────────────────────┘"

    # Help Command
    if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        echo -e "\n  ${YELLOW}COMMANDS:${RESET}"
        echo -e "  ${CYAN}todo [Task]${RESET}          - Add task"
        echo -e "  ${CYAN}todo [Title] Task${RESET}   - Add task with category"
        echo -e "  ${CYAN}todo${RESET}                - View board"
        echo -e "  ${CYAN}todo-del X${RESET}          - Remove task X"
        echo -e "  ${CYAN}todo-clear${RESET}          - Clear all"
        echo -e "  ${CYAN}rename-todo \"Name\"${RESET}  - Rename board"
        echo -e "  ${CYAN}credits-todo${RESET}        - Author info"
        echo ""
        return 0
    fi

    if [ -n "$1" ]; then
        local input_text="$*"
        echo "$(date +'%b %d') | ${input_text}" >> "$FILE"
        echo -e "  ${YELLOW}» Task saved.${RESET}"
    else
        echo -e "${BLUE}${TOP}${RESET}"
        printf "${BLUE}│${RESET}  ➜ ${YELLOW}%-54s${RESET}${BLUE}│${RESET}\n" "$BOARD_NAME"
        echo -e "${BLUE}${MID}${RESET}"

        if [ ! -s "$FILE" ]; then
            echo -e "   ${GRAY}No active tasks.${RESET}"
            local total_tasks=0
        else
            local idx=1
            while IFS= read -r line || [ -n "$line" ]; do
                local date_part="${line%%|*}"
                local full_content="${line#*|}"
                full_content=$(echo "$full_content" | sed 's/^todo //g' | xargs)
                date_part=$(echo "$date_part" | xargs)

                local title_content="Task"
                local body_text="$full_content"
                if [[ "$full_content" =~ \[([^\]]+)\](.*)$ ]]; then
                    title_content="${BASH_REMATCH[1]}"
                    body_text="${BASH_REMATCH[2]}"
                fi

                echo -e "  ${CYAN}${idx}.${RESET} [${YELLOW}${title_content}${RESET}] ${GRAY}(${date_part})${RESET}"
                if [ -n "$body_text" ]; then
                    echo "$body_text" | fold -s -w 52 | while read -r subline; do
                        echo -e "      ${DIM_WHITE}${subline}${RESET}"
                    done
                fi
                echo "" 
                ((idx++))
            done < "$FILE"
            local total_tasks=$((idx - 1))
        fi

        echo -e "${BLUE}${MID}${RESET}"
        local current_time=$(date +"%H:%M")
        printf "  ${GRAY}Active: %s tasks ${RESET} %34s ${GRAY}%s${RESET}\n" "$total_tasks" "Last update:" "$current_time"
        echo -e "${BLUE}${BOT}${RESET}"
    fi
}

rename-todo() {
    if [ -z "$1" ]; then
        echo "Usage: rename-todo \"New Name\""
        return 1
    fi
    echo "$*" > "$HOME/.todo_title"
    echo -e "  ${YELLOW}» Board renamed to: $*${RESET}"
}

todo-del() {
    if [ -z "$1" ]; then
        echo "Usage: todo-del [number]"
        return 1
    fi
    sed -i "${1}d" "$HOME/.meu-todo.txt"
    echo -e "  ${YELLOW}× Task $1 removed!${RESET}"
}

todo-clear() {
    echo -en "  ${YELLOW}! Clear ALL tasks? (y/n): ${RESET}"
    read confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        > "$HOME/.meu-todo.txt"
        echo -e "  ${YELLOW}× Task list cleared!${RESET}"
    fi
}

credits-todo() {
    local CYAN="\033[1;36m"
    local YELLOW="\033[1;33m"
    local GRAY="\033[0;90m"
    local RESET="\033[0m"
    local PURPLE="\033[1;35m"

    echo -e "\n  ${YELLOW}TODO BOARD${RESET} ${GRAY}v1.0${RESET}"
    echo -e "  ${GRAY}────────────────────────────────────────────────────────────${RESET}"
    echo -e "  Built by ${PURPLE}Hocks${RESET}."
    echo -e "\n  I really appreciate you using this tool, and I hope it 
  helps you stay organized."
    echo -e "\n  If you find it useful, I would be grateful if you could
  leave a star on my GitHub repository."
    echo -e "\n  ${CYAN}➜ https://github.com/Hocksz${RESET}"
    echo -e "  ${GRAY}────────────────────────────────────────────────────────────${RESET}\n"
}
EOF

# 3. Permissão de execução
chmod +x "$SCRIPT_PATH"

# 4. Adicionar ao .bashrc
if ! grep -q "source $SCRIPT_PATH" "$BASHRC"; then
    echo -e "${YELLOW}➜ Adding source to .bashrc...${RESET}"
    echo "" >> "$BASHRC"
    echo "# Todo Board Script" >> "$BASHRC"
    echo "source $SCRIPT_PATH" >> "$BASHRC"
fi

echo -e "${GREEN}» Installation complete!${RESET}"
echo -e "${YELLOW}Please run 'source ~/.bashrc' to start using it.${RESET}"
