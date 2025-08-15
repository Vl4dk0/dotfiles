class Matrix:
    """
    A simple Matrix class with support for basic arithmetic operations.

    Attributes:
        data (list[list[int | float]]): A list of lists representing the matrix.
        height (int): The number of rows.
        width (int): The number of columns.
    """

    def __init__(self, data):
        """
        Initializes a Matrix object.

        Args:
            data (list[list[int | float]]): A list of lists representing the matrix.

        Raises:
            ValueError: If the input data is not a valid matrix (rows have different lengths).
        """
        # Ensure the input data is not empty
        if not data or not data[0]:
            raise ValueError("Matrix cannot be empty")

        # Get dimensions
        self.height = len(data)
        self.width = len(data[0])
        self.data = data

        # Validate that all rows have the same width
        for row in self.data:
            if len(row) != self.width:
                raise ValueError("All rows must have the same length")

    def __str__(self):
        """
        Returns a string representation of the matrix.
        """
        return '\n'.join([' '.join(map(str, row)) for row in self.data])

    def __repr__(self):
        """
        Returns an official representation of the matrix object.
        """
        return f"Matrix(data={self.data})"

    def __add__(self, other):
        """
        Overloads the '+' operator for matrix addition and scalar addition.

        Args:
            other (Matrix or int or float): The object to add.

        Returns:
            Matrix: A new Matrix object representing the sum.

        Raises:
            ValueError: If adding two matrices of different dimensions.
            TypeError: If the 'other' operand is not a valid type.
        """
        if isinstance(other, (int, float)):
            # Scalar addition
            new_data = [[val + other for val in row] for row in self.data]
            return Matrix(new_data)

        if isinstance(other, Matrix):
            # Matrix addition
            if self.height != other.height or self.width != other.width:
                raise ValueError(
                    "Matrices must have the same dimensions for addition")

            new_data = [[
                self.data[i][j] + other.data[i][j] for j in range(self.width)
            ] for i in range(self.height)]
            return Matrix(new_data)

        raise TypeError(
            f"Unsupported operand type for +: 'Matrix' and '{type(other).__name__}'"
        )

    def __mul__(self, other):
        """
        Overloads the '*' operator for matrix multiplication and scalar multiplication.

        Args:
            other (Matrix or int or float): The object to multiply.

        Returns:
            Matrix: A new Matrix object representing the product.

        Raises:
            ValueError: If matrices cannot be multiplied (A's width != B's height).
            TypeError: If the 'other' operand is not a valid type.
        """
        if isinstance(other, (int, float)):
            # Scalar multiplication
            new_data = [[val * other for val in row] for row in self.data]
            return Matrix(new_data)

        if isinstance(other, Matrix):
            # Matrix multiplication
            if self.width != other.height:
                raise ValueError(
                    "Matrix A's width must equal Matrix B's height for multiplication"
                )

            new_data = [[0] * other.width for _ in range(self.height)]
            for i in range(self.height):
                for j in range(other.width):
                    for k in range(self.width):
                        new_data[i][j] += self.data[i][k] * other.data[k][j]

            return Matrix(new_data)

        raise TypeError(
            f"Unsupported operand type for *: 'Matrix' and '{type(other).__name__}'"
        )

    def __rmul__(self, other):
        """
        Enables right-hand side multiplication for scalars (e.g., 5 * matrix).
        """
        return self * other

    def get_row(self, index):
        """
        Retrieves a single row from the matrix.

        Args:
            index (int): The row index.

        Returns:
            list: The row as a list.
        """
        if not 0 <= index < self.height:
            raise IndexError("Row index out of bounds")
        return self.data[index]

    def get_column(self, index):
        """
        Retrieves a single column from the matrix.

        Args:
            index (int): The column index.

        Returns:
            list: The column as a list.
        """
        if not 0 <= index < self.width:
            raise IndexError("Column index out of bounds")
        return [row[index] for row in self.data]
