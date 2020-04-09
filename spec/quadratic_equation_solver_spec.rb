require File.expand_path '../spec_helper.rb', __FILE__

describe QuadraticEquationSolver do
  describe '#solve' do
    it 'should solve full equation with 2 roots' do
      solver = described_class.new('x^2+x-6=0')
      result = solver.solve

      expect(result.dig(:solution)).to eq([2.0, -3.0])
      expect(result.dig(:roots_amount)).to eq(2)
      expect(result.dig(:error)).to be false
    end

    it 'should solve full equation with 1 root' do
      solver = described_class.new('x^2-6x+9=0')
      result = solver.solve

      expect(result.dig(:solution)).to eq([3.0])
      expect(result.dig(:roots_amount)).to eq(1)
      expect(result.dig(:error)).to be false
    end

    it 'should solve full equation with no roots' do
      solver = described_class.new('5x^2+3x+7=0')
      result = solver.solve

      expect(result.dig(:roots_amount)).to eq(0)
      expect(result.dig(:error)).to be false
    end

    it 'should solve equation with b = 0' do
      solver = described_class.new('x^2-4=0')
      result = solver.solve

      expect(result.dig(:solution)).to eq([2.0, -2.0])
      expect(result.dig(:roots_amount)).to eq(2)
      expect(result.dig(:error)).to be false
    end

    it 'should solve equation with c = 0' do
      solver = described_class.new('x^2-6x=0')
      result = solver.solve

      expect(result.dig(:solution)).to eq([6.0, 0.0])
      expect(result.dig(:roots_amount)).to eq(2)
      expect(result.dig(:error)).to be false
    end

    it 'should solve equation if there are spaces between symbols' do
      solver = described_class.new('x  ^   2   -  6 x  +  9  = 0  ')
      result = solver.solve

      expect(result.dig(:solution)).to eq([3.0])
      expect(result.dig(:roots_amount)).to eq(1)
      expect(result.dig(:error)).to be false
    end

    it 'should  solve equation if coefficients are fractional' do
      solver = described_class.new('0.5x^2-1.5x+1.7=0')
      result = solver.solve

      expect(result.dig(:solution)).to eq([0.75, 0.0])
      expect(result.dig(:roots_amount)).to eq(2)
      expect(result.dig(:error)).to be false
    end
  end
end
