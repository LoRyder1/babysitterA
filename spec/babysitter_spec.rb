# using subject.instance_variable_set is a code smell
# use let when you need to instead
# using .send method to access private methods is indicative of a design problem or could maybe the method should be public or don't test that because it is just a implementation detail

describe 'BabySit' do
  let(:start) {17}; let(:endtime) {28}
  subject {BabySit.new(start, endtime)}

  def set_obj_var classname, method, value
    allow_any_instance_of(classname).to receive(method.to_sym).and_return value 
  end

  context 'expect 2 arguments' do
    it { expect(subject.method(:initialize).arity).to eq 2 }
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

  xdescribe '#standard_rate_pay' do

    it 'calculate pay at standard rate' do
      set_obj_var CalculateHours, 'early_hours', 5
      expect(subject.send(:standard_rate_pay)).to eq 60
    end
  end

  xdescribe '#mid_rate_pay' do

    it 'calculates pay at mid rate' do
      set_obj_var CalculateHours, 'mid_hours', 2
      expect(subject.send(:mid_rate_pay)).to eq 16
    end
  end

  xdescribe '#end_rate_pay' do

    it 'calculates pay at end rate' do
      set_obj_var CalculateHours, 'end_hours', 4
      expect(subject.send(:end_rate_pay)).to eq 64
    end
  end

  xdescribe '#calculate_pay' do

    def set_diff_pay x, y, z
      allow(subject).to receive_messages(standard_rate_pay: x, mid_rate_pay: y, end_rate_pay: z)
    end

    it 'calculate total pay' do
      set_diff_pay 60, 16, 64
      expect(subject.calculate_pay).to eq 140
    end
  end

  xdescribe '#round_hours' do
    subject {BabySit.new(17.6, 22.4)}

    it 'round hours for calculating pay; start' do
      subject.round_hours
      expect(get_var_from_hours '@start').to eq 18
    end

    it 'round hours for calculating pay; endtime' do
      subject.round_hours
      expect(get_var_from_hours '@endtime').to eq 22
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

  xdescribe '#round_hours' do

    it 'rounds start to nearest hour' do
      set_var '@start', 12.4; set_var '@endtime', 0; subject.round_hours
      expect(get_var '@start').to eq 12
    end 

    it 'rounds endtime to nearest hour' do
      set_var '@endtime', 18.7; set_var '@start', 0; subject.round_hours
      expect(get_var '@endtime').to eq 19
    end
  end
end