require "test_helper"

class ObservatoryTest < ActiveSupport::TestCase
  # Validations
  test 'should not save observatory without name' do
    observatory = Observatory.new(email: 'test@example.com')
    assert_not observatory.valid?
    assert_includes observatory.errors[:name], "não pode ficar em branco"
  end

  test 'should not save observatory without email' do
    observatory = Observatory.new(name: 'Test Observatory')
    assert_not observatory.valid?
    assert_includes observatory.errors[:email], "não pode ficar em branco"
  end

  # Associations
  test 'should have one observatory_conflict with dependent destroy' do
    reflection = Observatory.reflect_on_association(:observatory_conflict)
    assert_equal :has_one, reflection.macro
    assert_equal :destroy, reflection.options[:dependent]
  end

  # Callback: create_tag
  test '#create_tag creates a Tag using Observatory name' do
    observatory = Observatory.create!(name: 'Test', email: 'test@example.com', unity_type: unity_types(:one), municipality: 'RJ', state: 'Rio', address: 'Rua test' )
    assert_equal observatory.name, Tag.last.name
  end

  # Method: set_address
  test '#set_address concatenates address fields like number, city, state' do
    ninho = Observatory.new(name: 'Ninho', email: 'ninho@example.com', street: 'Av. Brasil', state: 'RJ')
    ninho.valid?
    assert_equal "Av. Brasil, RJ", ninho.address

    ninho.street = ''
    ninho.valid?
    assert_equal 'RJ', ninho.address
  end

  test '#set_address with street concatenates all address fields correctly' do
    street = 'Rua Marques de Olinda'
    number = 80
    city = 'Rio de Janeiro'

    ninho = Observatory.new(name: 'Ninho', email: 'ninho@example.com', street: street)
    ninho.valid?
    assert_equal street, ninho.address

    ninho.city = city
    ninho.valid?
    assert_equal "#{street}, #{city}", ninho.address

    ninho.number = number
    ninho.valid?
    assert_equal "#{street}, #{number}, #{city}", ninho.address
  end
end
