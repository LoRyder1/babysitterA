# using subject.instance_variable_set is a code smell
# use let when you need to instead
# using .send method to access private methods is indicative of a design problem or could maybe the method should be public or don't test that because it is just a implementation detail

describe 'BabySit' do
  let(:start) {17}; let(:endtime) {28}
  subject {BabySit.new(start, endtime)}

  def set_obj_var classname, method, value
    allow_any_instance_of(classname).to receive(method.to_sym).and_return value 
  end

  it 'takes in 2 arguments' do
    expect(subject.method(:initialize).arity).to eq 2
  end

  describe '#valid_schedule?' do
    context 'invalid schedule earlier than 5pm' do
      let(:start) {16}; let(:endtime) {28}
      it { expect(subject.valid_schedule?).to eq false }
    end
    
    context 'invalid schedule if leaving later than 4am' do
      let(:start) {17}; let(:endtime) {29}
      it { expect(subject.valid_schedule?).to eq false}
    end

    context 'valid schedule is between 17 and 28' do
      let(:start) {17}; let(:endtime) {28}
      it { expect(subject.valid_schedule?).to eq true}
    end
  end

  describe '#calculate_pay' do
    def set_ratepay x, y, z
      allow(subject.ratepay).to receive_messages(standard_rate: x, mid_rate: y, overnight_rate: z)
    end

    it 'calculate total pay' do
      set_ratepay 50, 25, 74
      expect(subject.calculate_pay).to eq 149
    end
  end

  describe '#round_hours' do
    let(:start) {12.4}; let(:endtime) {18.7}

    it 'round hours for calculating pay; start' do
      subject.round_hours; hours = subject.hours
      expect(hours.start).to eq 12
    end

    it 'round hours for calculating pay; endtime' do
      subject.round_hours; hours = subject.hours
      expect(hours.endtime).to eq 19
    end
  end
end

describe 'RatePay' do
  let(:hours) {double 'hours'}
  subject {RatePay.new(hours)}

  def set_hours method, value
    allow(hours).to receive(method.to_sym).and_return(value)
  end

  it 'takes in 1 argument' do
    expect(subject.method(:initialize).arity).to eq 1
  end

  describe '#standard_rate' do
    it 'calculates pay at standard rate' do
      set_hours "early_hours", 5
      expect(subject.standard_rate).to eq 60
    end
  end

  describe '#mid_rate' do
    it 'calculates pay at mid rate' do
      set_hours "mid_hours", 2
      expect(subject.mid_rate).to eq 16
    end
  end

  describe '#overnight_rate' do
    it 'calculates pay at overnight rate' do
      set_hours "overnight_hours", 4
      expect(subject.overnight_rate).to eq 64
    end
  end
end

describe 'CalculateHours' do
  let(:start) {17}; let(:endtime) {28}
  subject {CalculateHours.new(start, endtime)}

  it 'expect two arguments' do
    expect(subject.method(:initialize).arity).to eq 2
  end

  describe '#early_hours' do
    it 'calculates hours to bedtime' do
      expect(subject.early_hours).to eq 5
    end
  end

  describe '#mid_hours' do
    it 'calculates bedtime to midnight' do
      expect(subject.mid_hours).to eq 2
    end
  end

  describe '#end_hours' do
    it 'calculates midnight to end' do
      expect(subject.overnight_hours).to eq 4
    end
  end
end