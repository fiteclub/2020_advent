require_relative '../day_08/boot_00'

test_data = get_data('day_08/test_input.txt', 'array')
# test_list = BootList.new(test_data)
# test_parser = BootParser.new(test_list)

RSpec.describe 'BootItem class' do
  test_item = BootItem.new(test_data[0])
  it 'returns the raw string' do
    expect(test_item.string).to eq('nop +0')
  end

  it 'returns boot action' do
    expect(test_item.action).to eq('nop')
  end

  it 'returns boot action value' do
    expect(test_item.value).to eq(0)
  end

  it 'returns whether or not the item was ran' do
    expect(test_item.ran).to eq(false)
  end

  it 'increments the run count' do
    test_item.run
    expect(test_item.runcount).to eq(1)
  end

  it 'changes the ran status' do
    test_item.run
    expect(test_item.ran).to eq(true)
  end
end


RSpec.describe 'BootList class' do
  test_list = BootList.new(test_data)
  it 'processes a string array into BootItem objects' do
    expect(test_list[0].string).to eq('nop +0')
    expect(test_list[0].value).to eq(0)
  end
end

RSpec.describe 'BootParser class' do
  context 'interprets instructions' do
    action_test = BootParser.new([])
    it 'initialize default values' do
      expect(action_test.accumulator).to eq(0)
      expect(action_test.position).to eq(0)
      expect(action_test.log).to eq([])
    end

    it 'jmp' do
      action_test.jmp(10)
      expect(action_test.position).to eq(10)
      expect(action_test.accumulator).to eq(0)
      action_test.jmp(-5)
      expect(action_test.position).to eq(5)
      expect(action_test.accumulator).to eq(0)
    end

    it 'acc' do
      action_test.acc(3)
      expect(action_test.position).to eq(6)
      expect(action_test.accumulator).to eq(3)
      action_test.acc(-1)
      expect(action_test.position).to eq(7)
      expect(action_test.accumulator).to eq(2)
    end

    it 'nop' do
      action_test.nop
      expect(action_test.position).to eq(8)
      expect(action_test.accumulator).to eq(2)
    end
  end

  context 'reads instructions' do
    instruction_parser = BootParser.new(BootList.new(test_data))
    it 'takes BootItem object from BootList as input' do
      expect(instruction_parser.bootlist[0].string).to eq(test_data.first)
    end

    it 'runs bootlist items' do
      instruction_parser.read(instruction_parser.bootlist[0])
      expect(instruction_parser.position).to eq(1)
      expect(instruction_parser.accumulator).to eq(0)
      instruction_parser.read(instruction_parser.bootlist[1])
      expect(instruction_parser.position).to eq(2)
      expect(instruction_parser.accumulator).to eq(1)
    end

    it 'modifies bootlist items when they are run' do
      instruction_parser.read(instruction_parser.bootlist[1])
      expect(instruction_parser.bootlist[0].ran).to eq(true)
      expect(instruction_parser.bootlist[0].runcount).to eq(1)
    end
  end

  context 'parses the bootlist ' do
    test_parser = BootParser.new(BootList.new(test_data))
    it 'loops until a BootItem already ran' do
      expect(test_parser.parse).to eq({ pos: 1, acc: 5, ran: false })
    end

    it 'logs activity' do
      expect(test_parser.log.length).to eq(8)
    end

    it 'parses in the correct order' do
      expect(test_parser.log.map { |i| i[:pos] }).to eq(
        [0, 1, 2, 6, 7, 3, 4, 1]
      )
    end
  end
end
