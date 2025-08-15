namespace MatrixProject;

public class Matrix
{
    // A C# property to hold the matrix data.
    public double[,] Data { get; private set; }
    public int Height => Data.GetLength(0);
    public int Width => Data.GetLength(1);

    public Matrix(double[,] data)
    {
        if (data.GetLength(0) == 0 || data.GetLength(1) == 0)
        {
            throw new ArgumentException("Matrix cannot be empty.");
        }

        Data = data;
    }

    // Overload the addition operator (+) for matrix and scalar addition.
    public static Matrix operator +(Matrix a, Matrix b)
    {
        if (a.Height != b.Height || a.Width != b.Width)
        {
            throw new ArgumentException("Matrices must have the same dimensions for addition.");
        }

        var result = new double[a.Height, a.Width];
        for (int i = 0; i < a.Height; i++)
        {
            for (int j = 0; j < a.Width; j++)
            {
                result[i, j] = a.Data[i, j] + b.Data[i, j];
            }
        }
        return new Matrix(result);
    }

    public static Matrix operator +(Matrix a, double scalar)
    {
        var result = new double[a.Height, a.Width];
        for (int i = 0; i < a.Height; i++)
        {
            for (int j = 0; j < a.Width; j++)
            {
                result[i, j] = a.Data[i, j] + scalar;
            }
        }
        return new Matrix(result);
    }

    // Symmetrical overload for adding a scalar to a matrix.
    public static Matrix operator +(double scalar, Matrix a)
    {
        return a + scalar;
    }

    // Overload the multiplication operator (*) for matrix and scalar multiplication.
    public static Matrix operator *(Matrix a, Matrix b)
    {
        if (a.Width != b.Height)
        {
            throw new ArgumentException("Matrix A's width must equal Matrix B's height for multiplication.");
        }

        var result = new double[a.Height, b.Width];
        for (int i = 0; i < a.Height; i++)
        {
            for (int j = 0; j < b.Width; j++)
            {
                for (int k = 0; k < a.Width; k++)
                {
                    result[i, j] += a.Data[i, k] * b.Data[k, j];
                }
            }
        }
        return new Matrix(result);
    }

    public static Matrix operator *(Matrix a, double scalar)
    {
        var result = new double[a.Height, a.Width];
        for (int i = 0; i < a.Height; i++)
        {
            for (int j = 0; j < a.Width; j++)
            {
                result[i, j] = a.Data[i, j] * scalar;
            }
        }
        return new Matrix(result);
    }

    // Symmetrical overload for multiplying a scalar by a matrix.
    public static Matrix operator *(double scalar, Matrix a)
    {
        return a * scalar;
    }

    public override string ToString()
    {
        var rows = new string[Height];
        for (int i = 0; i < Height; i++)
        {
            var rowValues = new string[Width];
            for (int j = 0; j < Width; j++)
            {
                rowValues[j] = Data[i, j].ToString();
            }
            rows[i] = string.Join(" ", rowValues);
        }
        return string.Join("\n", rows);
    }
}

