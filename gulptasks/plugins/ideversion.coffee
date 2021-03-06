
fs = require("fs")

pkgInfo = null

version = ()->
  if pkgInfo then return pkgInfo.version

  pkgInfo = JSON.parse( fs.readFileSync("./package.json", { encoding : 'utf8' }) )

  version = pkgInfo.version.split(".")

  version[1] = parseInt( version[1], 10 ) + 1

  date = new Date()
  time = [date.getHours(), date.getMinutes()]
  if time[1] < 10 then time[1] = "0" + time[1]
  if time[2] < 10 then time[2] = "0" + time[2]
  version[2] = time.join("")

  date = [date.getFullYear(), date.getMonth()+1, date.getDate()]
  if date[1] < 10 then date[1] = "0" + date[1]
  if date[2] < 10 then date[2] = "0" + date[2]

  pkgInfo.version = version.join(".")

  GLOBAL.gulpConfig.version = pkgInfo.version + ".#{date.join('')}"

  return GLOBAL.gulpConfig.version

read = ( update )->
  if not pkgInfo
    version()

  if update
    fs.writeFileSync("./package.json", JSON.stringify( pkgInfo, null, 2 ) )

  null

module.exports = {
  version : version
  read    : read
}
