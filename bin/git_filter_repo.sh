# This script should run in the same folder as the project folder is.
# This script uses git-filter-repo (https://github.com/newren/git-filter-repo).
# The list of files and folders that you want to keep should be named <your_repo_folder_name>_KEEP.txt. I should contain a line end in the last line, otherwise the last file/folder will be skipped.
# The result will be the folder called <your_repo_folder_name>_REWRITE_CLONE. Your original repo won't be changed.
# Tags are not preserved, see line below to preserve tags.
# Running subsequent times will backup the last run in <your_repo_folder_name>_REWRITE_CLONE_BKP.

# Define here the name of the folder containing the repo: 
GIT_REPO="albus"

clone="$GIT_REPO"_REWRITE_CLONE
temp=/tmp/git_rewrite_temp
rm -Rf "$clone"_BKP
mv "$clone" "$clone"_BKP
rm -Rf "$temp"
mkdir "$temp"
git clone "$GIT_REPO" "$clone"
cd "$clone"
git remote remove origin
open .
open "$temp"

# Comment line below to preserve tags
git tag | xargs git tag -d

echo 'Start logging file history...'
echo "# git log results:\n" > "$temp"/log.txt

while read p
do
    shopt -s dotglob
    find "$p" -type f > "$temp"/temp
    while read f
    do
        echo "## " "$f" >> "$temp"/log.txt
        # print every file and follow to get any previous renames
        # Then remove blank lines.  Then remove every other line to end up with the list of filenames       
        git log --pretty=format:'%H' --name-only --follow -- "$f" | awk 'NF > 0' | awk 'NR%2==0' | tee -a "$temp"/log.txt
        
        echo "\n\n" >> "$temp"/log.txt
    done < "$temp"/temp
done < ../"$GIT_REPO"_KEEP.txt > "$temp"/PRESERVE

mv "$temp"/PRESERVE "$temp"/PRESERVE_full
awk '!a[$0]++' "$temp"/PRESERVE_full > "$temp"/PRESERVE

sort -o "$temp"/PRESERVE "$temp"/PRESERVE

echo 'Starting filter-branch --------------------------'
git filter-repo --paths-from-file "$temp"/PRESERVE --force --replace-refs delete-no-add
echo 'Finished filter-branch --------------------------'
