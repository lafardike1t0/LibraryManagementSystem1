<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${book != null ? 'Edit Book' : 'Add New Book'} - Library Management</title>
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
    
    <div class="container mx-auto px-4 py-8 mt-4 md:mt-8">
        <div class="max-w-4xl mx-auto">
            <div class="bg-white rounded-2xl shadow-xl border border-gray-100 overflow-hidden">
                <div class="bg-gray-600 px-4 md:px-8 py-4 md:py-6">
                    <h4 class="text-xl md:text-2xl font-bold text-white">
                        <i class="fas ${book != null ? 'fa-edit' : 'fa-plus-circle'} mr-2 md:mr-3"></i>
                        ${book != null ? 'Edit Book' : 'Add New Book'}
                    </h4>
                </div>
                <div class="p-4 md:p-8">
                    <form action="${pageContext.request.contextPath}/admin/books" method="post">
                        <input type="hidden" name="action" value="${book != null ? 'update' : 'create'}">
                        <c:if test="${book != null}">
                            <input type="hidden" name="bookId" value="${book.bookId}">
                        </c:if>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-6">
                            <div>
                                <label for="isbn" class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                                    <i class="fas fa-barcode mr-2 text-[#3b82f6]"></i>ISBN *
                                </label>
                                <input type="text" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                                       id="isbn" name="isbn" value="${book != null ? book.isbn : ''}" 
                                       placeholder="Enter ISBN" required>
                            </div>
                            
                            <div>
                                <label for="title" class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                                    <i class="fas fa-book mr-2 text-[#3b82f6]"></i>Title *
                                </label>
                                <input type="text" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                                       id="title" name="title" value="${book != null ? book.title : ''}" 
                                       placeholder="Enter book title" required>
                            </div>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-6 mt-4 md:mt-6">
                            <div>
                                <label for="author" class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                                    <i class="fas fa-user-edit mr-2 text-[#3b82f6]"></i>Author *
                                </label>
                                <input type="text" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                                       id="author" name="author" value="${book != null ? book.author : ''}" 
                                       placeholder="Enter author name" required>
                            </div>
                            
                            <div>
                                <label for="category" class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                                    <i class="fas fa-tag mr-2 text-[#3b82f6]"></i>Category *
                                </label>
                                <select class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors bg-white text-sm md:text-base" 
                                        id="category" name="category" required>
                                    <option value="">Select Category</option>
                                    <option value="Fiction" ${book != null && book.category == 'Fiction' ? 'selected' : ''}>Fiction</option>
                                    <option value="Non-Fiction" ${book != null && book.category == 'Non-Fiction' ? 'selected' : ''}>Non-Fiction</option>
                                    <option value="Science" ${book != null && book.category == 'Science' ? 'selected' : ''}>Science</option>
                                    <option value="Technology" ${book != null && book.category == 'Technology' ? 'selected' : ''}>Technology</option>
                                    <option value="History" ${book != null && book.category == 'History' ? 'selected' : ''}>History</option>
                                    <option value="Biography" ${book != null && book.category == 'Biography' ? 'selected' : ''}>Biography</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="mt-4 md:mt-6">
                            <label for="coverImage" class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                                <i class="fas fa-image mr-2 text-[#3b82f6]"></i>Cover Image URL
                            </label>
                            <input type="url" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                                   id="coverImage" name="coverImage" value="${book != null ? book.coverImage : ''}"
                                   placeholder="Enter image URL (e.g., from Unsplash/Google)">
                            <small class="text-gray-500 text-xs md:text-sm mt-1 block">Optional: Provide a URL to a book cover image</small>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-6 mt-4 md:mt-6">
                            <div>
                                <label for="publisher" class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                                    <i class="fas fa-building mr-2 text-[#3b82f6]"></i>Publisher
                                </label>
                                <input type="text" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                                       id="publisher" name="publisher" value="${book != null ? book.publisher : ''}" 
                                       placeholder="Enter publisher name">
                            </div>
                            
                            <div>
                                <label for="yearPublished" class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                                    <i class="fas fa-calendar mr-2 text-[#3b82f6]"></i>Year Published *
                                </label>
                                <input type="number" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                                       id="yearPublished" name="yearPublished" value="${book != null ? book.yearPublished : ''}" 
                                       min="1900" max="2026" placeholder="Enter year" required>
                            </div>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-6 mt-4 md:mt-6">
                            <div>
                                <label for="quantity" class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                                    <i class="fas fa-boxes mr-2 text-[#3b82f6]"></i>Total Quantity *
                                </label>
                                <input type="number" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                                       id="quantity" name="quantity" value="${book != null ? book.quantity : ''}" 
                                       min="1" placeholder="Enter total quantity" required>
                            </div>
                            
                            <div>
                                <label for="availableQuantity" class="block text-gray-700 font-semibold mb-2 text-sm md:text-base">
                                    <i class="fas fa-check-circle mr-2 text-[#3b82f6]"></i>Available Quantity *
                                </label>
                                <input type="number" class="w-full px-3 md:px-4 py-2 md:py-3 border-2 border-gray-300 rounded-lg focus:border-[#3b82f6] focus:outline-none transition-colors text-sm md:text-base" 
                                       id="availableQuantity" name="availableQuantity" value="${book != null ? book.availableQuantity : ''}" 
                                       min="0" placeholder="Enter available quantity" required>
                            </div>
                        </div>
                        
                        <div class="flex flex-col sm:flex-row gap-3 justify-end mt-6 md:mt-8">
                            <a href="${pageContext.request.contextPath}/adminDashboard" class="px-6 py-2.5 md:py-3 border-2 border-gray-300 text-gray-700 rounded-lg font-semibold hover:bg-gray-50 transition-all text-center text-sm md:text-base">
                                <i class="fas fa-times mr-2"></i>Cancel
                            </a>
                            <button type="submit" class="px-6 py-2.5 md:py-3 bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white rounded-lg font-semibold hover:shadow-xl hover:scale-105 transition-all text-sm md:text-base">
                                <i class="fas fa-check mr-2"></i>
                                ${book != null ? 'Update Book' : 'Add Book'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Book form validation
        const bookForm = document.querySelector('form');
        if (bookForm) {
            bookForm.addEventListener('submit', function(e) {
                const title = document.getElementById('title')?.value.trim();
                const author = document.getElementById('author')?.value.trim();
                const isbn = document.getElementById('isbn')?.value.trim();
                const quantity = parseInt(document.getElementById('quantity')?.value);
                const availableQuantity = parseInt(document.getElementById('availableQuantity')?.value);

                // Validate author name (only letters and spaces)
                if (author && !/^[A-Za-z\s.'-]+$/.test(author)) {
                    e.preventDefault();
                    alert('Author name should only contain letters, spaces, dots, hyphens, and apostrophes!');
                    return false;
                }

                // Validate ISBN format (basic validation)
                if (isbn && isbn.length < 10) {
                    e.preventDefault();
                    alert('ISBN should be at least 10 characters!');
                    return false;
                }

                // Validate quantities
                if (availableQuantity > quantity) {
                    e.preventDefault();
                    alert('Available quantity cannot be greater than total quantity!');
                    return false;
                }

                if (quantity < 1) {
                    e.preventDefault();
                    alert('Total quantity must be at least 1!');
                    return false;
                }
            });

            // Real-time validation for author
            const authorInput = document.getElementById('author');
            if (authorInput) {
                authorInput.addEventListener('input', function(e) {
                    if (e.target.value && !/^[A-Za-z\s.'-]*$/.test(e.target.value)) {
                        e.target.setCustomValidity('Author name should only contain letters and spaces');
                    } else {
                        e.target.setCustomValidity('');
                    }
                });
            }
        }
    </script>
</body>
</html>
