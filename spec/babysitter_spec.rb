describe 'BabySit' do
  let(:hour) {double('hour')}
  subject {BabySit.new(hour, hour)}

  it 'expect 2 arguments' do
    expect(subject.method(:initialize).arity).to eq 2
  end

  describe '#valid_schedule' do

    it 'invalid schedule earlier than 5pm' do
      subject.instance_variable_set(:@start, 16)
      subject.instance_variable_set(:@endtime, 16)
      expect(subject.valid_schedule?).to eq false
    end

    it 'invalid schedule if leave is later than 4am' do
      subject.instance_variable_set(:@start, 17)
      subject.instance_variable_set(:@endtime, 29)
      expect(subject.valid_schedule?).to eq false
    end

    it 'valid schedule is between 17 and 28' do
      subject.instance_variable_set(:@start, 17)
      subject.instance_variable_set(:@endtime, 28)
      expect(subject.valid_schedule?).to eq true
    end

  end
end