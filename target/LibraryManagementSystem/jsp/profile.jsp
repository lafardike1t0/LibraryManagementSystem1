<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="com.library.model.User, com.library.model.Member, com.library.model.Admin" %>
<%@ page import="java.time.LocalDate, java.time.temporal.ChronoUnit" %>
<%
    User profileUser = (User) session.getAttribute("user");
    if (profileUser == null) {
        response.sendRedirect("login");
        return;
    }
    boolean isAdmin = "ADMIN".equals(profileUser.getUserType());
    Member member = isAdmin ? null : (Member) profileUser;
    Admin admin = isAdmin ? (Admin) profileUser : null;
    String dashboardUrl = isAdmin ? request.getContextPath() + "/adminDashboard" : request.getContextPath() + "/memberDashboard";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Library System</title>
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

    <!-- Profile Header -->
    <div class="bg-white border-b border-gray-200">
        <div class="container mx-auto px-4 md:px-8 relative">
            <a href="<%= dashboardUrl %>" class="absolute left-4 md:left-8 top-8 w-10 h-10 flex items-center justify-center rounded-full bg-gray-100 hover:bg-[#3b82f6] hover:text-white text-gray-600 transition-all z-10">
                <i class="fas fa-arrow-left text-lg"></i>
            </a>
            <div class="py-8">
                <div class="text-center">
                    <div class="w-20 h-20 mx-auto mb-3 rounded-full bg-gradient-to-br from-[#0a2463] to-[#3b82f6] flex items-center justify-center shadow-lg">
                        <span class="text-3xl font-bold text-white"><%= profileUser.getFullName().substring(0, 1).toUpperCase() %></span>
                    </div>
                    <h1 class="text-2xl md:text-3xl font-bold text-gray-900 mb-1"><%= profileUser.getFullName() %></h1>
                    <div class="inline-flex items-center gap-2 bg-gray-100 px-3 py-1 rounded-full border border-gray-200 text-sm">
                        <i class="fas <%= isAdmin ? "fa-shield-alt" : "fa-id-badge" %> text-[#3b82f6]"></i>
                        <span class="font-semibold text-gray-700"><%= isAdmin ? "System Administrator" : member.getMembershipId() %></span>
                    </div>
                </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container mx-auto px-4 md:px-8 py-8">
        <!-- Personal Information Card -->
        <div class="bg-white rounded-2xl shadow-xl p-8 mb-8 border border-gray-100">
            <div class="flex items-center justify-between mb-6">
                <div class="flex items-center gap-4">
                    <div class="h-1 w-12 bg-gradient-to-r from-[#0a2463] to-[#3b82f6] rounded-full"></div>
                    <h2 class="text-2xl font-bold text-gray-900">Personal Information</h2>
                </div>
                <button onclick="toggleEditMode()" id="editBtn" class="flex items-center gap-2 px-4 py-2 bg-primary-blue text-white rounded-lg font-semibold hover:shadow-lg transition-all">
                    <i class="fas fa-edit"></i>
                    <span>Edit Profile</span>
                </button>
            </div>

            <!-- View Mode -->
            <div id="viewMode" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="group">
                    <div class="flex items-center gap-4 p-4 rounded-xl hover:bg-blue-50 transition-all">
                        <div class="w-12 h-12 bg-primary-blue rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform">
                            <i class="fas fa-user text-white text-lg"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">Full Name</p>
                            <p class="font-semibold text-gray-900 text-lg"><%= profileUser.getFullName() %></p>
                        </div>
                    </div>
                </div>
                <div class="group">
                    <div class="flex items-center gap-4 p-4 rounded-xl hover:bg-blue-50 transition-all">
                        <div class="w-12 h-12 bg-primary-blue rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform">
                            <i class="fas fa-envelope text-white text-lg"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">Email Address</p>
                            <p class="font-semibold text-gray-900 text-lg"><%= profileUser.getEmail() %></p>
                        </div>
                    </div>
                </div>
                <% if (!isAdmin) { %>
                <div class="group">
                    <div class="flex items-center gap-4 p-4 rounded-xl hover:bg-blue-50 transition-all">
                        <div class="w-12 h-12 bg-primary-blue rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform">
                            <i class="fas fa-id-card text-white text-lg"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">Membership ID</p>
                            <p class="font-semibold text-gray-900 text-lg"><%= member.getMembershipId() %></p>
                        </div>
                    </div>
                </div>
                <div class="group">
                    <div class="flex items-center gap-4 p-4 rounded-xl hover:bg-blue-50 transition-all">
                        <div class="w-12 h-12 bg-primary-blue rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform">
                            <i class="fas fa-book-reader text-white text-lg"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">Books Borrowed</p>
                            <p class="font-semibold text-gray-900 text-lg">${borrowedBooks.size()} / 5</p>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div class="group">
                    <div class="flex items-center gap-4 p-4 rounded-xl hover:bg-blue-50 transition-all">
                        <div class="w-12 h-12 bg-primary-blue rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform">
                            <i class="fas fa-building text-white text-lg"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">Department</p>
                            <p class="font-semibold text-gray-900 text-lg"><%= admin.getDepartment() != null ? admin.getDepartment() : "N/A" %></p>
                        </div>
                    </div>
                </div>
                <div class="group">
                    <div class="flex items-center gap-4 p-4 rounded-xl hover:bg-blue-50 transition-all">
                        <div class="w-12 h-12 bg-primary-blue rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform">
                            <i class="fas fa-shield-alt text-white text-lg"></i>
                        </div>
                        <div>
                            <p class="text-gray-500 text-sm">Role</p>
                            <p class="font-semibold text-gray-900 text-lg">System Administrator</p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Edit Mode -->
            <div id="editMode" class="hidden">
                <form action="${pageContext.request.contextPath}/profile" method="post" class="space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-gray-700 font-semibold mb-2">
                                <i class="fas fa-user text-[#3b82f6] mr-2"></i>Full Name
                            </label>
                            <input type="text" name="fullName" value="<%= profileUser.getFullName() %>" required class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors">
                        </div>
                        <div>
                            <label class="block text-gray-700 font-semibold mb-2">
                                <i class="fas fa-envelope text-[#3b82f6] mr-2"></i>Email Address
                            </label>
                            <input type="email" name="email" value="<%= profileUser.getEmail() %>" required class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors">
                        </div>
                    </div>

                    <div class="border-t border-gray-200 pt-6 mt-6">
                        <h3 class="text-lg font-bold text-gray-900 mb-4">Change Password (Optional)</h3>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div>
                                <label class="block text-gray-700 font-semibold mb-2">Current Password</label>
                                <input type="password" name="currentPassword" class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors">
                            </div>
                            <div>
                                <label class="block text-gray-700 font-semibold mb-2">New Password</label>
                                <input type="password" name="newPassword" class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors">
                            </div>
                            <div>
                                <label class="block text-gray-700 font-semibold mb-2">Confirm Password</label>
                                <input type="password" name="confirmPassword" class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors">
                            </div>
                        </div>
                    </div>

                    <div class="flex gap-3 pt-4">
                        <button type="button" onclick="toggleEditMode()" class="flex-1 px-6 py-3 border-2 border-gray-300 text-gray-700 rounded-lg font-semibold hover:bg-gray-50 transition-all">
                            Cancel
                        </button>
                        <button type="submit" class="flex-1 px-6 py-3 bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white rounded-lg font-semibold hover:shadow-xl hover:scale-105 transition-all">
                            <i class="fas fa-save mr-2"></i>Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <% if (!isAdmin) { %>
        <!-- Currently Borrowed Books Section -->
        <div class="bg-white rounded-2xl shadow-xl p-8 mb-8 border border-gray-100">
            <div class="flex items-center gap-4 mb-6">
                <div class="h-1 w-12 bg-gradient-to-r from-[#0a2463] to-[#3b82f6] rounded-full"></div>
                <h2 class="text-2xl font-bold text-gray-900">Currently Borrowed Books</h2>
            </div>

            <c:choose>
                <c:when test="${not empty borrowedBooks}">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white">
                                    <th class="px-6 py-4 text-left text-sm font-semibold rounded-tl-xl">Book Title</th>
                                    <th class="px-6 py-4 text-left text-sm font-semibold">Borrow Date</th>
                                    <th class="px-6 py-4 text-left text-sm font-semibold">Due Date</th>
                                    <th class="px-6 py-4 text-left text-sm font-semibold">Days Left</th>
                                    <th class="px-6 py-4 text-left text-sm font-semibold">Status</th>
                                    <th class="px-6 py-4 text-center text-sm font-semibold rounded-tr-xl">Action</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach var="record" items="${borrowedBooks}">
                                    <%
                                        com.library.model.BorrowRecord record = (com.library.model.BorrowRecord) pageContext.getAttribute("record");
                                        LocalDate dueDate = record.getDueDate();
                                        LocalDate today = LocalDate.now();
                                        long daysLeft = ChronoUnit.DAYS.between(today, dueDate);
                                        String statusClass = "";
                                        String statusText = "";
                                        String statusBadge = "";
                                        
                                        if (daysLeft < 0) {
                                            statusClass = "bg-red-50 border-l-4 border-red-500";
                                            statusText = "Overdue";
                                            statusBadge = "bg-red-500";
                                        } else if (daysLeft <= 2) {
                                            statusClass = "bg-yellow-50 border-l-4 border-yellow-500";
                                            statusText = "Due Soon";
                                            statusBadge = "bg-yellow-500";
                                        } else {
                                            statusClass = "bg-white";
                                            statusText = "On Time";
                                            statusBadge = "bg-green-500";
                                        }
                                        pageContext.setAttribute("statusClass", statusClass);
                                        pageContext.setAttribute("daysLeft", daysLeft);
                                        pageContext.setAttribute("statusText", statusText);
                                        pageContext.setAttribute("statusBadge", statusBadge);
                                    %>
                                    <tr class="hover:bg-gray-50 transition-colors ${statusClass}">
                                        <td class="px-6 py-4">
                                            <div class="flex items-center gap-3">
                                                <div class="w-10 h-14 bg-gradient-to-br from-[#0a2463] to-[#3b82f6] rounded flex items-center justify-center flex-shrink-0">
                                                    <i class="fas fa-book-open text-white"></i>
                                                </div>
                                                <div>
                                                    <p class="font-semibold text-gray-900">${record.bookTitle}</p>
                                                    <p class="text-xs text-gray-500">ID: ${record.bookId}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="text-sm">
                                                <i class="fas fa-calendar-check text-green-600 mr-2"></i>
                                                <span class="font-medium text-gray-700">${record.borrowDate}</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="text-sm">
                                                <i class="fas fa-calendar-times text-orange-600 mr-2"></i>
                                                <span class="font-medium text-gray-700">${record.dueDate}</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${daysLeft < 0}">
                                                    <span class="font-bold text-red-600">${Math.abs(daysLeft)} days overdue</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="font-semibold text-gray-700">${daysLeft} days</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="${statusBadge} text-white px-3 py-1 rounded-full text-xs font-semibold">
                                                ${statusText}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 text-center">
                                            <form action="${pageContext.request.contextPath}/member/return" method="post" class="inline" onsubmit="return confirmReturn()">
                                                <input type="hidden" name="recordId" value="${record.recordId}">
                                                <button type="submit" class="bg-gradient-to-r from-green-500 to-green-600 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:shadow-xl hover:scale-105 transition-all">
                                                    <i class="fas fa-undo mr-2"></i>Return
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-12">
                        <div class="w-20 h-20 mx-auto mb-4 bg-gradient-to-br from-blue-100 to-indigo-100 rounded-full flex items-center justify-center">
                            <i class="fas fa-book-open text-[#3b82f6] text-3xl"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-2">No Borrowed Books</h3>
                        <p class="text-gray-600 mb-4">You haven't borrowed any books yet</p>
                        <a href="${pageContext.request.contextPath}/memberDashboard" class="inline-flex items-center gap-2 bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white px-6 py-2 rounded-lg font-semibold hover:shadow-xl hover:scale-105 transition-all">
                            <i class="fas fa-search"></i>
                            <span>Browse Books</span>
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Borrow History Section -->
        <div class="bg-white rounded-2xl shadow-xl p-8 mb-8 border border-gray-100">
            <div class="flex items-center justify-between mb-6">
                <div class="flex items-center gap-4">
                    <div class="h-1 w-12 bg-gradient-to-r from-[#0a2463] to-[#3b82f6] rounded-full"></div>
                    <h2 class="text-2xl font-bold text-gray-900">Borrowing History</h2>
                </div>
                <c:if test="${not empty borrowHistory}">
                    <form method="post" action="${pageContext.request.contextPath}/profile" 
                          onsubmit="return confirm('Are you sure you want to clear your borrowing history? This action cannot be undone. Note: Currently borrowed books will NOT be affected.');">
                        <input type="hidden" name="action" value="clearHistory">
                        <button type="submit" class="px-4 py-2 bg-red-500 hover:bg-red-600 text-white rounded-lg font-semibold transition-all flex items-center gap-2">
                            <i class="fas fa-trash-alt"></i>
                            <span>Clear History</span>
                        </button>
                    </form>
                </c:if>
            </div>

            <c:choose>
                <c:when test="${not empty borrowHistory}">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="bg-gray-100 text-gray-700">
                                    <th class="px-6 py-3 text-left text-sm font-semibold rounded-tl-xl">Book Title</th>
                                    <th class="px-6 py-3 text-left text-sm font-semibold">Borrow Date</th>
                                    <th class="px-6 py-3 text-left text-sm font-semibold">Due Date</th>
                                    <th class="px-6 py-3 text-left text-sm font-semibold">Return Date</th>
                                    <th class="px-6 py-3 text-center text-sm font-semibold rounded-tr-xl">Status</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach var="record" items="${borrowHistory}">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-4">
                                            <div class="flex items-center gap-3">
                                                <div class="w-8 h-12 bg-gradient-to-br from-gray-400 to-gray-500 rounded flex items-center justify-center flex-shrink-0">
                                                    <i class="fas fa-book text-white text-xs"></i>
                                                </div>
                                                <p class="font-medium text-gray-900">${record.bookTitle}</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-sm text-gray-600">${record.borrowDate}</td>
                                        <td class="px-6 py-4 text-sm text-gray-600">${record.dueDate}</td>
                                        <td class="px-6 py-4 text-sm text-gray-600">
                                            <c:choose>
                                                <c:when test="${not empty record.returnDate}">
                                                    ${record.returnDate}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-orange-600 font-semibold">Not Returned</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 text-center">
                                            <c:choose>
                                                <c:when test="${record.status == 'RETURNED'}">
                                                    <span class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-xs font-semibold">Returned</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-xs font-semibold">Borrowed</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-12 text-gray-500">
                        <i class="fas fa-history text-4xl mb-3"></i>
                        <p>No borrowing history yet</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <% } %>
    </div>

    <script>
        function toggleEditMode() {
            const viewMode = document.getElementById('viewMode');
            const editMode = document.getElementById('editMode');
            const editBtn = document.getElementById('editBtn');
            
            if (editMode.classList.contains('hidden')) {
                viewMode.classList.add('hidden');
                editMode.classList.remove('hidden');
                editBtn.classList.add('hidden');
            } else {
                viewMode.classList.remove('hidden');
                editMode.classList.add('hidden');
                editBtn.classList.remove('hidden');
            }
        }

        function confirmReturn() {
            return confirm('Do you want to return this book?');
        }
    </script>
</body>
</html>
