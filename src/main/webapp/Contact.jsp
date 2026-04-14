<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Vasota Lake Camping</title>
    <link rel="stylesheet" href="Index.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        .container {
            max-width: 500px;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
        }

        h2 {
            color: #333;
        }

        label {
            display: block;
            text-align: left;
            font-weight: bold;
            margin: 10px 0 5px;
        }

        input, textarea, button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        button {
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border: none;
            font-size: 18px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .message {
            margin-top: 10px;
            color: green;
            font-weight: bold;
        }

        .contact-info {
            margin-top: 20px;
            text-align: center;
        }

        .contact-info p {
            font-size: 18px;
            color: #333;
        }

        iframe {
            width: 100%;
            height: 250px;
            border-radius: 10px;
            margin-top: 20px;
        }
        
    </style>
    
</head>
<body>

   
    <div class="container">
        <h2>Contact Us</h2>
        
        <form id="contactForm" method="POST" action="./Contact">
            <label for="name">Full Name</label>
            <input type="text" id="name" placeholder="Enter your name"  name="uname" required>

            <label for="email">Email</label>
            <input type="email" id="email" placeholder="Enter your email" name="email"  required>

            <label for="message">Message</label>
            <textarea id="message" rows="4" placeholder="Enter your message" name="msg" required></textarea>

            <button type="submit">Send Message</button>
            
            <p class="text-success" style="font-weight:bold">${msg}</p>
        </form>

        <p class="message" id="confirmationMessage"></p>
    </div>

    <div class="contact-info">
        <h3>Get in Touch</h3>
        <p><strong>&#128205; Location:</strong> Vasota Lake, Maharashtra, India</p>
        <p><strong> &#128222; Phone:</strong> +91 9579350747</p>
        <p><strong>&#128231; Email:</strong> info@vasotalakecamping.com</p>

        <!-- Google Maps Embed (Replace with actual coordinates) -->
        <iframe 
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3156.617032504961!2d73.7696871!3d17.6666735!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x7e0b5c5eb7b7d1e1!2sVasota%20Lake!5e0!3m2!1sen!2sin!4v1614256139072!5m2!1sen!2sin" 
            allowfullscreen="" loading="lazy">
        </iframe>
    </div>

    <script>
        document.getElementById("contactForm").addEventListener("submit", function(event) {
            event.preventDefault();
            let name = document.getElementById("name").value;
            let email = document.getElementById("email").value;
            let message = document.getElementById("message").value;
    
                document.getElementById("contactForm").reset();
            } else {
                alert("Please fill out all fields.");
            }
        });
    </script>
    
</body>
</html>