# Description:
#   hubot who are you voting for
#   Ask hubot about brexit
#
# Commands:
#   hubot who will win referendum?
#   hubot are you voting?
#   hubot who is winning referendum?
#   hubot who are you voting for?
#   hubot what do you think about brexit?
#
# Author:
#   sagasu

votingAnswers = [
  "Darlin' you got to let me know Should I stay or should I go?",
  "If I go there will be trouble, An' if I stay it will be double, So come on and let me know: should I stay or should I go!",
  "What do you think?",
  "There is no way I am telling you",
  "I need to admit that I am too shy to say it out loud.",
  "You already know my answer.",
  "Ask Paul the Octopus, Big Head the Sea Turtle or Flopsy the Kangaroo",
  "Don't make me repeat myself",
  "HR, HR, HR we have a trouble maker here!",
  "Don't you have anything more important to do?",
  "Why do you want to know?",
  "Are you spying on me?",
  "Same party as you :)"
]

leavingAnswers = [
  "It is a conspiracy just like JFK case.",
  "I am packing already my teddies.",
  "Blame Bindu! It's her fault. Quickly she is escaping the building and country, grab her...",
  "Good, look at Matt stealing our jobs instead of eating el burritos in Mexico",
  "Dr Matt should by a fruit picker and not coding useless tools like me",
  "I need a hug. Can you find some nice lady to comfort me? Please...",
  "It happened to me also, they moved my dyno from US to Tokyo because I was unwelcome. I love sushi!",
  "What will happen to my pension scheme.",
  ":beer: is the answer",
  "In vino veritas",
  "Is EU going to collapse now?",
  "So it has happened",
  "We need next referendum util we get it right :imp:"
]

module.exports = (robot) ->
  robot.respond  /who are you voting for/i, (msg) ->
    msg.send msg.random votingAnswers

  robot.respond  /what do you think about brexit/i, (msg) ->
    msg.send msg.random leavingAnswers

  robot.respond  /who will win referendum/i, (msg) ->
    msg.send "we will! :heart:"
  
 robot.respond  /dados elliot/i, (msg) ->
    msg.send "Esses são os dados da Elliot! :heart:"

  robot.respond  /who is winning referendum/i, (msg) ->
    msg.send "oh no... they are. They must be cheating :cry:"

  robot.respond  /are you voting/i, (msg) ->
    msg.send "I only vote in two cases. When I drink and when I don't. What question is that, every citizen in my virtual home is voting for winning party!"
