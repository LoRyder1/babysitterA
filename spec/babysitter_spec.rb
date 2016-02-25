describe 'BabySit' do
  let(:hour) {double('hour')}
  subject {BabySit.new(hour, hour)}

  it 'expect 2 arguments' do
    expect(subject.method(:initialize).arity).to eq 2
  end

  describe '#valid_schedule' do

    it 'invalid schedule earlier than 5pm' do
      subject.instance_variable_set(:@start, 16)
      expect(subject.valid_schedule).to eq false
    end
  end
end