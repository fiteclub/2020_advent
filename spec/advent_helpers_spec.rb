require_relative '../helpers.rb'

RSpec.describe 'colorize' do
  context 'when given a variable' do
    it 'makes integers bright yellow' do
      expect(colorize(4)).to eq("\e[33m\e[1m4\e[0m")
    end
    it 'makes strings green' do
      expect(colorize("ipsum lorem")).to eq("\e[32mipsum lorem\e[0m")
    end
    it 'makes falseclass red' do
      expect(colorize(false)).to eq("\e[31mfalse\e[0m")
    end
    it 'makes trueclass green' do
      expect(colorize(true)).to eq("\e[32mtrue\e[0m")
    end
    it 'makes nilclass white' do
      expect(colorize(nil)).to eq("\e[37mnil\e[0m")
    end
    it 'makes any other class green' do
      expect(colorize([nil, nil, nil])).to eq("\e[34m[nil, nil, nil]\e[0m")
    end
  end
end

RSpec.describe 'colorarray' do
  context 'when given an array' do
    it 'colorizes each item in the array' do
      expect(colorarray([1,"lorem ipsum",true,false,nil,[1,2,3]])).to eq(
        ["\e[33m\e[1m1\e[0m","\e[32mlorem ipsum\e[0m","\e[32mtrue\e[0m","\e[31mfalse\e[0m","\e[37mnil\e[0m","\e[34m[1, 2, 3]\e[0m"]
      )
    end
  end
end

RSpec.describe 'build_table' do
  it 'creates a table from a 2D array' do
    a = [["a","b","c"],[1,2,3]]
    expect(build_table(a).to_s).to eq(
      "+---+---+---+\n| \e[32ma\e[0m | \e[32mb\e[0m | \e[32mc\e[0m |\n| \e[33m\e[1m1\e[0m | \e[33m\e[1m2\e[0m | \e[33m\e[1m3\e[0m |\n+---+---+---+"
    )
  end
end

RSpec.describe 'getdata' do
  it 'imports a text file' do
    expect(get_data('spec/example.txt')).to eq("1\nlorem ipsum\ntrue\nfalse\nnil\n")
  end
end
