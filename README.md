Matrix Multiplication Study
Gabriel Bello

Overview
This repository contains a detailed study on the multiplication of 2x2 matrices using both high-level and low-level programming languages, specifically C and Assembly. The study aims to explore and compare the performance and efficiency of various implementations of matrix multiplication algorithms.

Purpose
The primary goal of this research is to evaluate the performance of four distinct implementations of 2x2 matrix multiplication, inspired by the video "Multiplying Matrices 2x2 by 2x2" from the Corbett Maths YouTube channel. The study investigates how different coding practices and optimization levels affect the performance and accuracy of matrix multiplication operations.

Implementations
The study includes four implementations of the 2x2 matrix multiplication algorithm:

C Implementation (Basic): Uses direct array access for straightforward data manipulation, aiming for easier compilation and understanding by the compiler.
C Implementation (Optimized): Also uses direct array access but includes unsafe math optimization to improve performance at the potential cost of accuracy, particularly with floating-point values.
Assembly Implementation (Memory Addresses): Utilizes x86 syntax, working directly with memory addresses using registers for more control over data access and manipulation at the byte level.
Assembly Implementation (Stack and Pointers): Uses a stack and pointers to manage memory addresses, offering a different approach to memory management for potential performance benefits.
Performance Analysis
The implementations were evaluated based on various performance metrics, including runtime, memory locality, and branch predictability. Key findings include:

Acknowledgments
Special thanks to the Corbett Maths YouTube channel for their insightful video on matrix multiplication, which inspired this study.

For more detailed explanations and access to the full dataset, please refer to the files in this repository.
