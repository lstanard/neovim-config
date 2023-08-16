# Tips

Tips for faster and more efficient navigation and editing.

## Navigation files and folders

1. Use git hunks to move to recently edited lines in a file: `[c` (prev hunk) and `]c` (next hunk)
2. Rather than using `w` to jump from word to word use find `f` (forward find) and `F` (reverse find) to quickly move to a word
   - Repeat the last find command using `;` (forward search) and `,` (reverse direction)
3. Telescope file search can find results by providing parts of the file name – for example if you're looking for a file with a long, difficult to type name like `AuthorizationRequirementsUtilities` you could search for something like `AuthReqUt` and it will narrow down to that file.
4. `%` to jump to matching bracket/parenthesis/brace. This can be used with visual mode to select a block of text from the opening and closing braces.
5. Use `Ctrl + O` to jump back to a previous location, and `Ctrl + I` to jump forward to locations you previously jumped from using `Ctrl + O`
   - Use `:jumps` or `:ju` command to view the jump list

## Efficiently editing text

- `S` to replace current line (delete all text on line and enter insert mode)
  - What's nice about this is it doesn't matter where the cursor is on the line, unlike `c$` where the cursor has to be at the beginning of the line
- `x` to delete character under cursor (in normal mode)

## Registers

- Use `"` or `:reg` to access registers
- Registers always start with `"`, follwed by the register name. Example: `"zy` would yank to register `z`
- Use the `0` register to get yanked text that isn't assigned to a named register. Example: `"0p`
  - This register is not populated with yanked text when using the d/c/x/s commands, and will only be populated with yanked text
