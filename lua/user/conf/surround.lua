-- usage
-- The primary way of adding a new pair to the buffer is via the normal-mode *ys*
-- operator, which stands for "you surround". It can be used via
-- `ys{motion}{char}`, which surrounds a given {motion} with a delimiter pair
-- associated with {char}. For example, `ysa")` means "you surround around quotes
-- with parentheses".
--
-- In all of the following examples, the `*` denotes the cursor position:
--
--     Old text                    Command         New text  
--     local str = H*ello          ysiw"           local str = "Hello"
--     require"nvim-surroun*d"     ysa")           require("nvim-surround")
--     char c = *x;                ysl'            char c = 'x';
--     int a[] = *32;              yst;}           int a[] = {32};
--
-- Furthermore, there are insert-mode *<C-g>s* and visual-mode *S* mappings, that
-- add the delimiter pair around the cursor and visual selection, respectively.
-- In all of the following examples, we will use `|` to demarcate the start and
-- end of a visual selection:
--
--     Old text                    Command         New text  
--     local str = *               <C-g>s"         local str = "*"
--     local tab = *               <C-g>s}         local str = {*}
--     local str = |some text|     S'              local str = 'some text'
--     |div id="test"|</div>       S>              <div id="test"></div>
--
-- To delete a delimiter pair, use the *ds* operator, which stands for "delete
-- surround". It is used via `ds[char]`, deleting the surrounding pair associated
-- with {char}. For example, `ds)` means "delete surrounding parentheses".
--
--     Old text                    Command         New text  
--     local x = ({ *32 })         ds)             local x = { 32 }
--     See ':h h*elp'              ds'             See :h help
--     local str = [[Hell*o]]      ds]             local str = [Hello]
--
-- To change a delimiter pair, use the *cs* operator, which stands for "change
-- surround". It is used via `cs{target}{replacement}`, changing the surrounding
-- pair associated with {target} to a pair associated with {replacement}. For
-- example, `cs'"` means "change the surrounding single quotes to double quotes".
--
--     Old text                    Command         New text  
--     '*some string'              cs'"            "some string"
--     use<*"hello">               cs>)            use("hello")
--     `some text*`                cs`}            {some text}




local status_surround_ok, surround = pcall(require, "nvim-surround")
if not status_surround_ok then
    vim.notify("nvim-surround not found!")
    return
end


surround.setup{}
