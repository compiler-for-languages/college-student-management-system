<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Manage Assignments | Admin</title>

        <style>
            /* ---------- GLOBAL RESET ---------- */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Open Sans', 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            }

            body,
            html {
                height: 100%;
                background-color: #f8f9fa;
                /* Light Grey BG */
            }

            /* ---------- TOP BRAND BAR ---------- */
            .brand-bar {
                padding: 15px 40px;
                background: #ffffff;
                border-bottom: 2px solid #005b9f;
                /* Narayana Blue */
                font-size: 20px;
                font-weight: 700;
                color: #005b9f;
                display: flex;
                align-items: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            }

            .brand-name {
                display: flex;
                align-items: center;
            }

            .brand-name::before {
                content: "";
                display: inline-block;
                width: 40px;
                height: 40px;
                margin-right: 12px;
                background-image: url('SKG.png');
                background-size: cover;
                background-position: center;
                border-radius: 50%;
                border: 2px solid #e0e0e0;
            }

            /* Dashboard Wrapper */
            .dashboard-wrapper {
                display: flex;
                justify-content: center;
                align-items: flex-start;
                padding-top: 40px;
            }

            /* Dashboard Card */
            .dashboard-card {
                width: 60%;
                max-width: 600px;
                background: white;
                padding: 30px;
                border-radius: 6px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
                border: 1px solid #eee;
            }

            .dashboard-title {
                font-size: 26px;
                font-weight: 700;
                margin-bottom: 5px;
                color: #005b9f;
                /* Blue */
            }

            .dashboard-subtitle {
                margin-bottom: 25px;
                font-size: 15px;
                color: #666;
            }

            /* ====== FIXED MENU TILES ====== */
            .menu-grid {
                display: flex;
                flex-direction: column;
                gap: 15px;
                width: 100%;
            }

            .menu-item {
                display: block;
                padding: 20px;
                border-radius: 6px;
                text-decoration: none;
                background: #ffffff;
                border: 1px solid #e0e0e0;
                border-left: 4px solid transparent;
                color: #212121;
                font-size: 18px;
                font-weight: 600;
                transition: 0.2s ease;
            }

            .menu-item:hover {
                background: #fcfcfc;
                border-color: #005b9f;
                border-left-color: #005b9f;
                color: #005b9f;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                cursor: pointer;
            }
        </style>
    </head>

    <body>
        <div class="bg">

            <div class="brand-bar">
                <div class="brand-name">SKG's Student Management System — Manage Assignments</div>
            </div>

            <div class="dashboard-wrapper">
                <div class="dashboard-card">

                    <h2 class="dashboard-title">Manage Course Assignments</h2>
                    <p class="dashboard-subtitle">Choose an option below</p>

                    <div class="menu-grid">
                        <a href="assignTeacherCourse.jsp" class="menu-item">
                            Assign Course to Teacher
                        </a>

                        <a href="assignStudentCourse.jsp" class="menu-item">
                            Assign Course to Student
                        </a>
                    </div>

                </div>
            </div>

        </div>
    </body>

    </html>