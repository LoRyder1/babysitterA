describe 'BabySit' do
  let(:hour) {double('hour')}
  subject {BabySit.new(hour, hour)}

  it 'expect 2 arguments' do
    expect(subject.method(:initialize).arity).to eq 2
  end

  def set_var var, value
    subject.instance_variable_set(var.to_sym, value)
  end

  describe '#valid_schedule' do

    it 'invalid schedule earlier than 5pm' do
      set_var "@start", 16; set_var "@endtime", 22
      expect(subject.valid_schedule?).to eq false
    end

    it 'invalid schedule if leave is later than 4am' do
      set_var "@start", 17; set_var "@endtime", 29
      expect(subject.valid_schedule?).to eq false
    end

    it 'valid schedule is between 17 and 28' do
      set_var "@start", 17; set_var "@endtime", 28
      expect(subject.valid_schedule?).to eq true
    end
  end
end

describe 'CalculateHours' do
  let(:hour) {double('hour')}
  subject {CalculateHours.new(hour, hour)}

  it 'expect two arguments' do
    expect(subject.method(:initialize).arity).to eq 2
  end
end