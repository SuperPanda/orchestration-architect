PhantomData

When working with unsafe code, we can often end up in a situation where types or lifetimes are logically associated with a struct, but not actually part of a field. This most commonly occurs with lifetimes. For instance, the Iter for &'a [T] is (approximately) defined as follows:

```rust
struct Iter<'a, T: 'a> {
    ptr: *const T,
    end: *const T,
}
```

However because 'a is unused within the struct's body, it's unbounded. Because of the troubles this has historically caused, unbounded lifetimes and types are forbidden in struct definitions. Therefore we must somehow refer to these types in the body. Correctly doing this is necessary to have correct variance and drop checking.

We do this using PhantomData, which is a special marker type. PhantomData consumes no space, but simulates a field of the given type for the purpose of static analysis. This was deemed to be less error-prone than explicitly telling the type-system the kind of variance that you want, while also providing other useful things such as auto traits and the information needed by drop check.

Iter logically contains a bunch of &'a Ts, so this is exactly what we tell the PhantomData to simulate:

```rust
use std::marker;

struct Iter<'a, T: 'a> {
    ptr: *const T,
    end: *const T,
    _marker: marker::PhantomData<&'a T>,
}
```

and that's it. The lifetime will be bounded, and your iterator will be covariant over 'a and T. Everything Just Works.
Generic parameters and drop-checking

In the past, there used to be another thing to take into consideration.

This very documentation used to say:

    Another important example is Vec, which is (approximately) defined as follows:


```rust
struct Vec<T> {
    data: *const T, // *const for variance!
    len: usize,
    cap: usize,
}
```

Unlike the previous example, it appears that everything is exactly as we want. Every generic argument to Vec shows up in at least one field. Good to go!

Nope.

The drop checker will generously determine that Vec<T> does not own any values of type T. This will in turn make it conclude that it doesn't need to worry about Vec dropping any T's in its destructor for determining drop check soundness. This will in turn allow people to create unsoundness using Vec's destructor.

In order to tell the drop checker that we do own values of type T, and therefore may drop some T's when we drop, we must add an extra PhantomData saying exactly that:

    use std::marker;

    struct Vec<T> {
        data: *const T, // *const for variance!
        len: usize,
        cap: usize,
        _owns_T: marker::PhantomData<T>,
    }

But ever since RFC 1238, this is no longer true nor necessary.

If you were to write:

struct Vec<T> {
    data: *const T, // `*const` for variance!
    len: usize,
    cap: usize,
}

impl<T> Drop for Vec<T> { /* … */ }

then the existence of that impl<T> Drop for Vec<T> makes it so Rust will consider that that Vec<T> owns values of type T (more precisely: may use values of type T in its Drop implementation), and Rust will thus not allow them to dangle should a Vec<T> be dropped.

When a type already has a Drop impl, adding an extra _owns_T: PhantomData<T> field is thus superfluous and accomplishes nothing, dropck-wise (it still affects variance and auto-traits).

>   (advanced edge case: if the type containing the PhantomData has no Drop impl at all, but still has drop glue (by having another field with drop glue), then the dropck/#[may_dangle] considerations mentioned herein do apply as well: a PhantomData<T> field will then require T to be droppable whenever the containing type goes out of scope).

But this situation can sometimes lead to overly restrictive code. That's why the standard library uses an unstable and unsafe attribute to opt back into the old "unchecked" drop-checking behavior, that this very documentation warned about: the #[may_dangle] attribute.
An exception: the special case of the standard library and its unstable #[may_dangle]

This section can be skipped if you are only writing your own library code; but if you are curious about what the standard library does with the actual Vec definition, you'll notice that it still needs to use a _owns_T: PhantomData<T> field for soundness.
Click here to see why

Raw pointers that own an allocation is such a pervasive pattern that the standard library made a utility for itself called `Unique<T>` which:

    wraps a `*const T` for variance
    includes a `PhantomData<T>`
    auto-derives `Send`/`Sync` as if `T` was contained
    marks the pointer as NonZero for the null-pointer optimization

Table of PhantomData patterns

Here’s a table of all the wonderful ways PhantomData could be used:

Phantom type | variance of 'a | variance of T | Send/Sync
(or lack thereof) | dangling 'a or T in drop glue
(e.g., #[may_dangle] Drop)
PhantomData<T> | - | covariant | inherited | disallowed ("owns T")
PhantomData<&'a T> | covariant | covariant | Send + Sync
requires
T : Sync | allowed
PhantomData<&'a mut T> | covariant | invariant | inherited | allowed
PhantomData<*const T> | - | covariant | !Send + !Sync | allowed
PhantomData<*mut T> | - | invariant | !Send + !Sync | allowed
PhantomData<fn(T)> | - | contravariant | Send + Sync | allowed
PhantomData<fn() -> T> | - | covariant | Send + Sync | allowed
PhantomData<fn(T) -> T> | - | invariant | Send + Sync | allowed
PhantomData<Cell<&'a ()>> | invariant | - | Send + !Sync | allowed


>    Note: opting out of the Unpin auto-trait requires the dedicated PhantomPinned type instead.

