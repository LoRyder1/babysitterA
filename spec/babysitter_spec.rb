def set_var var, value
  subject.instance_variable_set(var.to_sym, value)
end



describe 'BabySit' do
  let(:hour) {double 'hour'}
  subject {BabySit.new(hour, hour)}

  def set_obj_var classname, method, value
    allow_any_instance_of(classname).to receive(method.to_sym).and_return value 
  end

  it 'expect 2 arguments' do
    expect(subject.method(:initialize).arity).to eq 2
  end

  describe '#valid_schedule' do

    it 'invalid schedule earlier than 5pm' do
      set_var '@start', 16; set_var '@endtime', 22
      expect(subject.valid_schedule?).to eq false
    end

    it 'invalid schedule if leave is later than 4am' do
      set_var '@start', 17; set_var '@endtime', 29
      expect(subject.valid_schedule?).to eq false
    end

    it 'valid schedule is between 17 and 28' do
      set_var '@start', 17; set_var '@endtime', 28
      expect(subject.valid_schedule?).to eq true
    end
  end

  describe '#standard_rate_pay' do

    it 'calculate pay at standard rate' do
      set_obj_var CalculateHours, 'early_hours', 5
      expect(subject.send(:standard_rate_pay)).to eq 60
    end
  end

  describe '#mid_rate_pay' do

    it 'calculates pay at mid rate' do
      set_obj_var CalculateHours, 'mid_hours', 2
      expect(subject.send(:mid_rate_pay)).to eq 16
    end
  end

  describe '#end_rate_pay' do

    it 'calculates pay at end rate' do
      set_obj_var CalculateHours, 'end_hours', 4
      expect(subject.send(:end_rate_pay)).to eq 64
    end
  end

  describe '#calculate_pay' do

    def set_diff_pay x, y, z
      allow(subject).to receive_messages(standard_rate_pay: x, mid_rate_pay: y, end_rate_pay: z)
    end

    it 'calculate total pay' do
      set_diff_pay 60, 16, 64
      expect(subject.calculate_pay).to eq 140
    end
  end
end

describe 'CalculateHours' do
  let(:hour) {double('hour')}
  subject {CalculateHours.new(hour, hour)}

  it 'expect two arguments' do
    expect(subject.method(:initialize).arity).to eq 2
  end

  describe '#early_hours' do

    it 'calculates hours to bedtime' do
      set_var '@start', 17
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
      set_var '@endtime', 28
      expect(subject.end_hours).to eq 4
    end
  end

  describe '#round_hours' do
    def get_var var
      subject.instance_variable_get(var.to_sym)
    end

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