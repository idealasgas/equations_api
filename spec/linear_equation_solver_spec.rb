require File.expand_path '../spec_helper.rb', __FILE__

describe LinearEquationSolver do
  it 'should solve linear equation' do
    solver = described_class.new('5x=10')
    result = solver.solve

    expect(result.dig(:solution)).to eq(['2'])
    expect(result.dig(:roots_amount)).to eq(1)
    expect(result.dig(:error)).to be false
  end

  it 'should return error if input is incorrect' do
    solver = described_class.new('5x+675==+++=10')

    expect(solver.solve.dig(:error)).to be true
  end
end
