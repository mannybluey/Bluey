/* DO NOT MODIFY. This file was compiled Wed, 11 May 2011 23:48:54 GMT from
 * /Users/alexduller/www/bluey/app/coffeescripts/controllers/plans.coffee
 */

(function() {
  var updatePlanDays, updatePlanItems;
  updatePlanDays = function() {
    return $('.plan-day:visible').each(function(idx) {
      var day;
      day = idx + 1;
      $(this).find('span').text('Day ' + day);
      $(this).find('input[id$=_day]').attr('value', day);
      return $(this).find('.fields').each(function(pos) {
        return $(this).find('input[id$=_position]').attr('value', pos);
      });
    });
  };
  updatePlanItems = function() {
    $('.plan-item input[type=checkbox]:checked').parent().addClass('completed');
    return $('.plan-item input[type=checkbox]:not(:checked)').parent().removeClass('completed');
  };
  $(document).ready(function() {
    $('#new_plan').bind('nested:fieldAdded', updatePlanDays).bind('nested:fieldRemoved', updatePlanDays);
    $('#add-day').click(function(event) {
      var content;
      content = $('.plan-day').clone();
      content.find('span').text('Day ' + ($('.plan-day').length + 1));
      content.find('.fields').remove();
      $(this).parent().before('<div class="plan-day">' + $(content).html() + '</div>');
      return event.preventDefault();
    });
    updatePlanItems();
    return $('.plan-item input[type=checkbox]').click(function() {
      if ($(this).is(':checked')) {
        console.log('Completed item ' + $(this).attr('value'));
        return $.ajax({
          url: '/plan_items/' + $(this).attr('value'),
          type: 'put',
          data: {
            plan_item: {
              completed: true
            }
          },
          success: function() {
            return updatePlanItems();
          },
          error: function() {
            return console.log('Error');
          },
          complete: function() {
            return console.log('Complete');
          }
        });
      }
    });
  });
}).call(this);
