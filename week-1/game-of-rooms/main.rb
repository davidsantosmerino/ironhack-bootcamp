require 'pry'
Dir["./constants/*"].each {|file| require file }
Dir["./models/*"].each {|file| require file }

#Special actions
find_food = SpecialAction.new(Constants.action_types[:look_food], Texts.result_types[:find_food])
bear_wakes = SpecialAction.new(Constants.action_types[:fire], Texts.result_types[:bear_wakes], true)
#Exits
exits0 = [Exit.new(Constants.direction_types[:E],1)]
exits1 = [Exit.new(Constants.direction_types[:W],0), Exit.new(Constants.direction_types[:S],2)]
exits2 = [Exit.new(Constants.direction_types[:N],1), Exit.new(Constants.direction_types[:S],3)]
exits3 = [Exit.new(Constants.direction_types[:N],2), Exit.new(Constants.direction_types[:E],4)]
exits4 = [Exit.new(Constants.direction_types[:W],3)]
#Spaces
space0 = Space.new 0, "You are in the forest. There is a lot of light. There is a bear sleeping.", exits0, [find_food], [Constants.object_types[:sword]],"You are in a dark room. There is a door at the east."
space1 = Space.new 1, "You are close to a lake.", exits1, [bear_wakes],[Constants.object_types[:sword]], "You are in a dark room. There is a door at the south."
space2 = Space.new 2, "You are close to a lake2.", exits2, [], [], "You are in a dark room. There is a door at the north."
space3 = Space.new 3, "You are close to a lake3.", exits3, [], [], "You are in a dark room. There is a door at the north."
space4 = Space.new 4, "You are close to a lake3.", exits4, [], [], "You are in a dark room. There is a door at the north."
#Character
character0 = Character.new
#Game
game = Game.new [space0, space1, space2, space3, space4], character0

game.start
