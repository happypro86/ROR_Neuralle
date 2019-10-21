// Class to manage the form calendar

function Calendar(){
  this.dayContainer = $('.form-calendar-days');
  this.headerContainer = $('.form-calendar-header');
  this.displayedMonth = moment().month() + 1;
  this.displayedYear = moment().year();
  this.updateDisplay();
}

Calendar.prototype = {
  constructor: Calendar,
  
  // Updates the display to the saved month and year
  updateDisplay: function(){
    var firstDay = moment(this.displayedYear + '-' + this.displayedMonth, 'YYYY-MM');
    var selectableDays = [];
    for (var currentDay = 1; currentDay <= firstDay.daysInMonth(); currentDay += 1){
      var thisDay = moment(firstDay).date(currentDay);
      selectableDays.push(thisDay);
    }
    var weekStartsAt = selectableDays[0].isoWeekday();
    var addBeginningDays = weekStartsAt % 7;
    var weekEndsAt = selectableDays[selectableDays.length - 1].isoWeekday();
    var addEndDays = 6 - (weekEndsAt % 7);
    
    this.addDaysToPage(addBeginningDays, selectableDays, addEndDays);
    this.updateHeader();
  },
  
  // Adds a list of days to the page
  addDaysToPage: function(beginningDays, selectableDays, endDays){
    var daysToAdd = [];
    var self = this;
    
    // Add days at beginning
    var firstDay = selectableDays[0];
    for (var day = beginningDays; day > 0; day -= 1){
      var previousDay = moment(firstDay).subtract(day, 'days');
      daysToAdd.push(self.addDay(previousDay, false));
    }
    
    // Add selectable days
    selectableDays.forEach(function(day){
      daysToAdd.push(self.addDay(day, true));
    });
    
    // Add days at end
    var lastDay = selectableDays[selectableDays.length - 1];
    for (var day = 1; day <= endDays; day += 1){
      var futureDay = moment(lastDay).add(day, 'days');
      daysToAdd.push(self.addDay(futureDay, false));
    }
    
    this.dayContainer.empty().append(daysToAdd);
  },
  
  // Adds a single day element to the page
  addDay: function(newDay, isSelectable){
    var defaultClass = ['calendar-day'];
    if(isSelectable){
      defaultClass.push('selectable'); 
    }
    if(this.selectedDate && this.selectedDate.isSame(newDay, 'day')){
      defaultClass.push('selected');
    }
    var dayToAdd = $('<div/>')
      .attr('data-date', newDay.format('YYYY-MM-DD'))
      .attr('class', defaultClass.join(' '))
      .text(newDay.date());
      
    return dayToAdd;
  },
  
  // Returns a moment for the current month
  currentMonthMoment: function(){
    return moment(this.displayedYear + '-' + this.displayedMonth, 'YYYY-MM');
  },
  
  // Updates the calendar headers
  updateHeader: function(){
    var monthToDisplay = this.currentMonthMoment();
    this.headerContainer.find('.month').text(monthToDisplay.format('MMMM, YYYY'));
  },
  
  // Set displayMonth to previous month
  previousMonth: function(){
    var thisMonth = this.currentMonthMoment();
    thisMonth.subtract(1, 'months');
    this.displayedMonth = thisMonth.month() + 1;
    this.displayedYear = thisMonth.year();
    this.updateDisplay();
  },
  
  // Set displayMonth to next month
  nextMonth: function(){
    var thisMonth = this.currentMonthMoment();
    thisMonth.add(1, 'months');
    this.displayedMonth = thisMonth.month() + 1;
    this.displayedYear = thisMonth.year();
    this.updateDisplay();
  },
  
  // Selects the day
  selectDay: function(child){
    var date = $(child).data('date');
    this.dayContainer
      .parent('.form-calendar')
      .find('#requested_date')
      .val(date);
    this.selectedDate = moment(date);
      
    this.dayContainer.children().removeClass('selected');
    $(child).addClass('selected');
  }
}

$(document).ready(function(){
  var calendar = new Calendar();
  
  // Make the month days selectable
  $('.form-calendar').on('click', '.selectable.calendar-day', function(event){
    calendar.selectDay(this);
  });
  
  // Make the change month links clickable
  $('.form-calendar').on('click', '.goToPrevious', function(event){
    calendar.previousMonth();
  });
  $('.form-calendar').on('click', '.goToNext', function(event){
    calendar.nextMonth();
  });
});