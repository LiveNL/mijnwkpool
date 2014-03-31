require 'spec_helper'

describe Pool do

  let(:pool) { Pool.new(name: 'The Next Web Leeuwarden') }

  it 'is invalid without password if private' do
    pool.public = false
    pool.password = ''
    pool.password_confirmation = ''

    expect(pool).not_to be_valid

    pool.password = 'ikbenwacht'
    pool.password_confirmation = 'ikbenwacht'

    expect(pool).to be_valid

  end

  it 'clears password if public on save' do
    pool.public = true
    pool.password = 'ikbenwacht'
    pool.password_confirmation = 'ikbenwacht'

    pool.save
    expect(pool.password).to equal('')

    pool.password = 'ikbenechtwelwachtwoord'

    pool.save
    expect(pool.password).to equal('')

  end

  it 'matches passwords if private' do
    pool.public = false
    pool.password = 'ikbenwacht'
    pool.password_confirmation = 'ikbenwacht'

    expect(pool).to be_valid

    pool.password = 'ikbenwacht2'

    expect(pool).not_to be_valid

  end
end
