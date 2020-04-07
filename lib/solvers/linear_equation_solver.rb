require 'wolfram'

class LinearEquationSolver
  def initialize(equation)
    @equation = equation
  end

  def solve
    Wolfram.appid = ENV['WOLFRAM_API_KEY']
    result = Wolfram.fetch(@equation)
    hash = Wolfram::HashPresenter.new(result).to_hash
    root = hash.dig(:pods, "Solution")[0].gsub('x = ', '')
    {roots_amount: 1, solution: [root]}
  end
end
