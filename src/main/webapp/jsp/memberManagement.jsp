<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Member Management - Library System</title>
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
        <!-- Members List -->
        <div class="bg-white rounded-2xl p-4 md:p-8 shadow-xl border border-gray-100">
            <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-3 md:gap-4 mb-4 md:mb-6">
                <h2 class="text-xl md:text-2xl font-bold text-gray-900">
                    <i class="fas fa-user-friends mr-2 text-[#3b82f6]"></i>All Members
                </h2>
                <div class="flex items-center gap-2 bg-gray-100 px-3 md:px-4 py-2 rounded-lg">
                    <i class="fas fa-users text-[#3b82f6]"></i>
                    <span class="font-semibold text-gray-700 text-sm md:text-base">Total: ${members.size()}</span>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty members}">
                    <div class="overflow-x-auto -mx-4 md:mx-0">
                        <table class="w-full min-w-[640px]">
                            <thead>
                                <tr class="bg-gray-100 text-gray-700">
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-left text-xs md:text-sm font-semibold rounded-tl-xl">Member</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-left text-xs md:text-sm font-semibold hidden lg:table-cell">Membership ID</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-left text-xs md:text-sm font-semibold hidden md:table-cell">Username</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-left text-xs md:text-sm font-semibold hidden lg:table-cell">Email</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-center text-xs md:text-sm font-semibold">Books</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-center text-xs md:text-sm font-semibold rounded-tr-xl">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach var="member" items="${members}">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-3 md:px-6 py-3 md:py-4">
                                            <div class="flex items-center gap-2 md:gap-3">
                                                <div class="w-10 h-10 md:w-12 md:h-12 bg-gradient-to-br from-[#0a2463] to-[#3b82f6] rounded-full flex items-center justify-center flex-shrink-0">
                                                    <span class="text-white font-bold text-base md:text-lg">
                                                        ${member.fullName.substring(0, 1).toUpperCase()}
                                                    </span>
                                                </div>
                                                <div class="min-w-0">
                                                    <p class="font-semibold text-gray-900 text-sm md:text-base truncate">${member.fullName}</p>
                                                    <p class="text-xs text-gray-500 lg:hidden">${member.membershipId}</p>
                                                    <p class="text-xs text-gray-500 md:hidden">@${member.username}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 hidden lg:table-cell">
                                            <span class="px-2 md:px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-semibold">
                                                <i class="fas fa-id-badge mr-1"></i>${member.membershipId}
                                            </span>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 hidden md:table-cell">
                                            <div class="flex items-center gap-2">
                                                <i class="fas fa-user text-gray-400"></i>
                                                <span class="text-gray-700 text-xs md:text-sm">${member.username}</span>
                                            </div>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 hidden lg:table-cell">
                                            <div class="flex items-center gap-2">
                                                <i class="fas fa-envelope text-gray-400"></i>
                                                <span class="text-gray-700 text-xs md:text-sm truncate max-w-[150px]">${member.email}</span>
                                            </div>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 text-center">
                                            <c:set var="borrowKey" value="borrowCount_${member.userId}" />
                                            <c:set var="borrowCount" value="${requestScope[borrowKey]}" />
                                            <c:choose>
                                                <c:when test="${borrowCount > 0}">
                                                    <span class="px-2 md:px-4 py-1 md:py-2 bg-green-100 text-green-700 rounded-full text-xs md:text-sm font-semibold">
                                                        <i class="fas fa-book-reader mr-1"></i>${borrowCount}/5
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2 md:px-4 py-1 md:py-2 bg-gray-100 text-gray-600 rounded-full text-xs md:text-sm font-semibold">
                                                        <i class="fas fa-book mr-1"></i>0/5
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 text-center">
                                            <button onclick="confirmDeleteMember(${member.userId}, '${member.fullName}', ${borrowCount})" class="px-2 md:px-3 py-1 bg-red-500 text-white rounded-lg text-xs font-semibold hover:bg-red-600 transition-all">
                                                <i class="fas fa-trash"></i><span class="hidden sm:inline ml-1">Delete</span>
                                            </button>
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
                            <i class="fas fa-users text-[#3b82f6] text-3xl"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-2">No Members Found</h3>
                        <p class="text-gray-600">There are no registered members in the system yet</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        function confirmDeleteMember(userId, fullName, borrowCount) {
            if (borrowCount > 0) {
                alert("Cannot delete member '" + fullName + "' because they have " + borrowCount + " active borrowed book(s). Please ensure they return all books first.");
                return;
            }
            
            if (confirm("Are you sure you want to delete member '" + fullName + "'? This action cannot be undone.")) {
                window.location.href = '/admin/members?action=delete&id=' + userId;
            }
        }
    </script>
</body>
</html>
