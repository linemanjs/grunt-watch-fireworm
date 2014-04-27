_ = require("underscore")
fireworm = require("fireworm")
backCompat = require('./../lib/back-compat')

module.exports = (grunt) ->
  grunt.registerTask "watch", "Run predefined tasks whenever watched files change.", (target) ->
    @async() #<-- TODO never done for now. Add a 'q' trap

    @requiresConfig('watch')
    targets = backCompat.buildAnArrayOfFileTaskObjects(this, target, grunt)
    fw = fireworm(process.cwd(), ignoreInitial: true)

    _(collectGlobs(targets)).each (glob) ->
      fw.add(glob)

    fw.on 'change', (filename) ->
      console.log(filename + ' just changed!')

collectGlobs = (targets) ->
  _(targets).chain().
    pluck("files").
    flatten().
    uniq().
  value()
