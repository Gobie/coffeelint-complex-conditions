# coffeelint-complex-conditions

coffeelint-complex-conditions is a plugin of [coffeelint](http://www.coffeelint.org/). It checks for complex conditions. Complex conditions are conditions with boolean logic && or ||.

```
unless a or b and c
   ...

... unless not a or b and c

```

## Options

Type of conditions to check for complexity.

Defaults:
```
conditions: {
  if: false,
  unless: true,
  post_if: false,
  post_unless: true
}
```

## How to Install

1. add `"coffeelint-complex-conditions": "^0.0.1"` as `devDependencies` in `package.json`
2. `npm install`

## How to Use

In your `coffeelint.json`, add

```
{
  // other lint rules
  {
    "complex_condition": {
      "module": "coffeelint-complex-conditions",
      "level": "warn"
    }
  }
}
```

and run `coffeelint`.
