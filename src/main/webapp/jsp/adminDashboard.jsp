<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page import="com.library.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Library Management System</title>
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
        <!-- Statistics Cards -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-4 md:gap-6 mb-6 md:mb-10">
            <div class="bg-white rounded-2xl p-4 md:p-6 shadow-xl border border-gray-100 hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="text-gray-600 text-xs md:text-sm font-semibold mb-1 md:mb-2">Total Books</div>
                        <div class="text-2xl md:text-4xl font-bold text-gray-900">${totalBooks != null ? totalBooks : 0}</div>
                    </div>
                    <div class="w-12 h-12 md:w-14 md:h-14 bg-blue-100 rounded-xl flex items-center justify-center shadow-lg">
                        <i class="fas fa-book text-[#3b82f6] text-lg md:text-xl"></i>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-2xl p-4 md:p-6 shadow-xl border border-gray-100 hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="text-gray-600 text-xs md:text-sm font-semibold mb-1 md:mb-2">Available Books</div>
                        <div class="text-2xl md:text-4xl font-bold text-gray-900">${availableBooks != null ? availableBooks : 0}</div>
                    </div>
                    <div class="w-12 h-12 md:w-14 md:h-14 bg-blue-100 rounded-xl flex items-center justify-center shadow-lg">
                        <i class="fas fa-check-circle text-[#3b82f6] text-lg md:text-xl"></i>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-2xl p-4 md:p-6 shadow-xl border border-gray-100 hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="text-gray-600 text-xs md:text-sm font-semibold mb-1 md:mb-2">Out of Stock</div>
                        <div class="text-2xl md:text-4xl font-bold text-gray-900">${outOfStockBooks != null ? outOfStockBooks : 0}</div>
                    </div>
                    <div class="w-12 h-12 md:w-14 md:h-14 bg-blue-100 rounded-xl flex items-center justify-center shadow-lg">
                        <i class="fas fa-times-circle text-[#3b82f6] text-lg md:text-xl"></i>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-2xl p-4 md:p-6 shadow-xl border border-gray-100 hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="text-gray-600 text-xs md:text-sm font-semibold mb-1 md:mb-2">Borrowed Books</div>
                        <div class="text-2xl md:text-4xl font-bold text-gray-900">${borrowedBooks != null ? borrowedBooks : 0}</div>
                    </div>
                    <div class="w-12 h-12 md:w-14 md:h-14 bg-blue-100 rounded-xl flex items-center justify-center shadow-lg">
                        <i class="fas fa-hand-holding text-[#3b82f6] text-lg md:text-xl"></i>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-2xl p-4 md:p-6 shadow-xl border border-gray-100 hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="text-gray-600 text-xs md:text-sm font-semibold mb-1 md:mb-2">Active Members</div>
                        <div class="text-2xl md:text-4xl font-bold text-gray-900">${activeMembersCount != null ? activeMembersCount : 0}</div>
                    </div>
                    <div class="w-12 h-12 md:w-14 md:h-14 bg-blue-100 rounded-xl flex items-center justify-center shadow-lg">
                        <i class="fas fa-users text-[#3b82f6] text-lg md:text-xl"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Books List Section -->
        <div class="bg-white rounded-2xl p-4 md:p-8 shadow-xl border border-gray-100 mb-6 md:mb-8">
            <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-3 md:gap-4 mb-4 md:mb-6">
                <h2 class="text-xl md:text-2xl font-bold text-gray-900">
                    <i class="fas fa-book mr-2 text-[#3b82f6]"></i>All Books in Library
                </h2>
                <a href="${pageContext.request.contextPath}/admin/books" class="w-full sm:w-auto text-center bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white px-4 md:px-6 py-2 rounded-lg text-sm md:text-base font-semibold hover:shadow-xl hover:scale-105 transition-all">
                    <i class="fas fa-plus mr-2"></i>Add New Book
                </a>
            </div>

            <c:choose>
                <c:when test="${not empty allBooks}">
                    <div class="overflow-x-auto -mx-4 md:mx-0">
                        <table class="w-full min-w-[640px]">
                            <thead>
                                <tr class="bg-gray-200 text-gray-800">
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-left text-xs md:text-sm font-semibold rounded-tl-xl">Title</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-left text-xs md:text-sm font-semibold hidden lg:table-cell">Author</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-left text-xs md:text-sm font-semibold hidden md:table-cell">Category</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-center text-xs md:text-sm font-semibold">Total Qty</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-center text-xs md:text-sm font-semibold">Available</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-center text-xs md:text-sm font-semibold hidden sm:table-cell">Status</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-center text-xs md:text-sm font-semibold rounded-tr-xl">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach var="book" items="${allBooks}">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-3 md:px-6 py-3 md:py-4">
                                            <div class="flex items-center gap-2 md:gap-3">
                                                <div class="w-8 h-12 md:w-10 md:h-14 bg-gray-600 rounded flex items-center justify-center flex-shrink-0">
                                                    <i class="fas fa-book-open text-white text-xs md:text-base"></i>
                                                </div>
                                                <div class="min-w-0">
                                                    <p class="font-semibold text-gray-900 text-xs md:text-sm truncate">${book.title}</p>
                                                    <p class="text-xs text-gray-500 truncate lg:hidden">${book.author}</p>
                                                    <p class="text-xs text-gray-500 hidden sm:block lg:hidden">ISBN: ${book.isbn}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 text-gray-700 text-xs md:text-sm hidden lg:table-cell">${book.author}</td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 hidden md:table-cell">
                                            <span class="px-2 md:px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-semibold">
                                                ${book.category}
                                            </span>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 text-center font-semibold text-gray-900 text-xs md:text-sm">${book.quantity}</td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 text-center font-semibold text-gray-900 text-xs md:text-sm">${book.availableQuantity}</td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 text-center hidden sm:table-cell">
                                            <c:choose>
                                                <c:when test="${book.availableQuantity > 0}">
                                                    <span class="px-2 md:px-3 py-1 bg-green-100 text-green-700 rounded-full text-xs font-semibold">
                                                        <i class="fas fa-check-circle mr-1"></i><span class="hidden md:inline">Available</span>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2 md:px-3 py-1 bg-red-100 text-red-700 rounded-full text-xs font-semibold">
                                                        <i class="fas fa-times-circle mr-1"></i><span class="hidden md:inline">Out</span>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 text-center">
                                            <div class="flex items-center justify-center gap-1 md:gap-2 flex-wrap">
                                                <a href="${pageContext.request.contextPath}/admin/books?action=edit&id=${book.bookId}" class="px-2 md:px-3 py-1 bg-blue-500 text-white rounded-lg text-xs font-semibold hover:bg-blue-600 transition-all">
                                                    <i class="fas fa-edit"></i><span class="hidden sm:inline ml-1">Edit</span>
                                                </a>
                                                <button onclick="confirmDelete(${book.bookId}, '${fn:escapeXml(book.title)}')" class="px-2 md:px-3 py-1 bg-red-500 text-white rounded-lg text-xs font-semibold hover:bg-red-600 transition-all">
                                                    <i class="fas fa-trash"></i><span class="hidden sm:inline ml-1">Delete</span>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-12">
                        <i class="fas fa-inbox text-6xl text-gray-300 mb-4"></i>
                        <p class="text-gray-500 text-lg mb-4">No books in the library yet.</p>
                        <a href="${pageContext.request.contextPath}/admin/books" class="inline-flex items-center gap-2 bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white px-6 py-3 rounded-lg font-semibold hover:shadow-xl hover:scale-105 transition-all">
                            <i class="fas fa-plus"></i>Add Your First Book
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Borrowed Books Section -->
        <div class="bg-white rounded-2xl p-4 md:p-8 shadow-xl border border-gray-100">
            <div class="flex items-center gap-3 md:gap-4 mb-4 md:mb-6">
                <h2 class="text-xl md:text-2xl font-bold text-gray-900">
                    <i class="fas fa-hand-holding mr-2 text-[#3b82f6]"></i>Currently Borrowed Books
                </h2>
            </div>

            <c:choose>
                <c:when test="${not empty activeBorrowRecords}">
                    <div class="overflow-x-auto -mx-4 md:mx-0">
                        <table class="w-full min-w-[640px]">
                            <thead>
                                <tr class="bg-gray-100 text-gray-700">
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-left text-xs md:text-sm font-semibold rounded-tl-xl">Book Title</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-left text-xs md:text-sm font-semibold hidden lg:table-cell">Borrower</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-left text-xs md:text-sm font-semibold hidden md:table-cell">Membership ID</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-center text-xs md:text-sm font-semibold">Borrowed Date</th>
                                    <th class="px-3 md:px-6 py-3 md:py-4 text-center text-xs md:text-sm font-semibold rounded-tr-xl">Due Date</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach var="record" items="${activeBorrowRecords}">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-3 md:px-6 py-3 md:py-4">
                                            <div class="flex items-center gap-2 md:gap-3">
                                                <div class="w-8 h-12 md:w-10 md:h-14 bg-gray-600 rounded flex items-center justify-center flex-shrink-0">
                                                    <i class="fas fa-book-open text-white text-xs md:text-base"></i>
                                                </div>
                                                <div class="min-w-0">
                                                    <p class="font-semibold text-gray-900 text-xs md:text-sm truncate">${record.bookTitle}</p>
                                                    <p class="text-xs text-gray-500 truncate">by ${record.bookAuthor}</p>
                                                    <p class="text-xs text-gray-500 lg:hidden">${record.borrowerName}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 hidden lg:table-cell">
                                            <div>
                                                <p class="font-semibold text-gray-900 text-xs md:text-sm">${record.borrowerName}</p>
                                                <p class="text-xs text-gray-500">${record.borrowerEmail}</p>
                                            </div>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 hidden md:table-cell">
                                            <span class="px-2 md:px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-semibold">
                                                ${record.membershipId}
                                            </span>
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 text-center text-gray-700 text-xs md:text-sm">
                                            <i class="fas fa-calendar-check text-green-600 mr-1 md:mr-2"></i>
                                            ${record.borrowDate}
                                        </td>
                                        <td class="px-3 md:px-6 py-3 md:py-4 text-center text-gray-700 text-xs md:text-sm">
                                            <i class="fas fa-calendar-times text-orange-600 mr-1 md:mr-2"></i>
                                            ${record.dueDate}
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
                            <i class="fas fa-hand-holding text-[#3b82f6] text-3xl"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-2">No Active Borrows</h3>
                        <p class="text-gray-600">All books are currently available in the library</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Display current date
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        document.getElementById('currentDate').textContent = new Date().toLocaleDateString('en-US', options);
        
        // Confirm book delete
        function confirmDelete(bookId, bookTitle) {
            if (confirm('Are you sure you want to delete "' + bookTitle + '"? This action cannot be undone.')) {
                window.location.href = '${pageContext.request.contextPath}/admin/books?action=delete&id=' + bookId;
            }
        }
    </script>
</body>
</html>
