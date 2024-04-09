
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">

    <title>Add Image</title>
   <%--  <link href='<c:url value="/resources/css/first.css"/>'>
    <script src="<c:url value="/resources/js/alert.js" />"></script> --%>
</head>
<body>

<%-- <img alt=" my image" src="<c:url value="/resources/images/Screenshot 2023-09-03 111903.png"/>" /> --%>


<div class="container">
    <h1 class="text-center">Enter Image Details</h1>
    <form action="processadd" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <input type="text" class="form-control" id="username" name="description" required>
        </div>
        <div class="mb-3">
            <label for="location" class="form-label">Location</label>
            <input type="text" class="form-control" id="location" name="location" required>
        </div>
        <div class="mb-3">
            <label for="dob" class="form-label">Date of Capture</label>
            <input type="date" class="form-control" id="dob" name="date" required>
        </div>
        <div class="mb-3">
		  <label for="formFile" class="form-label">Default file input example</label>
		  <input class="form-control" type="file" id="formFile" name="image"   multiple>
		</div>
        
        <button type="submit" class="btn btn-primary" style="display: block; margin: 0 auto;">Submit</button>

        
    </form>
<a href="http://localhost:8080/mymvcproject/getImages">
  <button type="submit" class="btn btn-outline-success">Show Images</button>
</a>
</div>

<!-- Optional JavaScript; choose one of the two! -->

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

<!-- Option 2: Separate Popper and Bootstrap JS -->
<!--
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
        integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
        integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
-->
</body>
</html>
