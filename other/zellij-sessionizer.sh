#!/bin/zsh

if ! command -v gum &>/dev/null; then
    echo "Error: Gum is not installed. Please install it from https://github.com/charmbracelet/gum."
    exit 1
fi

declare -A folder_map

while IFS= read -r project_path; do
    project_name=$(basename "$project_path")
    folder_map[$project_name]="$project_path"
done < <(find ~/git -mindepth 2 -maxdepth 2 -type d)
selected_project_name=$(printf '%s\n' "${(@k)folder_map}" | gum filter --placeholder "Select a project")

if [[ -n "$selected_project_name" ]]; then
    wezterm cli set-tab-title $selected_project_name
    zellij a $selected_project_name

    if [[ $? -ne 0 ]]; then
        selected_project=${folder_map[$selected_project_name]}
        cd $selected_project
        zellij -s $selected_project_name
    fi
else
    echo "No project selected"
fi

wezterm cli set-tab-title "~"
