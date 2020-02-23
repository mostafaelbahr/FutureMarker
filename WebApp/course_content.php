<?php
include "php_file_tree.php";
?>

<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <link rel="stylesheet" href="CSS/content.css">
    <link rel="stylesheet" href="CSS/couresbody.css">
    <link href="CSS/default.css" rel="stylesheet" type="text/css" media="screen" />
		
		<!-- Makes the file tree(s) expand/collapsae dynamically -->
		<script src="JS/php_file_tree.js" type="text/javascript"></script>

    <script type="text/javascript" src="JS/index.js"></script>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

    <!------ Include the above in your HEAD tag ---------->
</head>

<body style="background-color: f0f0f0">
    <nav class="navbar navbar-icon-top navbar-expand-lg navbar-dark homeheader">
        <a class="navbar-brand" href="Home.php">
            <img class="navbar-brand" src="images/logo.png">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="coures.html" >
                        Courses
                        <span class="sr-only">(current)</span>
                    </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#">

                        Groups
                    </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link " href="#">

                        Grades
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav ">
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fa fa-bell">
                            <span class="badge badge-info">11</span>
                        </i>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fa fa-search">
                            <span class="badge badge-success"></span>
                        </i>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fa fa-envelope">
                            <span class="badge badge-info">2</span>
                        </i>
                    </a>
                </li>
                <li>
                    <div class="dropdown mydrop">
                        <button type="button" class="btn btn-primary dropdown-toggle mydropbutton" data-toggle="dropdown">
                            <img src="http://www.bobmazzo.com/wp-content/uploads/2009/07/bobmazzoCD.jpg" width="30" height="30">
                            anashassan299@outlook.com
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="Profile.html">Your Profile</a>
                            <a class="dropdown-item" href="#">Future Academy</a>
                            <a class="dropdown-item" href="#">Settings</a>
                            <a class="dropdown-item" href="#"><i class="fa fa-sign-out"></i>Log out</a>
                        </div>
                    </div>
                </li>

            </ul>


        </div>
    </nav>
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="card -row my-5">
                    <div class="card-body">
                        <div>
                            <img src="images/logo-2249282902_5d8718c251f32.png" class="rounded mx-auto d-block" alt="...">

                        </div>
                        <div>
                            <hr class="my-2">
                            <div> <a class="aedit active" href="#"> <label>Matiral</label></a></div>
                            <hr class="my-3">
                            <div> <a class="aedit" href="#"> <label>Update</label></a></div>
                            <hr class="my-3">
                            <div> <a class="aedit" href="#"> <label>Grades</label></a></div>
                            <hr class="my-3">
                            <div> <a class="aedit" href="#"> <label>Members</label></a></div>
                            <hr class="my-3">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-5">
                <div class="card -row my-5">
                    <div class="card-body">
                        <div> <a href="#"><label> course name and section</label></a></div>
                        <div> <a href="#"> <label>School name</label></a></div>

                        <hr class="my-2 ">
                        <div class="container">
                            <table class="table table-sm table-light ">
                            <?php

                            echo php_file_tree("C:/xampp/htdocs/WebApp/uploads", "javascript:alert('You clicked on [link]');");

                            ?>

                                <!-- <tr class="table-active "><i class="fa fa-folder fa-2x" aria-hidden="true"></i><a href="couresbodycontent.html" class="aedit">lecture</a> </tr>
                                <hr class="my-2 ">
                                <tr class="table-active "><i class="fa fa-folder fa-2x" aria-hidden="true"></i><a href="#" class="aedit">section</a> </tr>
                                <hr class="my-2 ">
                                <tr class="table-active "><i class="fa fa-folder fa-2x" aria-hidden="true"></i><a href="#" class="aedit">Assignment</a> </tr>
                                <hr class="my-2 ">
                                <tr class="table-active "><i class="fa fa-folder fa-2x" aria-hidden="true"></i><a href="#" class="aedit">labs</a> </tr>
                                <hr class="my-2 ">
                                <tr class="table-active "><i class="fa fa-folder fa-2x" aria-hidden="true"></i><a href="#" class="aedit">labs</a> </tr>
                                <hr class="my-2 ">
                                <tr class="table-active "><i class="fa fa-folder fa-2x" aria-hidden="true"></i><a href="#" class="aedit">labs</a> </tr>
                                <hr class="my-2 ">
                                <tr class="table-active "><i class="fa fa-folder fa-2x" aria-hidden="true"></i><a href="#" class="aedit">labs</a> </tr>
                                <hr class="my-2 ">
                                <tr class="table-active "><i class="fa fa-folder fa-2x" aria-hidden="true"></i><a href="#" class="aedit">labs</a> </tr>
                                <hr class="my-2 "> -->


                            </table>
                        </div>

                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card -row my-5">
                    <div class="card-body">
                        <h>overdue</h>
                        <hr class="my-2">
                        <div class="raw">
                            <div class="diveditsecond">
                                sunday.1 dec 2019
                                <hr class="my-1">
                                <img src="http://www.bobmazzo.com/wp-content/uploads/2009/07/bobmazzoCD.jpg" width="20" height="20">
                                <a href="#">Assignment 1</a>
                                11:59pm


                            </div>

                        </div>
                        <hr class="my-2">
                        <h>Upcoming</h>
                        <hr class="my-2">
                        <div class="raw">
                            <div class="diveditsecond">
                                sunday.1 dec 2019
                                <hr class="my-1">
                                <img src="http://www.bobmazzo.com/wp-content/uploads/2009/07/bobmazzoCD.jpg" width="20" height="20">
                                <a href="#">Assignment 1</a>
                                11:59pm


                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <!-- Footer -->
    <div class="footerstyle">
        <p>©Future Marker 2020 Copyright:s</p>
    </div>
</body></html>