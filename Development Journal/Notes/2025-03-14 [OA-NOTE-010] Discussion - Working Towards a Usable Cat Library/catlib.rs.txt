// ====================
// File: core/catlib.rs
// ====================

use std::fmt::Debug;
use std::sync::Arc;

/// # Category Theory in Rust
///
/// In category theory, a **Category** consists of:
///
/// 1. **Objects:**  
///    For our purposes, these are plain Rust types.
///
/// 2. **Arrows (Morphisms):**  
///    Functions (or transformations) between objects, which satisfy two key axioms:
///
///    - **Identity:** For every object `A`, there is an arrow `id_A: A → A` such that for any arrow
///      `f: A → B`, we have:
///
///          f ∘ id_A = f   and   id_B ∘ f = f
///
///    - **Associativity:** For arrows `f: A → B`, `g: B → C`, and `h: C → D`, the following holds:
///
///          (h ∘ g) ∘ f = h ∘ (g ∘ f)
///
/// **Lifetimes and Clonability:**  
///
/// In our design, arrows are pure transformations. They are best thought of as immutable—and so
/// can be reused arbitrarily. We store the inner function in an Arc so that even if cloning is needed,
/// it’s inexpensive and safe. By defining composition (_compose_) on a shared reference (`&self`),
/// we avoid consuming the arrow, which fits with the category-theoretic intuition that arrows are pure maps.

/// # CObject
///
/// A generic container associating a key with a value. Conceptually, this is an “object” in our category.
#[derive(Debug, Clone)]
pub struct CObject<T> {
    /// An identifying key.
    pub key: String,
    /// The contained value.
    pub value: T,
}

impl<T> CObject<T> {
    /// Creates a new object.
    ///
    /// # Examples
    ///
    /// ```
    /// let obj = CObject::new("num", 42);
    /// ```
    pub fn new<K: Into<String>>(key: K, value: T) -> Self {
        Self { key: key.into(), value }
    }
    
    /// Transforms the contained value while preserving its key.
    ///
    /// # Examples
    ///
    /// ```
    /// let obj = CObject::new("number", 2);
    /// let new_obj = obj.map(|x| x * 3);  // "number", 6
    /// ```
    pub fn map<U, F>(self, f: F) -> CObject<U>
    where
        F: FnOnce(T) -> U,
    {
        CObject { key: self.key, value: f(self.value) }
    }
}

/// # Arrow Trait
///
/// The `Arrow` trait models a morphism from an object of type `Source` to one of type `Target`.
/// It provides an `apply` method to perform the transformation and a `compose` method for chaining
/// arrows. Unlike before, `compose` takes a shared reference (`&self`), ensuring that the arrow
/// can be used repeatedly.
///
/// The required axioms are:
///
/// - **Identity:** For every arrow `f: A → B`, composing with the identity arrow on `A` or `B` must
///   return `f`.
///
/// - **Associativity:** For arrows `f: A → B`, `g: B → C`, and `h: C → D`,
///   (h ∘ g) ∘ f == h ∘ (g ∘ f)
pub trait Arrow<'a> {
    /// The source (domain) type.
    type Source;
    /// The target (codomain) type.
    type Target;
    
    /// Returns the arrow’s key (name).
    fn key(&self) -> &str;
    
    /// Applies the arrow to an input of type `Source`, yielding a `Target`.
    fn apply(&self, src: Self::Source) -> Self::Target;
    
    /// Composes two arrows.
    ///
    /// Given arrow f: A → B (self) and arrow g: B → C (next), returns their composition g ∘ f: A → C.
    ///
    /// This method takes `self` by reference, so arrows aren’t consumed and can be re-used.
    ///
    /// # Examples
    ///
    /// ```
    /// let add_one = ArrowImpl::new("add_one", |x: i32| x + 1);
    /// let double  = ArrowImpl::new("double", |x: i32| x * 2);
    /// let composed = add_one.compose(double);
    /// assert_eq!(composed.apply(2), 6);
    /// ```
    fn compose<M>(&self, next: M) -> ArrowImpl<'a, Self::Source, M::Target>
    where
        Self: Clone + 'a,
        M: Arrow<'a, Source = Self::Target> + 'a,
    {
        let this = self.clone();
        let composed_key = format!("{} ∘ {}", next.key(), this.key());
        ArrowImpl::new(composed_key, move |src: Self::Source| {
            let intermediate = this.apply(src);
            next.apply(intermediate)
        })
    }
}

/// # ArrowImpl
///
/// A concrete implementation of an arrow. It stores a transformation (a closure) inside an Arc,
/// making it cloneable and safe to re-use. This fits our category-theoretic model in which morphisms
/// are immutable, pure transformations.
///
/// The lifetime parameter `'a` ties the lifetime of the enclosed closure to the arrow.
pub struct ArrowImpl<'a, S, T> {
    /// The arrow’s key.
    pub key: String,
    /// The transformation function, wrapped in an Arc.
    f: Arc<dyn Fn(S) -> T + 'a>,
}

impl<'a, S, T> ArrowImpl<'a, S, T> {
    /// Constructs a new arrow.
    ///
    /// # Examples
    ///
    /// ```
    /// let times_two = ArrowImpl::new("times_two", |x: i32| x * 2);
    /// ```
    pub fn new<K, F>(key: K, f: F) -> Self 
    where
        K: Into<String>,
        F: Fn(S) -> T + 'a,
    {
        ArrowImpl {
            key: key.into(),
            f: Arc::new(f),
        }
    }
}

impl<'a, S, T> Clone for ArrowImpl<'a, S, T> {
    fn clone(&self) -> Self {
        ArrowImpl {
            key: self.key.clone(),
            f: self.f.clone(),
        }
    }
}

impl<'a, S, T> Arrow<'a> for ArrowImpl<'a, S, T> {
    type Source = S;
    type Target = T;
    
    fn key(&self) -> &str {
        &self.key
    }
    
    fn apply(&self, src: S) -> T {
        (self.f)(src)
    }
}

/// # Identity Arrow
///
/// Returns the identity arrow for any type `T`. For any arrow `f: A → B`, composing with
/// the identity arrow on either side should leave `f` unchanged:
///
///     id_B ∘ f = f   and   f ∘ id_A = f
///
/// # Examples
///
/// ```
/// let id = identity::<i32>();
/// assert_eq!(id.apply(10), 10);
/// ```
pub fn identity<'a, T: 'a + Debug>() -> ArrowImpl<'a, T, T> {
    ArrowImpl::new("id", |x| x)
}

/// # Future Directions
///
/// This prototype is a foundation for further category-theoretic design. Future enhancements might include:
///
/// - **Functor:** A mapping between categories that sends objects to objects and arrows to arrows,
///   preserving identities and composition. This is useful when abstracting transformation pipelines across
///   different contexts (e.g. turning file system operations into data pipelines).
///
/// - **Natural Transformation:** A systematic way of converting one functor into another, preserving the
///   underlying structure of the category.
/// - **Monoidal Categories:** Extending our model to allow parallel composition of arrows (tensor products)
///   can model concurrent or multi-stream processes.
/// - **Currying & Higher Arity:** Extending arrows to handle functions with multiple inputs (and enabling
///   currying) helps in modeling complex transformations.
///
/// The design presented here leverages these abstract structures to enforce correctness and composability,
/// which is especially useful in contexts like data processing pipelines, compiler construction, and
/// asynchronous file-system operations.

#[cfg(test)]
mod tests {
    use super::*;

    /// Test arrow composition with simple integer operations.
    #[test]
    fn test_arrow_composition() {
        let add_one = ArrowImpl::new("add_one", |x: i32| x + 1);
        let double  = ArrowImpl::new("double", |x: i32| x * 2);
        
        // Compose: double ∘ add_one means "add one then double"
        let composed = add_one.compose(double);
        assert_eq!(composed.apply(2), 6);
    }
    
    /// Confirm the identity axiom:
    ///   For any arrow f: A → B,
    ///       id_B ∘ f = f   and   f ∘ id_A = f.
    #[test]
    fn test_identity_axiom() {
        let f = ArrowImpl::new("plus_one", |x: i32| x + 1);
        let id: ArrowImpl<i32, i32> = identity();
        
        // Compose without consuming f by using the reference-based compose method.
        let left = id.compose(f.clone());
        let right = f.compose(id);
        let x = 5;
        
        assert_eq!(left.apply(x), f.apply(x));
        assert_eq!(right.apply(x), f.apply(x));
    }
    
    /// Test the associativity axiom:
    ///   (h ∘ g) ∘ f = h ∘ (g ∘ f)
    #[test]
    fn test_associativity_axiom() {
        let f = ArrowImpl::new("f", |x: i32| x + 1);      // A → B.
        let g = ArrowImpl::new("g", |x: i32| x * 2);      // B → C.
        let h = ArrowImpl::new("h", |x: i32| x - 3);      // C → D.
        
        let x = 10;
        
        // Compose using the reference-based compose.
        let left = f.compose(g.compose(h.clone()));
        let right = f.compose(g).compose(h);
        
        assert_eq!(left.apply(x), right.apply(x));
    }
    
    /// A richer example: transforming a custom struct (Person) into a DTO.
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

    /// A test that composes a transformation arrow which increments a Person's age then transforms
    /// the Person into a PersonDTO.
    #[test]
    fn test_person_transformation() {
        // Arrow that converts Person into PersonDTO.
        let to_dto = ArrowImpl::new("to_dto", |p: Person| {
            PersonDTO {
                name: p.name,
                is_adult: p.age >= 18,
            }
        });
        
        // Arrow that increments the age of a Person.
        let increment_age = ArrowImpl::new("increment_age", |p: Person| Person {
            name: p.name,
            age: p.age + 1,
        });
        
        // Compose: first increment_age, then convert to DTO.
        let composite = increment_age.compose(to_dto);
        
        let person = Person {
            name: "Alice".to_string(),
            age: 17,
        };
        
        // After incrementing, age becomes 18, so is_adult is true.
        let expected = PersonDTO {
            name: "Alice".to_string(),
            is_adult: true,
        };
        assert_eq!(composite.apply(person), expected);
    }
}
