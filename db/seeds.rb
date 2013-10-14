
0.upto(9) do |idx|
    User.create(
        session_id: (("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a).shuffle[0..7].join
    )
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
