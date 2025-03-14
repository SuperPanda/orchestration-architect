
#[macro_export]
macro_rules! carrow {
    ($key:expr, $f:expr) => {
        $crate::CArrow::new($key, $f)
    };
}
