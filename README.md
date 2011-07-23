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
   if (size <= 0) ← []

   result = Array(size).join('0').split('0')
   ← has-defaultp?  result.map(λ(){ ← default_value })
   :                result }
```

Licence
-------

GPL'd. See COPYING for `less` information.
