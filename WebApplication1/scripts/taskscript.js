function Task(data) {
    var self = this;
    self.TaskId = ko.observable(data.TaskId);
    self.Title = ko.observable(data.Title);
    self.StartDate = data.StarDate == null ? ko.observable(new Date()) :
        ko.observable(new Date(parseInt(data.StartDate.substr(6)))
        .toLocaleDateString("en-US"));
    self.Due = isNaN(Date.parse(data.DueDate)) ? 
        ko.observable(new Date(parseInt(data.DueDate.substr(6))))
        : ko.observable(new Date(data.DueDate));
    self.Description = data.Description == null ? ko.observable('') :
        ko.observable(data.Description);
    self.IsDone = data.IsDone == null ? ko.observable(false) :
        ko.observable(data.IsDone);
    self.InEdit = ko.observable(false);
    return self;
}

function TaskViewModel(tasksData) {
    var self = this;
    self.tasks = ko.observableArray(tasksData);

    self.filters = ko.observableArray(['Done', 'Not Done', 'Current', 'Overdue']);
    self.pickedFilter = ko.observable();
    self.searchTerm = ko.observable('');
    self.alerts = ko.observableArray();

    self.newTaskTitle = ko.observable();
    self.newDueDate = ko.observable();

    self.newTaskAdd = ko.observable(false);
    self.toggleAdd = function () {
        self.newTaskAdd(!self.newTaskAdd());
        
    }

    self.displayMode = function(task) {
        return task.InEdit() ? "editTask-template" : "viewTask-template";
    }

    self.setEditMode = function (task) {
        task.InEdit(true);
    };

    self.filteredTasks = ko.computed(function () {
        var tasksToFilter = ko.observableArray();
        if(self.searchTerm() !== ''){
            tasksToFilter(ko.utils.arrayFilter(self.tasks(), function (task) {
                return task.Title().toLowerCase().includes(self.searchTerm().toLowerCase()) ||
                    task.Description().toLowerCase().includes(self.searchTerm().toLowerCase());
            }));
        } else {
            tasksToFilter(ko.utils.arrayFilter(self.tasks(), function (task) {
                return true;
            }));
        }
        if(self.pickedFilter() === 'Done'){
             return ko.utils.arrayFilter(tasksToFilter(), function (task) {
                return task.IsDone();
            });
        } else if (self.pickedFilter() === 'Not Done') {
            return ko.utils.arrayFilter(tasksToFilter(), function (task) {
                return !task.IsDone();
            });
        } else if (self.pickedFilter() === 'Current') {
            return ko.utils.arrayFilter(tasksToFilter(), function (task) {
                return task.Due() >= new Date();
            });
        } else if(self.pickedFilter() === 'Overdue') {
            return ko.utils.arrayFilter(tasksToFilter(), function (task) {
                return !task.IsDone() && task.Due() < new Date();
            });
        } else {
            return ko.utils.arrayFilter(tasksToFilter(), function (task) {
                return true;
            });
        }
    });

    self.addTask = function () {
        var newTask = new Task({ Title: self.newTaskTitle(), DueDate: self.newDueDate() });
        self.tasks.unshift(newTask);
        self.newTaskTitle("");
        $.post('/services/TaskService.asmx/AddTask', JSON.stringify(newTask), function (response) {
            $("#info").html("Request response:" + response);
        }, 'json');
    };

    self.updateTask = function (task) {
        $("#info").html("Updated task!");
        task.InEdit(false);
        $.post('/services/TaskService.asmx/UpdateTask', JSON.stringify(task), function (response) {
            $("#info").html("Request response:" + response);
        }, 'json');
    };
}

$.getJSON("/services/TaskService.asmx/GetAllTasks", function (allData) {
    var mappedTasks = $.map(allData, function (item) { return new Task(item) });
    ko.applyBindings(new TaskViewModel(mappedTasks));
});
