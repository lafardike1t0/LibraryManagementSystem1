<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Management - Library System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'primary-blue': '#0a2463',
                        'secondary-blue': '#1e3a8a',
                        'accent-blue': '#3b82f6',
                        'light-blue': '#60a5fa',
                        'dark-blue': '#1e293b',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-blue-50 min-h-screen">
    <%@ include file="navbar.jsp" %>
    <%@ include file="toast.jsp" %>


    <div class="container mx-auto px-4 md:px-8 pb-16 mt-4 md:mt-8">
        <% if (request.getAttribute("success") != null) { %>
            <div class="bg-green-50 border-l-4 border-green-500 text-green-700 p-3 md:p-4 rounded-lg mb-6 flex items-center justify-between text-sm md:text-base">
                <div class="flex items-center">
                    <i class="fas fa-check-circle mr-2 md:mr-3 text-lg md:text-xl"></i>
                    <span><%= request.getAttribute("success") %></span>
                </div>
                <button onclick="this.parentElement.remove()" class="text-green-700 hover:text-green-900">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="bg-red-50 border-l-4 border-red-500 text-red-700 p-3 md:p-4 rounded-lg mb-6 flex items-center justify-between text-sm md:text-base">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle mr-2 md:mr-3 text-lg md:text-xl"></i>
                    <span><%= request.getAttribute("error") %></span>
                </div>
                <button onclick="this.parentElement.remove()" class="text-red-700 hover:text-red-900">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        <% } %>

        <!-- Add New Admin Section -->
        <div class="bg-white rounded-2xl p-4 md:p-8 shadow-xl border border-gray-100 mb-6 md:mb-10">
            <h2 class="text-xl md:text-2xl font-bold text-gray-900 mb-4 md:mb-6">
                <i class="fas fa-user-plus mr-2 text-[#3b82f6]"></i>Add New Administrator
            </h2>
            <form method="post" action="adminManagement" id="adminForm">
                <input type="hidden" name="action" value="add">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-6">
                    <div class="relative">
                        <label class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                            <i class="fas fa-user mr-2 text-[#3b82f6]"></i>Full Name
                        </label>
                        <input type="text" id="adminFullName" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                               name="fullName" placeholder="Enter full name" required pattern="[A-Za-z\s]+" title="Name should only contain letters and spaces">
                    </div>
                    <div class="relative">
                        <label class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                            <i class="fas fa-envelope mr-2 text-[#3b82f6]"></i>Email Address
                        </label>
                        <input type="email" id="adminEmail" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                               name="email" placeholder="Enter email address" required pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Please enter a valid email address">
                    </div>
                    <div class="relative">
                        <label class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                            <i class="fas fa-at mr-2 text-[#3b82f6]"></i>Username
                        </label>
                        <input type="text" id="adminUsername" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                               name="username" placeholder="Enter username" required pattern="[a-zA-Z0-9_]+" minlength="3" title="Username should contain letters, numbers, and underscores only">
                    </div>
                    <div class="relative">
                        <label class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                            <i class="fas fa-lock mr-2 text-[#3b82f6]"></i>Password
                        </label>
                        <input type="password" id="adminPassword" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                               name="password" placeholder="Enter password" required minlength="6" title="Password must be at least 6 characters">
                    </div>
                    <div class="relative md:col-span-2">
                        <label class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                            <i class="fas fa-building mr-2 text-[#3b82f6]"></i>Department
                        </label>
                        <input type="text" id="adminDepartment" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                               name="department" placeholder="Enter department" required>
                    </div>
                    <div class="md:col-span-2">
                        <button type="submit" class="w-full sm:w-auto px-6 py-2.5 bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white rounded-lg font-semibold hover:shadow-lg transition-all text-sm md:text-base">
                            <i class="fas fa-plus-circle mr-2"></i>Add Administrator
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Current Admins Section -->
        <div class="mb-4 md:mb-6">
            <h2 class="text-xl md:text-2xl font-bold text-gray-900">
                <i class="fas fa-users mr-2 text-[#3b82f6]"></i>Current Administrators
            </h2>
        </div>

        <c:choose>
            <c:when test="${not empty admins}">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-6">
                    <c:forEach var="admin" items="${admins}">
                        <div class="bg-white rounded-2xl p-4 md:p-6 shadow-xl border-2 border-transparent hover:border-[#3b82f6] hover:-translate-y-1 hover:shadow-2xl transition-all duration-300 h-full">
                            <div class="w-16 h-16 md:w-20 md:h-20 mx-auto mb-3 md:mb-4 bg-gray-600 rounded-full flex items-center justify-center shadow-lg">
                                <span class="text-2xl md:text-3xl font-bold text-white">
                                    ${admin.fullName.substring(0, 1).toUpperCase()}
                                </span>
                            </div>
                            <div class="text-center">
                                <h5 class="text-lg md:text-xl font-bold text-gray-900 mb-2 truncate px-2">${admin.fullName}</h5>
                                <p class="text-gray-600 mb-2 text-sm md:text-base truncate px-2">
                                    <i class="fas fa-at mr-2"></i>${admin.username}
                                </p>
                                <p class="text-gray-600 mb-2 text-sm md:text-base truncate px-2">
                                    <i class="fas fa-envelope mr-2"></i>${admin.email}
                                </p>
                                <c:if test="${not empty admin.department}">
                                    <p class="text-gray-600 mb-3 md:mb-4 text-sm md:text-base truncate px-2">
                                        <i class="fas fa-building mr-2"></i>${admin.department}
                                    </p>
                                </c:if>
                                
                                <form method="post" action="adminManagement" 
                                      onsubmit="return confirm('Are you sure you want to remove this administrator?');"
                                      class="mt-3 md:mt-4">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="userId" value="${admin.userId}">
                                    <button type="submit" class="w-full sm:w-auto px-4 py-2 bg-gradient-to-r from-red-500 to-red-600 text-white rounded-lg font-semibold hover:shadow-lg transition-all text-sm md:text-base">
                                        <i class="fas fa-trash-alt mr-2"></i><span class="hidden sm:inline">Remove Admin</span><span class="sm:hidden">Remove</span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-white rounded-2xl p-12 shadow-xl border border-gray-100 text-center">
                    <i class="fas fa-users-slash text-6xl text-gray-300 mb-4"></i>
                    <p class="text-gray-500 text-lg">No administrators found.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Admin form validation
        const adminForm = document.getElementById('adminForm');
        if (adminForm) {
            adminForm.addEventListener('submit', function(e) {
                const fullName = document.getElementById('adminFullName').value.trim();
                const email = document.getElementById('adminEmail').value.trim();
                const username = document.getElementById('adminUsername').value.trim();
                const password = document.getElementById('adminPassword').value;

                // Validate full name (only letters and spaces)
                if (!/^[A-Za-z\s]+$/.test(fullName)) {
                    e.preventDefault();
                    alert('Full name should only contain letters and spaces!');
                    return false;
                }

                // Validate email contains @
                if (!email.includes('@') || !/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
                    e.preventDefault();
                    alert('Please enter a valid email address with @ symbol!');
                    return false;
                }

                // Validate username
                if (!/^[a-zA-Z0-9_]+$/.test(username) || username.length < 3) {
                    e.preventDefault();
                    alert('Username should be at least 3 characters and contain only letters, numbers, and underscores!');
                    return false;
                }

                // Validate password length
                if (password.length < 6) {
                    e.preventDefault();
                    alert('Password must be at least 6 characters long!');
                    return false;
                }
            });

            // Real-time validation
            document.getElementById('adminFullName').addEventListener('input', function(e) {
                if (e.target.value && !/^[A-Za-z\s]*$/.test(e.target.value)) {
                    e.target.setCustomValidity('Only letters and spaces are allowed');
                } else {
                    e.target.setCustomValidity('');
                }
            });

            document.getElementById('adminPassword').addEventListener('input', function(e) {
                if (e.target.value.length > 0 && e.target.value.length < 6) {
                    e.target.setCustomValidity('Password must be at least 6 characters');
                } else {
                    e.target.setCustomValidity('');
                }
            });
        }
    </script>
</body>
</html>

