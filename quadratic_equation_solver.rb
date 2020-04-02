class QuadraticEquationSolver
  A_REGEX = /-?(\d+[\.,])?\d+x\^2/.freeze
  B_REGEX = /-?(\d+[\.,])?\d+x(?!\^2)/.freeze
  C_REGEX = /(?<!\^)-?(\d+[\.,])?\d+(?!x)/.freeze
  X_SQUARE = 'x^2'.freeze
  X_REGEX = /x(?!\^2)/.freeze
  X = 'x'.freeze

  def initialize(equation)
    @equation = equation.gsub(' ', '').gsub(',', '.')
  end

  def solve
    get_params
    count_discriminant
    calculate_roots
  end

  private
  def get_params
    a_match = @equation.match(A_REGEX)
    @a = a_match.nil? ? 1.0 : a_match[0].sub(X_SQUARE, '').to_f

    b_match = @equation.match(B_REGEX)
    if b_match.nil?
      @b = @equation.match?(X_REGEX) ? 1.0 : 0.0
    else
      @b = b_match[0].sub(X, '').to_f
    end

    c_match = @equation.match(C_REGEX)
    @c = c_match.nil? ? 0.0 : c_match[0].to_f
  end

  def count_discriminant
    @D = @b**2 - 4 * @a * @c
  end

  def calculate_roots
    if @D < 0
      'there are no roots'
    elsif @D == 0
      root = -@b / 2*@a
      "root: x = #{root}"
    elsif @D > 0
      root_1 = (-@b + Math.sqrt(@D)) / 2 * @a
      root_2 = (-@b - Math.sqrt(@D)) / 2 * @a
      "roots: x1 = #{root_1}, x2 = #{root_2}"
    end
  end
end
