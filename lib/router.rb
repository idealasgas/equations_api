require 'dotenv/load'
require 'sinatra'
require 'sinatra/json'
require 'pry'
require_relative 'solvers/quadratic_equation_solver'
require_relative 'solvers/linear_equation_solver'

QUADRATIC_REGEX = /^-?(\d*[\.,])?\d*x\^2([+-](\d*[\.,])?\d*x)?([+-](\d*[\.,])?\d*)?=0$/
LINEAR_REGEX = /^[-]?(\d*)?((\(\d*x[+-]\d*\))|x|\(\d*[+-]\d*x\)|\d.)([=\/+-](\d*)?((\(\d*x[+-]\d*\))|x|\d*|\(\d*[+-]\d*x\)))*$/

post '/' do
  request.body.rewind
  data = JSON.parse(request.body.read)
  @equation = data["equation"]

  if solver.nil?
    json :error => "this is not equation"
  else
    json :roots => solver.solve
  end
end

def solver
  @solver ||= begin
    if @equation.gsub(' ', '').match?(QUADRATIC_REGEX)
      QuadraticEquationSolver.new(@equation)
    elsif @equation.gsub(' ', '').match?(LINEAR_REGEX)
      LinearEquationSolver.new(@equation)
    else
      nil
    end
  end
end
