require('pry-byebug')
require_relative('models/bounty')


bounty1 = Bounty.new({
  'name' => 'Boba',
  'species' => 'Human',
  'bounty_value' => '1000',
  'danger_level' => 'High'
})

bounty2 = Bounty.new({
  'name' => 'IG88',
  'species' => 'Droid',
  'bounty_value' => '500',
  'danger_level' => 'Medium'
})

bounty1.save
bounty2.save

# bounty1.update

binding.pry
nil
