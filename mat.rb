require 'matrix'

SIZE = 500

def random_matrix
  Matrix.build(SIZE, SIZE) {|row, col| rand }
end

A = random_matrix
B = random_matrix
C = Matrix.identity(SIZE)

t1 = Time.now
(0..SIZE-1).each do |i|
  (0..SIZE-1).each do |j|
    (0..SIZE-1).each do |k|
      C[i,j] = C[i,j] + A[i,k] * B[k,j]
    end
  end
end
t2 = Time.now
puts "completed in #{t2 - t1}"
