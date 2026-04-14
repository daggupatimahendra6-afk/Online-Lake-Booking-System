<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vasota Lake Camping Gallery</title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h2 {
            margin: 20px 0;
            color: #333;
        }

        .tabs {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .tab {
            background: #ddd;
            padding: 10px 20px;
            margin: 5px;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        .tab.active {
            background: #007bff;
            color: white;
        }

        .gallery {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }

        .gallery img {
            width: 200px;
            height: 150px;
            object-fit: cover;
            border-radius: 5px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
            display: none;
        }

        .gallery img.show {
            display: block;
        }
        
    </style>
</head>
<body>

    

    <div class="tabs">
        
        <div class="tab" onclick="filterImages('nature')">Nature</div>
        <div class="tab" onclick="filterImages('camping')">Camping</div>
        <div class="tab" onclick="filterImages('trekking')">Trekking</div>
        <div class="tab" onclick="filterImages('wildlife')">Wildlife</div>
        <div class="tab active" onclick="filterImages('all')">All</div>
    </div>

    <div class="gallery">
        <img src="./images/adv.jpg" class="nature show">
        <img src="./images/family.jpg" class="nature show">
        <img src="./images/frnds.jpg" class="camping show">
        <img src="./images/lake1.jpg" class="camping show">
        <img src="./images/lake2.webp" class="trekking show">
        <img src="./images/lake3.jpg" class="wildlife show">
        <img src="./images/v1.jpg" class="camping show">
        <img src="./images/v2.jpg" class="nature show">
        <img src="./images/v3.jpg" class="camping show">
        <img src="./images/v4.jpg" class="camping show">
        <img src="./images/v5.jpg" class="trekking show">
        <img src="./images/v6.jpg" class="trekking show">
        <img src="./images/v7.jpg" class="trekking show">
        <img src="./images/v8.jpg" class="camping show">
    </div>

    <script>
        function filterImages(category) {
            let tabs = document.querySelectorAll('.tab');
            let images = document.querySelectorAll('.gallery img');

            tabs.forEach(tab => {
                tab.classList.remove('active');
                if (tab.textContent.toLowerCase() === category || category === 'all') {
                    tab.classList.add('active');
                }
            });

            images.forEach(img => {
                img.classList.remove('show');
                if (img.classList.contains(category) || category === 'all') {
                    img.classList.add('show');
                }
            });
        }
    </script>
    
    <%@ include file="Footer.jsp"%>

</body>
</html>
