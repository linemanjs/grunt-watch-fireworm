module.exports = {
  buildAnArrayOfFileTaskObjects: function(taskContext, target, grunt) {
    var watch = grunt.config('watch');
    var targets = target ? [target] : Object.keys(watch).filter(function(key) {
      return typeof watch[key] !== 'string' && !Array.isArray(watch[key]);
    });
    targets = targets.map(function(target) {
      // Fail if any required config properties have been omitted.
      target = ['watch', target];
      taskContext.requiresConfig(target.concat('files'), target.concat('tasks'));
      return grunt.config(target);
    });

    // Allow "basic" non-target format.
    if (typeof watch.files === 'string' || Array.isArray(watch.files)) {
      targets.push({files: watch.files, tasks: watch.tasks});
    }

    return targets;
  }
};
