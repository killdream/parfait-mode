Parfait-mode
============

Brings delicious sweetness to your source code by removing
the needless (visual) clutter.

That is, instead of:

```javascript
function make_array(size, default_value) { var result, has_defaultp
    size         = (__max(size, 0)) >>> 0
    has_defaultp = arguments.length > 1
    if (size <= 0)  return []

    result = Array(size).join('0').split('0')
    return has_defaultp?  result.map(function(){ return default_value })
                       :  result
}
```

You could have:

```javascript
λ make-array(size, default-value) { var result, has-defaultp
   size         = (__max(size, 0)) >>> 0
   has-defaultp = arguments.length > 1
   if (size <= 0) ⇐ []

   result = Array(size).join('0').split('0')
   ⇐ has-defaultp?  result.map(λ(){ ⇐ default-value })
   :                 result }
```

## Installing

In your shell:

```bash
$ cd ~/.emacs.d/vendor
$ git clone git://github.com/killdream/parfait-mode
```

In your emacs config:

```lisp
(add-to-list 'load-path "/path/to/parfait-mode")
(require 'parfait-mode)

;; Add your own character mappings. This is the one I use:
(parfait-add-symbols
 '(("\\<this\\(\\.\\|\\>\\)" . "@")
   ("\\<return\\>"           . "⇐")
   ("\\<function\\>"         . "𝝺")
   ("\\>_\\<"                . "-")
   ("<="                     . "≤")
   (">="                     . "≥")
   ("&&"                     . "⋀")
   ("||"                     . "⋁")))
```

In your buffer:

```
M-x parfait-mode 
```

Or add it to a major mode hook:

```lisp
(add-hook 'js3-mode-hook 'parfait-mode)
```


## Acknowledgements

The code is an improvement on `lambda-mode' by Mark Triggs
<mst@dishevelled.net>, so most of the code is the same, I just hacked it
to work with lotsa symbols at the same time :3

## Licence

GPL'd. See COPYING for `less` information.
