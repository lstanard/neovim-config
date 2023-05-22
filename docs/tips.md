# Tips

Tips for faster and more efficient navigation and editing.

## Navigation files and folders

1. Use git hunks to move to recently edited lines in a file: `[c` (prev hunk) and `]c` (next hunk)
2. Rather than using `w` to jump from word to word use find `f` (forward find) and `F` (reverse find) to quickly move to a word
   - Repeat the last find command using `;` (forward search) and `,` (reverse direction)
3. Telescope file search can find results by providing parts of the file name – for example if you're looking for a file with a long, difficult to type name like `AuthorizationRequirementsUtilities` you could search for something like `AuthReqUt` and it will narrow down to that file.
4. `%` to jump to matching bracket/parenthesis/brace

## Efficiently editing text

- `S` to replace current line (delete all text on line and enter insert mode)
- `x` to delete character under cursor (in normal mode)
