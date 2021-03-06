function StatsView(lists, element) {
  this.element = $(element);
  this.lists = $(lists)
  var self = this;
  this.lists.on('added', function(e, list) {
    $(list).on('changed', function() {
      self.refresh();
    });
  });  
}

StatsView.prototype.refresh = _.debounce(function() {
  var self = this;
  $.get('/dashboard/stats').done(function(response){
    $(self.element).html(response);
  });
}, 250);