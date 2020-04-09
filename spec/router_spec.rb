require File.expand_path '../spec_helper.rb', __FILE__

describe 'Equations Application' do
  it 'should be accessible' do
    post '/', {equation: 'x-6=0'}.to_json

    expect(last_response).to be_ok
  end

  it 'should return error if input is incorrect' do
    post '/', {equation: 'aaaa'}.to_json

    expect(JSON.parse(last_response.body)['error']).to be true
  end

  it 'should return amount of roots' do
    post '/', {equation: 'x^2-4=0'}.to_json
    roots_amount = JSON.parse(last_response.body).dig('roots_amount')

    expect(roots_amount).to be_integer
    expect(roots_amount).to be <= 2
  end
end
