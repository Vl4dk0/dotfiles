using NUnit.Framework;
using MatrixProject;
using System;

namespace MatrixProject.Tests;

public class MatrixTests
{
    private Matrix? _matrixA;
    private Matrix? _matrixB;
    private Matrix? _matrixC;

    [SetUp]
    public void Setup()
    {
        _matrixA = new Matrix(new double[,] { { 1, 2, 3 }, { 4, 5, 6 } });
        _matrixB = new Matrix(new double[,] { { 7, 8 }, { 9, 10 }, { 11, 12 } });
        _matrixC = new Matrix(new double[,] { { 10, 20, 30 }, { 40, 50, 60 } });
    }

    [Test]
    public void TestInitSuccess()
    {
        var data = new double[,] { { 1, 2 }, { 3, 4 } };
        var matrix = new Matrix(data);
        Assert.That(matrix.Height, Is.EqualTo(2));
        Assert.That(matrix.Width, Is.EqualTo(2));
        Assert.That(matrix.Data, Is.EqualTo(data));
    }

    [Test]
    public void TestInitFailEmptyMatrix()
    {
        var data = new double[,] { };
        Assert.Throws<ArgumentException>(() => new Matrix(data));
    }

    [Test]
    public void TestAddScalar()
    {
        var result = _matrixA! + 5;
        var expectedData = new double[,] { { 6, 7, 8 }, { 9, 10, 11 } };
        Assert.That(result.Data, Is.EqualTo(expectedData));
    }

    [Test]
    public void TestAddMatrixSuccess()
    {
        var result = _matrixA! + _matrixC!;
        var expectedData = new double[,] { { 11, 22, 33 }, { 44, 55, 66 } };
        Assert.That(result.Data, Is.EqualTo(expectedData));
    }

    [Test]
    public void TestAddMatrixFailDimensions()
    {
        Assert.Throws<ArgumentException>(() => { var result = _matrixA! + _matrixB!; });
    }

    [Test]
    public void TestMulScalar()
    {
        var result = _matrixA! * 2;
        var expectedData = new double[,] { { 2, 4, 6 }, { 8, 10, 12 } };
        Assert.That(result.Data, Is.EqualTo(expectedData));
    }

    [Test]
    public void TestMulMatrixSuccess()
    {
        var result = _matrixA! * _matrixB!;
        var expectedData = new double[,] { { 58, 64 }, { 139, 154 } };
        Assert.That(result.Data, Is.EqualTo(expectedData));
    }

    [Test]
    public void TestMulMatrixFailDimensions()
    {
        Assert.Throws<ArgumentException>(() => { var result = _matrixA! * _matrixC!; });
    }
}

