<%@page import="com.mysql.cj.x.protobuf.MysqlxDatatypes.Object"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="org.springframework.web.multipart.commons.CommonsMultipartFile" %>
<%@ page import="java.util.Base64" %>
<%@ page import="mymvcproject.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery App</title>
    <style>
        /* Basic styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            grid-gap: 20px;
        }

        .image-card {
            position: relative;
            cursor: pointer;
            overflow: hidden;
        }

        .image-card img {
            width: 100%;
            height: auto;
            display: block;
            border-radius: 5px;
            transition: transform 0.3s ease;
        }

        .image-card:hover img {
            transform: scale(1.1);
        }

        .fullscreen-image {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.7);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999; /* Ensure the fullscreen image is on top */
        }

        .fullscreen-image img {
            max-width: 90%;
            max-height: 90%;
        }

        .exit-fullscreen-button {
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 10000; /* Ensure the button is on top of everything */
            background-color: #f44336;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px;
            cursor: pointer;
            display: none; /* Initially hidden */
        }

        .exit-fullscreen-button.show {
            display: block; /* Show when in fullscreen mode */
        }
    </style>
</head>
<body>

<div class="container">
    <h1 style="margin-bottom:30px;">Image Gallery App</h1>

    <div class="gallery">
        <!-- Loop over each image and create image cards -->
        <c:forEach var="entry" items="${imageDataMap}">
            <div class="image-card" onclick="showFullscreenImage(this)">
                <c:set var="imageData" value="${entry.key}" />
                <c:set var="description" value="${entry.value}" />
                <img src="data:image/jpeg;base64,${imageData}" data-fullscreen="data:image/jpeg;base64,${imageData}" alt="Image" />
                <h6>${description}</h6>
            </div>
        </c:forEach>
    </div>

    <!-- Fullscreen image container -->
    <div class="fullscreen-image" onclick="hideFullscreenImage()">
        <img id="fullscreen-img" src="" alt="Fullscreen Image">
        <button class="exit-fullscreen-button" onclick="exitFullscreen()">Exit Fullscreen</button>
    </div>
</div>

<div style="float:right;margin-right:90px;position:absolute; top:0; right:0;margin-top:60px;">
    <a href="${pageContext.request.contextPath }/"><button type="submit" style="margin:40px;background-color: #f44336;width:70px;height:50px;cursor:pointer;border-radius: 5px;">Home</button></a>
     <a href="${pageContext.request.contextPath }/addImage"><button type="submit" style="background-color: #008CBA;width:70px;height:50px;cursor:pointer;border-radius: 5px;">AddImage</button></a>
</div>

<script>
    function showFullscreenImage(element) {
        var fullscreenImgUrl = element.querySelector('img').getAttribute('data-fullscreen');
        document.getElementById('fullscreen-img').setAttribute('src', fullscreenImgUrl);
        document.querySelector('.fullscreen-image').style.display = 'flex';
        document.querySelector('.exit-fullscreen-button').classList.add('show'); // Show the exit fullscreen button
        document.body.style.overflow = 'hidden'; // Prevent scrolling in fullscreen mode
    }

    function hideFullscreenImage() {
        document.querySelector('.fullscreen-image').style.display = 'none';
        document.querySelector('.exit-fullscreen-button').classList.remove('show'); // Hide the exit fullscreen button
        document.body.style.overflow = ''; // Restore scrolling
    }

    function exitFullscreen() {
        document.querySelector('.fullscreen-image').style.display = 'none';
        document.querySelector('.exit-fullscreen-button').classList.remove('show'); // Hide the exit fullscreen button
        document.body.style.overflow = ''; // Restore scrolling
    }
</script>

</body>
</html>
