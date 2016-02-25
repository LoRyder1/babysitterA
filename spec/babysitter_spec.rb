describe 'BabySit' do
  let(:hour) {double('hour')}
  subject {Babysit.new(hour, hour)}

  it 'expect 2 arguments' do
    expect(subject.method(:initialize).arity).to eq 2
  end
end