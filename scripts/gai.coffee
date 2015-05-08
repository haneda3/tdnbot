# 既出url検知

module.exports = (robot) ->
  robot.hear /(.*)/i, (msg) ->
    res = run(robot.brain, msg.message.user.name, msg.match[1])
    msg.send res if res

run = (brain, name, text) ->
  url = text.match(/(https?:\/\/.*)/)
  return '' unless url

  url = url[1]
  exist = brain.get(url)
  if exist
    return '既出'
  else
    brain.set(url, '1')
    brain.save
    return ''
