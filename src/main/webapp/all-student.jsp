<%@page import="java.util.List"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.StudentDao"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!-- <!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>All Students</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

    <style>
        i.fas {
            font-size: 25px;
            cursor: pointer;
            margin-left: 10px;
        }
    </style>


</head>

<body> -->
<%
	StudentDao sDao = new StudentDao(ConnectionProvider.getConnection());
	List<String> years = sDao.allYears();
	List<String> courses = sDao.allCourses();
	int count = 0;
%>

    <div class="container">
        <h1 class="mt-5">Non-Evaluative Credits Management</h1>

        <h4 class="mt-4">All Students</h4>

        <div class="d-flex justify-content-end align-items-center mt-3">
            <div class="filter">
                <span>Filter by</span>
                <select class="custom-select custom-select-sm" id="filter-field" onchange="loadAllStudentTable()">
                    <option selected value="rollno">RollNo</option>
                    <option value="name">Name</option>
                    <option value="total">Total</option>
                    <option value="remaining">Remaining</option>
                </select>
                <input class="form-group" type="text" placeholder="Search" id="filter-query">
            </div>
            <div class="sort ms-4">
               <!--  <span>Year</span> -->
                <select class="custom-select custom-select-sm" id="sort-field" onchange="loadAllStudentTable()">
                <option selected value="ALL">ALL</option>
                	<c:forEach var="i" begin="1" end="<%= years.size() %>">
                	<option value="<%=years.get(count) %>"><%=years.get(count) %></option>
                	<% count++; %>
                	</c:forEach>
                </select>
                <!-- <span>Department</span> -->
                <% count = 0; %>
                <select class="custom-select custom-select-sm" id="sort-direction" onchange="loadAllStudentTable()">
                    <option selected value="ALL">ALL</option>
                	<c:forEach var="i" begin="1" end="<%= courses.size() %>">
                	<option value="<%=courses.get(count) %>"><%=courses.get(count) %></option>
                	<% count++; %>
                	</c:forEach>
                </select>
            </div>

            <!-- <button type="button" class="btn btn-secondary ms-4" data-bs-toggle="modal"
                data-bs-target="#addNewEventModal">+</button> -->


            <!-- Modal to Add New Event  -->

            <!-- <div class="modal" tabindex="-1" role="dialog" id="addNewEventModal">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add a new event</h5>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close"
                                onclick="$('#addNewEventModal').modal('toggle')">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Name</span>
                                <input type="text" class="form-control" aria-label="Sizing example input"
                                    aria-describedby="inputGroup-sizing-default">
                            </div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Date of
                                    commencement</span>
                                <input type="date" class="form-control" aria-label="Sizing example input"
                                    aria-describedby="inputGroup-sizing-default">
                            </div> -->

                            <!-- Error text
                            <div class="alert alert-danger d-flex align-items-center" role="alert"
                                style="display:flex;justify-content: space-between;" id="error-alert">
                                <div style="display:flex;align-items: center;">
                                    <i class=" fas fa-exclamation-triangle" style="margin-right:15px"></i>
                                    An example danger alert with an icon
                                </div>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"
                                    aria-label="Close"></button>
                            </div> -->
                            <!-- Error text end

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary">Save event</button>
                        </div>
                    </div>
                </div>
            </div> -->


            <!-- Modal to Edit Event  -->

            <!-- <div class="modal" tabindex="-1" role="dialog" id="editRow">
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
                                <span class="input-group-text" id="inputGroup-sizing-default">Name</span>
                                <input type="text" class="form-control" aria-label="Sizing example input"
                                    aria-describedby="inputGroup-sizing-default">
                            </div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Date of
                                    commencement</span>
                                <input type="date" class="form-control" aria-label="Sizing example input"
                                    aria-describedby="inputGroup-sizing-default">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary">Save</button>
                        </div>
                    </div>
                </div>
            </div> -->



            <!-- Modal to Delete Event  -->

            <!-- <div class="modal" tabindex="-1" role="dialog" id="deleteRow">
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
            </div> -->




        </div>
        <table class="table mt-5">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col" >Roll No.</th>
                    <th scope="col" colspan="2">Student Name</th>
                    <th scope="col">Year</th>
                    <th scope="col">course</th>
                    <th scope="col">Total No Of Hours</th>
                    <th scope="col">Remaining Hours</th>
                </tr>
            </thead>
            <tbody id="table-content">
                <%-- <c:forEach var="i" begin="1" end="5">
				<tr>
                    <th scope="row">1</th>
                    <td>SU190267</td>
                    <td colspan="2">Vaibhav Kalal</td>
                    <td>60</td>
                    <td>120</td>
                </tr>
			</c:forEach> --%>
            </tbody>
        </table>
        <!-- <div class="d-flex justify-content-center mt-5">
            <button type="button" class="btn btn-secondary">More</button>
        </div> -->
    </div>




    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
<!-- <script type="text/javascript">


</script>

</body>

</html> -->