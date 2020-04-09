require 'wolfram'

class LinearEquationSolver
  def initialize(equation)
    @equation = equation
  end

  def solve
    Wolfram.appid = ENV['WOLFRAM_API_KEY']
    result = Wolfram.fetch(@equation)
    hash = Wolfram::HashPresenter.new(result).to_hash
    result = hash.dig(:pods, "Solution")
    if result.nil?
      {error: true}
    else
      root = result[0].gsub('x = ', '')
      {roots_amount: 1, solution: [root], error: false}
    end
  end
end
