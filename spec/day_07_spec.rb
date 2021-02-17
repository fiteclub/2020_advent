require_relative '../day_07/bag_00'
require_relative '../helpers'

test_handler = BagHandler.new(get_data('day_07/test_input.txt', 'array'))
test_handler2 = BagHandler.new(get_data('day_07/test_input_2.txt', 'array'))
test_bag = test_handler.list.first[1]

RSpec.describe 'Bag class' do
  it 'returns name of bag' do
    expect(test_bag.name).to eq("light_red")
  end

  it 'returns contents of bag' do
    expect(test_bag.contents).to eq({ :bright_white=>1, :muted_yellow=>2 })
  end

  it 'has enumerator methods' do
    expect(test_bag.each).to be_an Enumerator
  end

  it 'returns an array if a given bag can be found inside' do
    expect(test_bag.has_inside(test_handler.list, 'shiny_gold')).to eq(
      ['light_red', 'bright_white', 'shiny_gold' ]
    )
  end

  it 'returns nil if a given bag cannot be found inside' do
    expect(test_bag.has_inside(test_handler.list, 'hideous_green')).to be nil
  end

  # it 'returns the sum of all bags contained within a given bag' do
  #   expect(test_bag.sum_inside(test_handler.list, 'shiny_gold')).to eq(126)
  # end
end



RSpec.describe 'BagHandler class' do
  it 'takes in raw data array' do
    expect(test_handler.input[0].slice(0,9)).to eq("light red")
  end

  it 'takes in raw data and creates a hash of Bag objects' do
    expect(test_handler.list.first[0]).to eq(test_bag.name.to_sym)
    expect(test_handler.list.first[1].name).to eq(test_bag.name)
    expect(test_handler.list.first[1].contents).to eq(test_bag.contents)
  end

  it 'has enumerator methods' do
    expect(test_handler.each).to be_an Enumerator
  end

  it 'searches for a given bag and returns array of possible bag container combinations' do
    expect(test_handler.search('shiny_gold')).to eq([
        [ 'light_red', 'bright_white', 'shiny_gold' ],
        [ 'dark_orange', 'bright_white', 'shiny_gold' ],
        [ 'bright_white', 'shiny_gold' ],
        [ 'muted_yellow', 'shiny_gold' ]
    ])
  end

  it 'searches for a given bag and returns nil if the bag is not found in any other bags' do
    test_handler.list[:awful_green] = Bag.new('awful_green',{})
    expect(test_handler.search('awful_green')).to be nil
  end

  it 'returns the sum of all bags contained within a given bag' do
    expect(test_handler.capacity('shiny_gold')).to eq(32)
    # expect(test_handler2.capacity('shiny_gold')).to eq(126)
  end

  it 'returns the sum of all bags contained within a given bag' do
    expect(test_handler2.capacity('shiny_gold')).to eq(126)
  end
end
