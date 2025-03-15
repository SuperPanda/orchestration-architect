//! # Category Theory in Rust
//!
//! This module establishes core abstractions for a category–theoretic API in Rust.
//!
//! It defines two constructs:
//!
//! 1. **CObject** – a generic container that pairs a key with a value.
//! 2. **CArrow** – a morphism (i.e. a transformation from a source type to a target type).
//!
//! ## Key Concepts
//!
//! - **Identity:** For any type `T` there is an identity arrow `id: T → T` such that for any arrow
//!   `f: A → B`, composing with the identity (on either side) returns `f`.
//!
//! - **Associativity:** For arrows `f: A → B`, `g: B → C`, and `h: C → D`, we have:
//! ```text,ignore
//!       (h ∘ g) ∘ f = h ∘ (g ∘ f)
//! ```
//! ## Design Details
//!
//! - The transformation is stored in an [`Arc`], making arrows cheaply cloneable and safe for concurrent use.
//! - Composition is now defined by taking ownership of both arrows instead of borrowing the second arrow.
//!   This allows safe inline composition without temporary borrow issues.
//! - Arrows allow lifetimes other than `'static`, so that stored closures may borrow data as needed.

use std::sync::Arc;

/// ## CObject
///
/// A generic container that pairs a key with an encapsulated value.
#[derive(Debug, Clone)]
pub struct CObject<T> {
    key: String,
    value: T,
}

impl<T> CObject<T> {
    /// Creates a new `CObject`.
    ///
    /// # Examples
    ///
    /// ```
    /// use oa::core::catlib::CObject;
    /// let obj = CObject::new("my_key", 42);
    /// assert_eq!(obj.value(), &42);
    /// ```
    pub fn new<K: Into<String>>(key: K, value: T) -> Self {
        Self {
            key: key.into(),
            value,
        }
    }

    /// Returns the object's key.
    pub fn key(&self) -> &str {
        &self.key
    }

    /// Returns a reference to the encapsulated value.
    pub fn value(&self) -> &T {
        &self.value
    }

    /// Transforms the contained value while preserving the key.
    ///
    /// # Examples
    ///
    /// ```
    /// use oa::core::catlib::CObject;
    /// let obj = CObject::new("number", 2);
    /// let new_obj = obj.map(|x| x * 3);
    /// assert_eq!(new_obj.value(), &6);
    /// ```
    pub fn map<U, F>(self, f: F) -> CObject<U>
    where
        F: FnOnce(T) -> U,
    {
        CObject {
            key: self.key,
            value: f(self.value),
        }
    }
}

/// ## Arrow Trait
///
/// The `Arrow` trait models a morphism (transformation) from a source type to a target type.
/// This trait is parameterized over a lifetime `'a` which is the lifetime for the underlying closure's borrow (if any).
///
/// ### Composition
///
/// The `compose` method consumes both arrows and returns their composition. In other words, if you have
/// an arrow `self: A → B` and another arrow `next: B → C`, then:
///
/// ```ignore
/// let composite: CArrow<'a, A, C> = arrow_ab.compose(arrow_bc);
/// ```
///
/// Since composition takes ownership, if you need to reuse an arrow you can always call its [`Clone`] method.
pub trait Arrow<'a>: Sized {
    /// The source type.
    type Source;
    /// The target type.
    type Target;

    /// Returns the arrow's key.
    fn key(&self) -> &str;

    /// Applies the arrow to an input value.
    fn apply(&self, src: Self::Source) -> Self::Target;

    /// Composes this arrow with another arrow by consuming both.
    ///
    /// # Examples
    ///
    /// ```
    /// use oa::core::catlib::{Arrow, CArrow};
    ///
    /// let add_one = CArrow::new("add_one", |x: i32| x + 1);
    /// let double  = CArrow::new("double", |x: i32| x * 2);
    /// let composed = add_one.compose(double);
    /// assert_eq!(composed.apply(2), 6);
    /// ```
    fn compose<M>(self, next: M) -> CArrow<'a, Self::Source, M::Target>
    where
        M: Arrow<'a, Source = Self::Target> + Sync + Send + 'a;
}

/// ## CArrow
///
/// A concrete arrow (morphism) representing a function from type `S` to type `T`.
///
/// The transformation is stored in an [`Arc`] and its closure is parameterized by lifetime `'a`.
/// This allows the arrow to borrow data if needed.
#[derive(Clone)]
pub struct CArrow<'a, S, T> {
    key: String,
    f: Arc<dyn Fn(S) -> T + Send + Sync + 'a>,
}

impl<'a, S: 'a, T: 'a> CArrow<'a, S, T> {
    /// Creates a new `CArrow`.
    ///
    /// # Examples
    ///
    /// ```
    /// use crate::oa::core::catlib::{CArrow,Arrow};
    /// let arrow = CArrow::new("times_two", |x: i32| x * 2);
    /// assert_eq!(arrow.apply(3), 6);
    /// ```
    pub fn new<K, F>(key: K, f: F) -> Self
    where
        K: Into<String>,
        F: Fn(S) -> T + Send + Sync + 'a,
    {
        Self {
            key: key.into(),
            f: Arc::new(f),
        }
    }
}

impl<'a, S: 'a, T: 'a> Arrow<'a> for CArrow<'a, S, T> {
    type Source = S;
    type Target = T;

    fn key(&self) -> &str {
        &self.key
    }

    fn apply(&self, s: S) -> T {
        (self.f)(s)
    }

    fn compose<M>(self, next: M) -> CArrow<'a, S, M::Target>
    where
        M: Arrow<'a, Source = T> + Sync + Send + 'a,
    {
        let new_key = format!("{} ∘ {}", next.key(), self.key());
        let f_owned = self.f;
        CArrow::new(new_key, move |s: S| {
            let intermediate = (f_owned)(s);
            next.apply(intermediate)
        })
    }
}

/// ## Identity Arrow
///
/// Returns the identity arrow for any type `T`. This arrow satisfies:
/// ```text,ignore
///     id ∘ f = f   and   f ∘ id = f
/// ```
/// The identity arrow is parameterized by a lifetime `'a`. Its closure performs no borrowing,
/// meeting the API's signature.
///
/// # Examples
///
/// ```
/// use crate::oa::core::catlib::{identity,Arrow};
/// let id = identity::<i32>();
/// assert_eq!(id.apply(10), 10);
/// ```
pub fn identity<'a, T: 'a>() -> CArrow<'a, T, T> {
    CArrow::new("id", |x| x)
}

/// ## Macro for Arrow Construction
///
/// Constructs a new `CArrow` using a concise syntax.
///
/// # Examples
///
/// ```
/// use oa::core::catlib::carrow;
/// let arrow = carrow!("increment", |x: i32| x + 1);
/// assert_eq!(arrow.apply(3), 4);
/// ```

#[cfg(test)]
mod tests {
    use crate::core::catlib::*;

    #[test]
    fn test_arrow_apply() {
        let arrow = CArrow::new("increment", |x: i32| x + 1);
        assert_eq!(arrow.apply(1), 2);
    }

    #[test]
    fn test_arrow_composition() {
        let arrow1 = CArrow::new("add_one", |x: i32| x + 1);
        let arrow2 = CArrow::new("double", |x: i32| x * 2);
        // Composition now takes ownership.
        let composed = arrow1.compose(arrow2);
        assert_eq!(composed.apply(2), 6);
        assert_eq!(composed.key(), "double ∘ add_one");
    }

    #[test]
    fn test_identity_axiom() {
        let f = CArrow::new("plus_one", |x: i32| x + 1);
        let id = identity::<i32>();

        // Clone arrows when you intend to use them after composition.
        let left = id.clone().compose(f.clone());
        let right = f.clone().compose(id);
        let x = 5;

        // f is cloned, so you can still use it later.
        assert_eq!(left.apply(x), f.apply(x));
        assert_eq!(right.apply(x), f.apply(x));
    }

    #[test]
    fn test_associativity_axiom() {
        let f = CArrow::new("f", |x: i32| x + 1);
        let g = CArrow::new("g", |x: i32| x * 2);
        let h = CArrow::new("h", |x: i32| x - 3);

        let x = 10;
        // Compose in one expression.
        let left = f.clone().compose(g.clone()).compose(h.clone());
        let right = f.compose(g.compose(h));
        assert_eq!(left.apply(x), right.apply(x));
    }

    #[test]
    fn test_compose_with_mapping() {
        let arrow = CArrow::new("times_two", |x: i32| x * 2);
        let mapping = CArrow::new("map", |y: i32| y + 3);
        let mapped = arrow.compose(mapping);
        assert_eq!(mapped.apply(4), 11);
    }

    #[derive(Debug, PartialEq, Clone)]
    struct Person {
        name: String,
        age: u32,
    }

    #[derive(Debug, PartialEq)]
    struct PersonDTO {
        name: String,
        is_adult: bool,
    }

    #[test]
    fn test_person_transformation() {
        let to_dto = CArrow::new("to_dto", |p: Person| PersonDTO {
            name: p.name,
            is_adult: p.age >= 18,
        });
        let increment_age = CArrow::new("increment_age", |p: Person| Person {
            name: p.name,
            age: p.age + 1,
        });
        // Compose by taking ownership.
        let composite = increment_age.compose(to_dto);
        let person = Person {
            name: "Alice".to_string(),
            age: 17,
        };
        let expected = PersonDTO {
            name: "Alice".to_string(),
            is_adult: true,
        };
        assert_eq!(composite.apply(person), expected);
    }
}
