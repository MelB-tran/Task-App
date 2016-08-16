<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.Tasks.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
     <meta charset="utf-8" />
    <title>Tasks List</title>
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../style/bootstrap.min.css" type="text/css"/>
    <link rel="stylesheet" href="../style/custom-style.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
      <div class="container">
        <div class="jumbotron">
        <h1>Task List</h1>
        <p class="lead">This app is based on part of a project I developed for Hendrix </p>
        <p><a href="#" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
        <div class="row task-menu">
            <div class="col-md-2">
                <h4>Options</h4>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                  <select class="form-control" data-bind="options: filters, value: pickedFilter, optionsCaption: 'All Tasks'"></select>
                </div>
            </div>
             <div class="col-md-4">
                <div class="input-group">
                  <input type="text" class="form-control" data-bind="value: searchTerm" placeholder="Search for..." />
                </div><!-- /input-group -->
              </div><!-- /.col-md-4 -->
            <div class="col-md-3">
                  <button class="btn btn-default" data-bind="click: toggleAdd, text: newTaskAdd() ? 'Cancel' : 'Add Task'"></button>
            </div>
        </div>
        </div>
        <%--<div class="row">
            <div class="col-md-8">
                <div class="alert alert-info" role="alert" id="info" ></div>
            </div>
        </div>--%>
        <div class="row" data-bind="visible: newTaskAdd">
            <div class="col-md-4">
                <div class="form-group">
                    <label>What needs to be done?</label>
                <input class="form-control" data-bind="value: newTaskTitle" />
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label>Due</label>
                    <input type="date" class="form-control" data-bind="value: newDueDate"/>
                </div>
            </div>
            <div class="col-md-3"><button class="btn btn-default" data-bind="click: addTask">Add</button></div>
        </div>
        <div data-bind="template: { name: displayMode, foreach: filteredTasks }"></div>

        <script type="text/html" id="viewTask-template">
            <div class="task">
            <div class="row">
                <div class="col-md-1 col-sm-1">
                    <div class="form-group"><div class="checkbox">
                        <label>
                          <input data-bind="checked: IsDone" type="checkbox"/>
                        </label>
                    </div>
                </div>
                </div>
                <div class="col-md-2"><b>Due:</b><span data-bind="text: moment(Due()).format('l')"></span></div>
                <div class="col-md-6"><a href="#" data-bind="click: $root.setEditMode">
                    <h4 data-bind="text: Title, css: IsDone() ? 'doneTask' : ''"></h4></a>
                    <small><span data-bind="text: Description"></span></small>
                </div>
            </div>
            </div>
        </script>
        <script type="text/html" id="editTask-template">
            <div class="task">
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                    <input type="date" class="form-control" data-bind="value : moment(Due()).format('l')" />
                    </div>
                </div>
                <div class="col-md-4">
                    <input class="form-control" data-bind="value: Title"/>
                </div>
                <div class="col-md-5">
                    <input class="form-control" type="text" data-bind="value: Description"/>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2">
                    <button type="button" class="btn btn-default" data-bind="click: $root.updateTask">Update Task</button></div>
            </div>
            </div>
        </script>
      </div>
    </form>
    <script src="../scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="../scripts/bootstrap.min.js" type="text/javascript"></script>
    <script src="../scripts/knockout-2.3.0.js" type="text/javascript"></script>
    <script src="../scripts/moment.js"></script>
    <script src="../scripts/taskscript.js"></script>
</body>
</html>
