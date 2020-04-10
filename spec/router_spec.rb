require File.expand_path '../spec_helper.rb', __FILE__

describe 'Equations Application' do
  it 'should be accessible with correct key in header' do
    post '/', {equation: 'x-6=0'}.to_json, {'HTTP_AUTHORIZATION' => 'Basic '+ENV['ENCRYPTED_KEY']}

    expect(last_response).to be_ok
  end

  it 'should not be accesible with wrong key in header' do
    post '/', {equation: 'x-6=0'}.to_json, {'HTTP_AUTHORIZATION' => 'vsem privet'}

    expect(last_response).not_to be_ok
  end

  it 'should not be accesible without auth header' do
    post '/', {equation: 'x-6=0'}.to_json

    expect(last_response).not_to be_ok
  end

  it 'should return error if input is incorrect' do
    post '/', {equation: 'aaaa'}.to_json, {'HTTP_AUTHORIZATION' => 'Basic '+ENV['ENCRYPTED_KEY']}

    expect(JSON.parse(last_response.body)['error']).to be true
  end

  it 'should return amount of roots' do
    post '/', {equation: 'x^2-4=0'}.to_json, {'HTTP_AUTHORIZATION' => 'Basic '+ENV['ENCRYPTED_KEY']}
    roots_amount = JSON.parse(last_response.body).dig('roots_amount')

    expect(roots_amount).to be_integer
    expect(roots_amount).to be <= 2
  end
end
