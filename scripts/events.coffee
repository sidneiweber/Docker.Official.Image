# Description
#   Hubot script to call and register hubot events
#
# Commands:
#   hubot events add name=<name> event=<event> interval=<interval>- Add an event
#   hubot events remove name=<name>- Remove an event
#   hubot events list - Show all registered events
#   hubot events trigger name=<name> - Trigger a specific event by name
#   hubot events trigger event=<event> - Trigger a specific event by name
#
# Notes:
#   Hubot's Brain is required for this script
#
# Author:
#   René Filip <renefilip@mail.com>

CronJob = require('cron').CronJob
# humanToCron = require('human-to-cron')

jobs = {}

provideResponses = (robot) ->

  robot.respond /events add name=([^\s\\]+) event=([^\"]+) interval=([^\"]+)/i, (msg) ->
    name = msg.match[1]

    if robot.brain.data.events.hasOwnProperty(name)
      msg.reply "Name already exists"
      return

    event = msg.match[2]
    interval = msg.match[3]
    room = msg.message.room

    jobs[name] = new CronJob(
      cronTime: interval # humanToCron interval
      onTick: ->
        robot.emit event, {
          room: room
        }
      start: true
    )

    # source of truth
    robot.brain.data.events[name] =
      event: event
      interval: interval
      room: room

    msg.reply "#{name} added"

  robot.respond /events remove name=([^\s\\]+)/i, (msg) ->
    name = msg.match[1]
    if !robot.brain.data.events.hasOwnProperty(name)
      msg.reply "#{name} does not exist"
      return

    jobs[name].stop()
    delete jobs[name]
    delete robot.brain.data.events[name]

    msg.reply "#{name} deleted"

  robot.respond /events list/i, (msg) ->
    eventsCount = Object.keys(robot.brain.data.events).length
    reply = if eventsCount != 0 then "All registered events:" else "No events registered"
    for name, event of robot.brain.data.events
      reply += "\n#{name}: call \"#{event.event}\" at #{event.interval} in ##{event.room}"

    msg.reply reply

  robot.respond /events trigger name=([^\s\\]+)/i, (msg) ->
    name = msg.match[1]

    if !robot.brain.data.events.hasOwnProperty(name)
      msg.reply "#{name} does not exist"
      return

    event = robot.brain.data.events[name].event

    msg.reply "Trigger \"#{event}\" event"

    robot.emit event, {
      room: msg.message.room
    }

  robot.respond /events trigger event=([^\"]+)/i, (msg) ->
    event = msg.match[1]

    msg.reply "Trigger \"#{event}\" event"

    robot.emit event, {
      room: msg.message.room
    }


module.exports = (robot) ->

  robot.brain.on 'loaded', =>
    robot.brain.data.events ?= {}

    # load existing jobs from the brain
    for name, event of robot.brain.data.events
      jobs[name] = new CronJob(
        cronTime: event.interval # humanToCron interval
        onTick: ->
          robot.emit event.event, {
            room: event.room
          }
        start: true
      )

    # only provide methods if brain is loaded
    provideResponses robot

