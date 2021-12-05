pub mod doubleing {
    #[must_use]
    pub const fn double_number(x: i32) -> i32 {
        x * 2
    }
}

#[cfg(test)]
mod tests {
    use crate::doubleing::double_number;

    #[test]
    fn test_double() {
        assert_eq!(double_number(4), 8);
        assert_eq!(double_number(5), 10);
    }
}
