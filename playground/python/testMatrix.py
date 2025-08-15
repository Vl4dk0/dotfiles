import unittest

from matrix import Matrix


class TestMatrix(unittest.TestCase):
    """
    A test suite for the Matrix class.
    """

    def setUp(self):
        """
        Set up matrices to be used in multiple test cases.
        """
        # A simple 2x3 matrix
        self.matrix_a = Matrix([[1, 2, 3], [4, 5, 6]])
        # A 3x2 matrix for multiplication
        self.matrix_b = Matrix([[7, 8], [9, 10], [11, 12]])
        # A 2x3 matrix for addition
        self.matrix_c = Matrix([[10, 20, 30], [40, 50, 60]])
        # A 2x2 matrix for multiplication with another 2x2 matrix
        self.matrix_d = Matrix([[1, 2], [3, 4]])
        self.matrix_e = Matrix([[5, 6], [7, 8]])

    def test_init_success(self):
        """
        Test that a valid matrix is created successfully.
        """
        data = [[1, 2], [3, 4]]
        matrix = Matrix(data)
        self.assertEqual(matrix.height, 2)
        self.assertEqual(matrix.width, 2)
        self.assertEqual(matrix.data, data)

    def test_init_fail_ragged_matrix(self):
        """
        Test that initialization fails for a non-rectangular (ragged) matrix.
        """
        with self.assertRaises(ValueError):
            Matrix([[1, 2, 3], [4, 5]])

    def test_add_scalar(self):
        """
        Test scalar addition.
        """
        result = self.matrix_a + 5
        expected_data = [[6, 7, 8], [9, 10, 11]]
        self.assertEqual(result.data, expected_data)

    def test_add_matrix_success(self):
        """
        Test successful matrix addition.
        """
        result = self.matrix_a + self.matrix_c
        expected_data = [[11, 22, 33], [44, 55, 66]]
        self.assertEqual(result.data, expected_data)

    def test_add_matrix_fail_dimensions(self):
        """
        Test that matrix addition fails for mismatched dimensions.
        """
        with self.assertRaises(ValueError):
            self.matrix_a + self.matrix_b

    def test_mul_scalar(self):
        """
        Test scalar multiplication.
        """
        result = self.matrix_a * 2
        expected_data = [[2, 4, 6], [8, 10, 12]]
        self.assertEqual(result.data, expected_data)

    def test_mul_matrix_success(self):
        """
        Test successful matrix multiplication.
        """
        result = self.matrix_a * self.matrix_b
        expected_data = [[58, 64], [139, 154]]
        self.assertEqual(result.data, expected_data)

    def test_mul_matrix_fail_dimensions(self):
        """
        Test that matrix multiplication fails for mismatched dimensions.
        """
        with self.assertRaises(ValueError):
            self.matrix_a * self.matrix_c

    def test_get_row(self):
        """
        Test retrieving a specific row.
        """
        row = self.matrix_a.get_row(0)
        self.assertEqual(row, [1, 2, 3])

    def test_get_column(self):
        """
        Test retrieving a specific column.
        """
        column = self.matrix_a.get_column(1)
        self.assertEqual(column, [2, 5])


if __name__ == '__main__':
    unittest.main()
