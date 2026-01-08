<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Add Student | Admin</title>

        <!-- LINKING GLOBAL SDM CSS -->
        <link rel="stylesheet" href="style.css">

        <style>
            /* Page-specific form styling (kept minimal because theme is in style.css) */

            .form-card {
                background: #ffffff;
                border-radius: 6px;
                /* Match style.css radius */
                padding: 30px;
                width: 450px;
                margin: auto;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
                /* Match style.css shadow */
                border-top: 4px solid #005b9f;
                /* Blue accent top */
            }

            .dashboard-title {
                text-align: center;
                color: #005b9f;
                /* Narayana Blue */
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 18px;
            }

            label {
                font-weight: 600;
                color: #444;
            }

            input,
            select {
                width: 100%;
                padding: 10px;
                margin-top: 6px;
                border-radius: 4px;
                border: 1px solid #ccc;
                font-size: 15px;
            }

            input:focus,
            select:focus {
                border-color: #005b9f;
                outline: none;
            }

            .primary-btn {
                width: 100%;
                padding: 14px;
                margin-top: 15px;
                background-color: #005b9f;
                /* Narayana Blue */
                border: none;
                border-radius: 4px;
                color: white;
                font-size: 15px;
                font-weight: bold;
                text-transform: uppercase;
                cursor: pointer;
            }

            .primary-btn:hover {
                background-color: #00447a;
                /* Darker Blue */
            }
        </style>
    </head>

    <body>

        <div class="bg">

            <!-- Red Brand Bar -->
            <div class="brand-bar">
                <div class="brand-name">SKG's Student Management System — Add Student</div>
            </div>

            <!-- Page Wrapper -->
            <div class="dashboard-wrapper">

                <!-- Add Student Card -->
                <div class="form-card">

                    <h2 class="dashboard-title">Add New Student</h2>

                    <!-- FORM START -->
                    <form action="AddStudentServlet" method="post">

                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="name" required>
                        </div>

                        <div class="form-group">
                            <label>USN</label>
                            <input type="text" name="usn" required>
                        </div>

                        <div class="form-group">
                            <label>Department</label>
                            <select name="department_id" required>
                                <option value="1">CSE</option>
                                <option value="2">ISE</option>
                                <option value="3">ECE</option>
                                <option value="4">EEE</option>
                                <option value="5">MECH</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Semester</label>
                            <select name="semester" required>
                                <option value="1">1st Semester</option>
                                <option value="2">2nd Semester</option>
                                <option value="3">3rd Semester</option>
                                <option value="4">4th Semester</option>
                                <option value="5">5th Semester</option>
                                <option value="6">6th Semester</option>
                                <option value="7">7th Semester</option>
                                <option value="8">8th Semester</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Default Password</label>
                            <input type="text" name="password" value="student123" required>
                        </div>

                        <button type="submit" class="primary-btn">Register Student</button>

                    </form>
                    <!-- FORM END -->

                </div>

            </div>

        </div>

    </body>

    </html>