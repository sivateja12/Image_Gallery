<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mymvcproject.model.Image" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
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
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    grid-gap: 20px;
  }
  .image-card {
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    overflow: hidden;
  }
  .image-card img {
    width: 100%;
    height: auto;
    display: block;
    border-radius: 5px 5px 0 0;
  }
  .image-details {
    padding: 15px;
  }
  .image-details h2 {
    margin-top: 0;
    margin-bottom: 10px;
  }
  .image-details p {
    margin: 0;
  }
  .button-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
  }
  .button-container button {
    margin: 0 10px;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
  }
  .center {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 50%;
}
  
</style>
</head>
<body>

<div class="container">
  <h1>Gallery App</h1>

  <div class="gallery">
    <div class="image-card">
      <h1>Description: ${image.description}</h1>
      <h2>Location: ${image.location}</h2>
      <h2>Date: ${image.date}</h2>
      <h1>Image:</h1>
     <c:forEach var="imageData" items="${mulImages}">
   <img src="data:image/jpeg;base64,${imageData}" alt="Image" style="max-width: 70%; max-height: auto;" class="center"/>
</c:forEach>

<%--       <img src="data:image/jpeg;base64,${imageData}" alt="Image" style="max-width: 70%; max-height: auto;" class="center"/>
 --%>      <%-- </c:forEach> --%>
      <h2>${row}</h2>
    </div>
  </div>

  <div class="button-container">
    <a href="update/${image.id}"><button type="submit">Update</button></a>
    <a href="delete/${image.id }"><button type="submit">Delete</button></a>
    <a href="getImages"><button type="submit">ViewAll</button></a>
  </div>
</div>

</body>
</html>
