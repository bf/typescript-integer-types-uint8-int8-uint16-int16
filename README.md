# Typescript 8 Bit Integer and 16 Bit Integer 

Explicit typescript types for `int8`, `uint8`, `int16`, `uint16` defined in a hacky way.

For TypeScript, `123`, `0.7`, `0xAA`, `0xDEADBEEF` are all of `number` type and there is no way to properly discern them.

I wanted to ensure that code like `foo([0xFF, 0xAA])` only works with `uint8` (`Bytes`) and to accept only values between `0` and `255`. 

With these explicitly defined types TypeScript will do the following:

```typescript
let byteArrayInTypescript: uint8[] = [
  0,          // ok
  0xff,       // ok
  255,        // ok
  256,        // [ERROR]: Type '256' is not assignable to type 'uint8'.
  1000,       // [ERROR]: Type '1000' is not assignable to type 'uint8'.
  1.0,        // ok (lol)
  1.13,       // [ERROR]: Type '1.13' is not assignable to type 'uint8'.
  -1,         // [ERROR]: Type '-1' is not assignable to type 'uint8'.
  0xDD0000FF  // [ERROR]: Type '3707764991' is not assignable to type 'uint8'.
]
```

and 

```typescript
function foobar (arr: uint8[]) {};

foobar([1, 2, 3]) // works
foobar([0x33, 0x44, 0x55]) // works
foobar([0xDD0000FF])  // [ERROR]: Type '3707764991' is not assignable to type 'uint8'.
```

This was prompted by issue https://github.com/microsoft/TypeScript/issues/62867#issuecomment-3634574290