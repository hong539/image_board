# Enable special handling to prevent expansion to a
# literal '/tmp/backup/*' when no matches are found. 
shopt -s nullglob

FOLDERS=(/tmp/backup/*)
for folder in "${FOLDERS[@]}"; do
    [[ -d "$folder" ]] && echo "$folder"
done

# Unset shell option after use, if desired. Nullglob
# is unset by default.
shopt -u nullglob