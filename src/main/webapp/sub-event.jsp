<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%
    	String me_name = request.getParameter("me_name");
    	String me_year = request.getParameter("me_year");
    	String me_id = request.getParameter("me_id");
    
    %>
    
<div class="container">

        <h1 class="mt-5">Non-Evaluative Credits Management</h1>




        <nav aria-label="breadcrumb" class="mt-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item link-primary cursor-pointer" onclick="loadMainEvent()">All Events</li>
                <li class="breadcrumb-item active" aria-current="page" id="me_title"><%=me_name %> <%=me_year %></li>
            </ol>
        </nav>

        <!-- <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item"><a href="#">Library</a></li>
                <li class="breadcrumb-item active" aria-current="page">Data</li>
            </ol>
        </nav> -->


        <h4 class="mt-4">
            <%= me_name%>
            <span class="badge bg-secondary ms-2"><%=me_year %></span>
        </h4>

        <div class="d-flex justify-content-end align-items-center mt-3">
            <div class="filter">
                <span>Filter by</span>
                <select class="custom-select custom-select-sm" id="filter-field" onchange="loadSubEventTable(<%= me_id%>)">
                    <option selected value="NAME">Name</option>
                    <option value="HOURS">Hours</option>
                    <option value="ID">ID</option>
                </select>
                <input class="form-group" type="text" placeholder="Search" id="filter-query" onkeyup="loadSubEventTable(<%= me_id%>)">
            </div>
            <div class="sort ms-4">
                <span>Sort by</span>
                <select class="custom-select custom-select-sm" id="sort-field" onchange="loadSubEventTable(<%= me_id%>)">
                    <option selected value="NAME">Name</option>
                    <option value="HOURS">Hours</option>
                    <option value="ID">ID</option>
                </select>
                <select class="custom-select custom-select-sm" id="sort-direction" onchange="loadSubEventTable(<%= me_id%>)">
                    <option selected value="ASCENDING">Ascending</option>
                    <option value="DESCENDING">Descending</option>
                </select>
            </div>




            <button type="button" class="btn btn-secondary ms-4" data-bs-toggle="modal"
                data-bs-target="#addNewSubEventModal">+</button>




            <div class="modal" tabindex="-1" role="dialog" id="addNewSubEventModal">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add a new sub-event</h5>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close"
                                onclick="$('#addNewSubEventModal').modal('toggle')">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Sub-event name</span>
                                <input type="text" class="form-control" aria-label="Sizing example input"
                                    aria-describedby="inputGroup-sizing-default" id="se_name">
                            </div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Number of hours</span>
                                <input type="number" min=0 class="form-control" aria-label="Sizing example input"
                                    aria-describedby="inputGroup-sizing-default" placeholder="0" id="se_hours">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="addNewSubEvent('<%= me_id %>')">Save sub-event</button>
                        </div>
                    </div>
                </div>
            </div>

<!-- Modal to Edit Sub-Event -->

            <div class="modal" tabindex="-1" role="dialog" id="editRow">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit entry</h5>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close"
                                onclick="$('#editRow').modal('toggle')">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Sub-event name</span>
                                <input type="text" class="form-control" aria-label="Sizing example input"
                                    aria-describedby="inputGroup-sizing-default">
                            </div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Number of hours</span>
                                <input type="number" min=0 class="form-control" aria-label="Sizing example input"
                                    aria-describedby="inputGroup-sizing-default" placeholder="0">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary">Save sub-event</button>
                        </div>
                    </div>
                </div>
            </div>
            
<!-- Modal to Delete Sub-Event -->

            <div class="modal" tabindex="-1" role="dialog" id="deleteRow">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete entry</h5>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close"
                                onclick="$('#deleteRow').modal('toggle')">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group mb-3">
                                <span id="inputGroup-sizing-default">Are you sure?</span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                onclick="$('#deleteRow').modal('toggle')">No</button>
                            <button type="button" class="btn btn-secondary">Yes</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <table class="table mt-5">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col" colspan="2">Sub-event name</th>
                    <th scope="col">Hours</th>
                    <th scope="col">Sub-event ID</th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody id="table-content">
                
            </tbody>
        </table>
        <div class="d-flex justify-content-center mt-5">
            <button type="button" class="btn btn-secondary">More</button>
        </div>
    </div>