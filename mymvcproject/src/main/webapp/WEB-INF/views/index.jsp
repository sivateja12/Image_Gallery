<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html>
<head>
    <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%; /* Changed width to 100% */
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 6px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>
    <!-- Removed redundant Bootstrap JS and CSS links -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-1" style="background-color: #454545; padding: 20px;">
            <!-- First part with some space
            You can add content or leave it empty for space -->
        </div> 
        
        <div class="col-md-9" style="padding:20px;">
            <!-- Second part with the table -->
            <div class="card">
                <div class="card-body">
                    <h1 class="card-title" style="text-align:center;margin-bottom:30px">Welcome to Gallery Br0</h1>
                    <table>
                        <tr>
                            <th>S.no</th>
                            <th>Description</th>
                            <th>Location</th>
                            <th>Date</th>
                            <th>Image</th>
                            <th>Action</th>
                        </tr>
                        <c:if test="${not empty allImages}">
                           <c:forEach var="image" items="${allImages}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${image.description}</td>
                                    <td>${image.location}</td>
                                    <td>
   									${image.date}
									</td>

                                    <td>
                                       <c:if test="${not empty imageDataList[loop.index]}">
                                            <img src="data:video/mp4;base64,${imageDataList[loop.index]}" width="100px" height="100px" />
                                        </c:if>

                                    </td>
                                    <td>
                                       <a href="delete/${image.id }"><button type="button" style="width:90px;cursor:pointer;height:40px;background-color:red;">Delete</button></a>
                                       <a href="update/${image.id }"><button type="button" style="width:90px;cursor:pointer;height:40px;background-color:blue;">Update</button></a>
                                       <a href="download/${image.id }"><button type="button" style="width:90px;cursor:pointer;height:40px;background-color:green;">Download</button></a>
                                       
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty allImages}">
                            <tr>
                                <td colspan="5" style="text-align: center;">No images available.</td>
                            </tr>
                        </c:if>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="col-md-2" style="background-color:#454545;padding: 20px;">
            <!-- Third part with add, delete, and update buttons -->
            <div class="container" style="margin-top:30px;text-align:center;">
                <a href="addImage"><button type="submit" style="width:110px;cursor:pointer;height:50px;background-color:yellow;">Add Image</button></a>
                <a href="getImages"><button type="submit" style="width:110px;cursor:pointer;height:50px;background-color:yellow;margin-top:15px">Show Images</button></a>
                
               <!--  <button type="button" style="width:90px;cursor:pointer;height:40px;background-color:red;">Delete</button>
                <button type="button" style="width:90px;cursor:pointer;height:40px;background-color:blue;">Update</button> -->
            </div>
        </div> 
    </div>
</div>

</body>
</html>
