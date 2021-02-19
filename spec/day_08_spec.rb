require_relative '../day_08/boot_00'

test_data = get_data('day_08/test_input.txt', 'array')
test_list = BootList.new(test_data)
test_item = BootItem.new(test_data[0])

RSpec.describe 'BootItem class' do
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

  it 'changes the ran status' do
    test_item.run
    expect(test_item.ran).to eq(true)
  end
end


RSpec.describe 'BootList class' do
  it 'processes a string array into BootItem objects' do
    expect(test_list[0].string).to eq(test_item.string)
    expect(test_list[0].value).to eq(0)
  end
end

RSpec.describe 'BootParser class' do
  it 'interprets instructions' do
    # it 'jmp' do
    # end

    # it 'acc' do
    # end

    # it 'nop' do
    # end
  end

end
