from matrix import Matrix

try:
    # Create two matrices
    matrix_a = Matrix([[1, 2, 3], [4, 5, 6]])
    matrix_b = Matrix([[7, 8], [9, 10], [11, 12]])

    print("Matrix A:")
    print(matrix_a)

    print()

    print("Matrix B:")
    print(matrix_b)

    print()

    # Matrix multiplication
    print("Matrix A * Matrix B:")
    result_mul = matrix_a * matrix_b
    print(result_mul)

    print()

    # Scalar addition
    print("Matrix A + 10:")
    result_add_scalar = matrix_a + 10
    print(result_add_scalar)

    print()

    # Matrix addition (demonstrating dimension mismatch error)
    print("Trying to add Matrix A + Matrix B (this should fail)...")
    try:
        matrix_a + matrix_b
    except ValueError as e:
        print(f"  Error caught: {e}")

except Exception as e:
    print(f"An unexpected error occurred: {e}")
