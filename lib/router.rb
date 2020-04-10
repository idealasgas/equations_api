require 'dotenv/load'
require 'sinatra'
require 'sinatra/json'
require "sinatra/cors"
require 'base64'
# require 'pry'
require_relative 'solvers/quadratic_equation_solver'
require_relative 'solvers/linear_equation_solver'

QUADRATIC_REGEX = /^-?(\d*[\.,])?\d*x\^2([+-](\d*[\.,])?\d*x)?([+-](\d*[\.,])?\d*)?=0$/
LINEAR_REGEX = /^[-]?(\d*)?((\(\d*x[+-]\d*\))|x|\(\d*[+-]\d*x\)|\d.)([=\/+-](\d*)?((\(\d*x[+-]\d*\))|x|\d*|\(\d*[+-]\d*x\)))*$/

set :allow_origin, "*"
set :allow_methods, "HEAD,POST"
set :allow_headers, "content-type,if-modified-since,authorization"
set :expose_headers, "location,link"

post '/' do
  request.body.rewind
  auth_header = request.env['HTTP_AUTHORIZATION']
  if auth_header.nil?
    halt 401
  else
    key = auth_header.gsub('Basic ', '')
    halt 401 unless Base64.decode64(key) == ENV['KEY']
  end
  data = JSON.parse(request.body.read)
  @equation = data["equation"]

  if solver.nil?
    json error: true
  else
    json(solver.solve)
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
