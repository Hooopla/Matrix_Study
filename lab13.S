.section .note.GNU-stack,""
.global matrices_double
.global matrices_double_stack
.text

matrices_double:
  # arr1[0] * arr2[0]
  movsd (%rdi), %xmm1       # Load arr1[0] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[0] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm10       # Move result to %xmm10

  addq $8, %rdi             # arr1[1]
  addq $16, %rsi             # arr2[2]

  # arr1[1] * arr2[2]
  movsd (%rdi), %xmm1       # Load arr1[1] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[1] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm9        # Move result to %xmm9

  # (arr1[0] * arr2[0]) + (arr1[1] * arr2[1])
  addsd %xmm9, %xmm10       # Add %xmm9 to %xmm10

  # output[0] = tempA
  movsd %xmm10, (%rdx)      # Store result into memory pointed by %rdx
  addq $8, %rdx             # Move to output[1]

  # Reset pointers for next calculations
  subq $8, %rdi             # arr1[0]
  subq $16, %rsi             # arr2[0]

  # arr1[0] * arr2[1]
  movsd (%rdi), %xmm1       # Load arr1[0] into %xmm1
  addq $8, %rsi             # arr2[1]
  movsd (%rsi), %xmm2       # Load arr2[1] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm10       # Move result to %xmm10

  addq $8, %rdi             # arr1[1]
  addq $16, %rsi             # arr2[3]

  # arr1[1] * arr2[3]
  movsd (%rdi), %xmm1       # Load arr1[1] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[3] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm9        # Move result to %xmm9

  # (arr1[0] * arr2[1]) + (arr1[1] * arr2[3])
  addsd %xmm9, %xmm10       # Add %xmm9 to %xmm10

  # output[1] = tempB
  movsd %xmm10, (%rdx)      # Store result into memory pointed by %rdx
  addq $8, %rdx             # Move to output[2]

  # Reset pointers for next calculations
  subq $8, %rdi             # arr1[0]
  subq $24, %rsi            # arr2[0]

  # arr1[2] * arr2[0]
  addq $16, %rdi            # arr1[2]
  movsd (%rdi), %xmm1       # Load arr1[2] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[0] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm9        # Move result to %xmm9

  # arr1[3] * arr2[2]
  addq $8, %rdi             # arr1[3]
  addq $16, %rsi            # arr2[2]
  movsd (%rdi), %xmm1       # Load arr1[3] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[2] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm10       # Move result to %xmm10

  # (arr1[2] * arr2[0]) + (arr1[3] * arr2[2])
  addsd %xmm9, %xmm10       # Add %xmm9 to %xmm10

  # output[2] = tempC
  movsd %xmm10, (%rdx)      # Store result into memory pointed by %rdx
  addq $8, %rdx             # Move to output[3]

  # Reset pointers for final calculations
  subq $24, %rdi            # arr1[0]
  subq $16, %rsi            # arr2[0]


#double tempD = (arr1[2] * arr2[1]) + (arr1[3] * arr2[3]);
  addq $16, %rdi
  movsd (%rdi), %xmm1       # Load arr1[2] into %xmm1
  addq $8, %rsi             # arr2[1]
  movsd (%rsi), %xmm2       # Load arr2[1] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm9        # Move result to %xmm9

  # arr1[3] * arr2[3]
  addq $8, %rdi             # arr1[3]
  addq $16, %rsi            # arr2[3]
  movsd (%rdi), %xmm1       # Load arr1[3] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[3] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm10       # Move result to %xmm10

  # (arr1[2] * arr2[1]) + (arr1[3] * arr2[3])
  addsd %xmm9, %xmm10       # Add %xmm9 to %xmm10

  # output[3] = tempD
  movsd %xmm10, (%rdx)      # Store result into memory pointed by %rdx
  ret


matrices_double_stack:
  # Save the state of rdi and rsi
  pushq %rdi
  pushq %rsi

  # arr1[0] * arr2[0]
  movsd (%rdi), %xmm1       # Load arr1[0] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[0] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm10       # Move result to %xmm10

  addq $8, %rdi             # arr1[1]
  addq $16, %rsi            # arr2[1]

  # arr1[1] * arr2[1]
  movsd (%rdi), %xmm1       # Load arr1[1] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[1] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm9        # Move result to %xmm9

  # (arr1[0] * arr2[0]) + (arr1[1] * arr2[1])
  addsd %xmm9, %xmm10       # Add %xmm9 to %xmm10

  # output[0] = tempA
  movsd %xmm10, (%rdx)      # Store result into memory pointed by %rdx
  addq $8, %rdx             # Move to output[1]

  # Restore rdi and rsi
  popq %rsi
  popq %rdi

  # Save the state of rdi and rsi
  pushq %rdi
  pushq %rsi

  # arr1[0] * arr2[1]
  movsd (%rdi), %xmm1       # Load arr1[0] into %xmm1
  addq $8, %rsi             # arr2[1]
  movsd (%rsi), %xmm2       # Load arr2[1] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm10       # Move result to %xmm10

  addq $8, %rdi             # arr1[1]
  addq $16, %rsi            # arr2[3]

  # arr1[1] * arr2[3]
  movsd (%rdi), %xmm1       # Load arr1[1] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[3] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm9        # Move result to %xmm9

  # (arr1[0] * arr2[1]) + (arr1[1] * arr2[3])
  addsd %xmm9, %xmm10       # Add %xmm9 to %xmm10

  # output[1] = tempB
  movsd %xmm10, (%rdx)      # Store result into memory pointed by %rdx
  addq $8, %rdx             # Move to output[2]

  # Restore rdi and rsi
  popq %rsi
  popq %rdi

  # Save the state of rdi and rsi
  pushq %rdi
  pushq %rsi

  # arr1[2] * arr2[0]
  addq $16, %rdi            # arr1[2]
  movsd (%rdi), %xmm1       # Load arr1[2] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[0] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm9        # Move result to %xmm9

  # arr1[3] * arr2[2]
  addq $8, %rdi             # arr1[3]
  addq $16, %rsi            # arr2[2]
  movsd (%rdi), %xmm1       # Load arr1[3] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[2] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm10       # Move result to %xmm10

  # (arr1[2] * arr2[0]) + (arr1[3] * arr2[2])
  addsd %xmm9, %xmm10       # Add %xmm9 to %xmm10

  # output[2] = tempC
  movsd %xmm10, (%rdx)      # Store result into memory pointed by %rdx
  addq $8, %rdx             # Move to output[3]

  # Restore rdi and rsi
  popq %rsi
  popq %rdi

  # Save the state of rdi and rsi
  pushq %rdi
  pushq %rsi

  # arr1[2] * arr2[1]
  addq $16, %rdi            # arr1[2]
  movsd (%rdi), %xmm1       # Load arr1[2] into %xmm1
  addq $8, %rsi             # arr2[1]
  movsd (%rsi), %xmm2       # Load arr2[1] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm9        # Move result to %xmm9

  # arr1[3] * arr2[3]
  addq $8, %rdi             # arr1[3]
  addq $16, %rsi            # arr2[3]
  movsd (%rdi), %xmm1       # Load arr1[3] into %xmm1
  movsd (%rsi), %xmm2       # Load arr2[3] into %xmm2
  mulsd %xmm1, %xmm2        # Multiply %xmm1 by %xmm2, result in %xmm2
  movsd %xmm2, %xmm10       # Move result to %xmm10

  # (arr1[2] * arr2[1]) + (arr1[3] * arr2[3])
  addsd %xmm9, %xmm10       # Add %xmm9 to %xmm10

  # output[3] = tempD
  movsd %xmm10, (%rdx)      # Store result into memory pointed by %rdx

  # Restore rdi and rsi
  popq %rsi
  popq %rdi

  ret
