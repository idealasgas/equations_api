require 'sinatra'
require 'sinatra/json'
require_relative 'quadratic_equation_solver'

QUADRATIC_REGEX = /^-?(\d*[\.,])?\d*x\^2([+-](\d*[\.,])?\d*x)?[+-](\d*[\.,])?\d*=0$/

post '/' do
  request.body.rewind
  data = JSON.parse(request.body.read)
  equation = data["equation"]

  solver = get_solver(equation)
  result = solver.solve

  json :roots => result
end

def get_solver(equation)
  if equation.gsub(' ', '').match?(QUADRATIC_REGEX)
    QuadraticEquationSolver.new(equation)
  else
    LinearEquationSolver.new
  end
end
