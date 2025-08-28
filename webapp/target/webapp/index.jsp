<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>DevTools Registration</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f4f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .wrapper {
            width: 100%;
            max-width: 800px;
            background-color: #ffffff;
            padding: 30px 40px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        .container {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo {
            max-width: 120px;
            display: block;
            margin: 0 auto 20px auto;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0 16px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        label {
            float: left;
            font-weight: bold;
        }

        hr {
            border: 1px solid #ddd;
            margin: 20px 0;
        }

        .registerbtn {
            background-color: #0066cc;
            color: white;
            padding: 14px 20px;
            margin: 20px 0;
            border: none;
            cursor: pointer;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
        }

        .registerbtn:hover {
            background-color: #004c99;
        }

        .signin, .about {
            text-align: center;
            margin-top: 20px;
        }

        a {
            color: #0066cc;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        h1, h2 {
            color: #333;
        }

        p {
            color: #555;
        }
    </style>
</head>
<body>

<div class="wrapper">
    <form action="action_page.php">
        <div class="container">
            <!-- Embedded Image -->
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_qLD3DqkyZ8i6x5Qs6DThOQG_w23dYdZe2w&s" 
                 alt="DevTools Logo" class="logo">
            <h1>DevTools</h1>
            <p>Please fill in this form to create an account so we can contact you for future enhancements.</p>
        </div>

        <hr>

        <label for="Name">Enter Name</label>
        <input type="text" placeholder="Enter Full Name" name="Name" id="Name" required>

        <label for="mobile">Enter Mobile</label>
        <input type="text" placeholder="Enter Mobile Number" name="mobile" id="mobile"
               pattern="[0-9]{10}" title="Please enter a 10-digit mobile number" required>

        <label for="email">Enter Email</label>
        <input type="text" placeholder="Enter Email" name="email" id="email"
               pattern="^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$" title="Enter a valid email address" required>

        <label for="psw">Password</label>
        <input type="password" placeholder="Enter Password" name="psw" id="psw"
               pattern="^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%])[A-Za-z\\d!@#$%]{8,10}$"
               title="8‑10 characters. Must include letters, numbers, and at least one special character (!@#$%)"
               required>

        <label for="psw-repeat">Confirm Password</label>
        <input type="password" placeholder="Confirm Password" name="psw-repeat" id="psw-repeat" required>

        <p>By creating an account you agree to our <a href="#">Terms & Privacy</a>.</p>

        <button type="submit" class="registerbtn">Register</button>

        <div class="signin">
            <p>Already have an account? <a href="#">Sign in</a>.</p>
        </div>

        <hr>

        <div class="about">
            <h2>About DevTools</h2>
            <p><strong>DevTools</strong> is a modern DevOps service company that empowers businesses with tools like <strong>ServiceNow, DevRev, GitHub, JFrog, Jenkins, AWS, and Octopus Deploy</strong>.</p>
            <p>We help teams streamline development, automate deployment, and accelerate digital transformation.</p>
            <p><strong>Create your account above to get started.</strong></p>
        </div>


        <div class="about">
        <h2>Our Tools</h2>
        <p>Click on a logo below to visit the official website:</p>
        <div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 20px; margin-top: 20px;">
            <!-- ServiceNow -->
            <a href="https://www.servicenow.com/" target="_blank">
                <img src="https://www.servicenow.com/content/dam/servicenow-assets/public/en-us/images/global/servicenow-logo.svg" alt="ServiceNow" style="height: 50px;">
            </a>

            <!-- DevRev -->
            <a href="https://www.devrev.ai/" target="_blank">
                <img src="https://assets-global.website-files.com/63976e08fc609131fe7b8f34/63976e08fc6091123e7b8f90_DevRev%20favicon%20(1).png" alt="DevRev" style="height: 50px;">
            </a>

            <!-- GitHub -->
            <a href="https://github.com/" target="_blank">
                <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub" style="height: 50px;">
            </a>

            <!-- JFrog -->
            <a href="https://jfrog.com/" target="_blank">
                <img src="https://jfrog.com/wp-content/uploads/2021/03/logo-jfrog.png" alt="JFrog" style="height: 50px;">
            </a>

            <!-- Jenkins -->
            <a href="https://www.jenkins.io/" target="_blank">
                <img src="https://www.jenkins.io/images/logos/jenkins/jenkins.svg" alt="Jenkins" style="height: 50px;">
            </a>

            <!-- AWS -->
            <a href="https://aws.amazon.com/" target="_blank">
                <img src="https://a0.awsstatic.com/libra-css/images/logos/aws_logo_smile_1200x630.png" alt="AWS" style="height: 50px;">
            </a>

            <!-- Octopus Deploy -->
            <a href="http


        <div class="container">
            <h2>Thank You</h2>
            <h2>DevTools — Empowering Digital Transformation.</h2>
        </div>
    </form>
</div>

</body>
</html>
