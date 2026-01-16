<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Member Dashboard - Library System</title>
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
                                'purple-start': '#667eea',
                                'purple-end': '#764ba2',
                            }
                        }
                    }
                }
            </script>
        </head>

        <body class="min-h-screen">
            <%@ include file="navbar.jsp" %>
                <%@ include file="toast.jsp" %>

                    <!-- Modern Hero Section -->
                    <div class="relative text-white overflow-hidden">
                        <!-- Background Pattern -->
                        <div class="absolute inset-0">
                            <div class="absolute inset-0"
                                style="background-image: url('https://png.pngtree.com/background/20250125/original/pngtree-stack-of-books-in-a-library-with-sunlight-streaming-through-the-picture-image_15776652.jpg'); background-size: cover; background-position: center;">
                            </div>
                        </div>

                
                        <!-- Content -->
                        <div class="container mx-auto px-4 md:px-8 relative z-10">
                            <div class="py-8 md:py-12 lg:py-14 flex flex-col items-center gap-4 md:gap-6 lg:gap-8">
                                <!-- Your Personal Library Badge -->
                                <div class="inline-flex items-center gap-2 md:gap-3 bg-white/10 backdrop-blur-xl px-4 md:px-6 py-2 md:py-3 rounded-full border border-white/20">
                                    <i class="fas fa-book-reader text-xl md:text-2xl"></i>
                                    <span class="text-xs md:text-sm font-semibold tracking-wide">YOUR PERSONAL LIBRARY</span>
                                </div>

                                <!-- Text Section with Blur Background -->
                                <div class="bg-white/10 backdrop-blur-lg rounded-2xl md:rounded-3xl px-4 md:px-8 py-4 md:py-6">
                                    <h1 class="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-bold mb-3 md:mb-4 leading-tight text-center">
                                        Discover Your Next<br>
                                        <span class="text-white">Great Read</span>
                                    </h1>
                                    <p class="text-base sm:text-lg md:text-xl lg:text-2xl text-white/90 max-w-2xl mx-auto text-center">
                                        Explore thousands of books across all genres
                                    </p>
                                </div>

                                <!-- Quick Actions (4 Words) -->
                                <div class="flex flex-wrap justify-center gap-2 md:gap-4 text-xs md:text-sm">
                                    <button
                                        class="px-3 md:px-4 py-1.5 md:py-2 bg-white/10 backdrop-blur-xl rounded-full hover:bg-white/20 transition-all border border-white/20">Fiction</button>
                                    <button
                                        class="px-3 md:px-4 py-1.5 md:py-2 bg-white/10 backdrop-blur-xl rounded-full hover:bg-white/20 transition-all border border-white/20">Science</button>
                                    <button
                                        class="px-3 md:px-4 py-1.5 md:py-2 bg-white/10 backdrop-blur-xl rounded-full hover:bg-white/20 transition-all border border-white/20">Technology</button>
                                    <button
                                        class="px-3 md:px-4 py-1.5 md:py-2 bg-white/10 backdrop-blur-xl rounded-full hover:bg-white/20 transition-all border border-white/20">Biography</button>
                                </div>

                                <!-- Modern Search Box -->
                                <form action="${pageContext.request.contextPath}/memberDashboard" method="get"
                                    class="max-w-2xl w-full px-2 md:px-0" id="searchForm">
                                    <div class="relative group">
                                        <div
                                            class="absolute inset-0 bg-primary-blue rounded-full blur-xl opacity-50 group-hover:opacity-75 transition-opacity">
                                        </div>
                                        <div class="relative bg-white rounded-full p-1.5 md:p-2">
                                            <div class="flex items-center gap-2">
                                                <div class="flex-1 flex items-center gap-2 md:gap-3 px-3 md:px-5">
                                                    <i class="fas fa-search text-gray-400 text-base md:text-lg"></i>
                                                    <input type="text" name="search" id="searchInput"
                                                        placeholder="Search by title, author, ISBN, or category..."
                                                        value="${searchKeyword}"
                                                        class="flex-1 py-2 md:py-3 text-gray-800 text-sm md:text-base focus:outline-none placeholder-gray-400">
                                                    <c:if test="${not empty searchKeyword}">
                                                        <button type="button" onclick="clearSearch()" class="text-gray-400 hover:text-gray-600 transition-colors px-2">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </c:if>
                                                </div>
                                                <button type="submit"
                                                    class="bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white px-4 md:px-6 py-2 md:py-3 rounded-full font-semibold hover:shadow-xl hover:scale-105 transition-all duration-300 text-xs md:text-sm">
                                                    <span class="hidden sm:inline">Search</span>
                                                    <i class="fas fa-search sm:hidden"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="container mx-auto px-4 md:px-8 pb-16 -mt-6 md:-mt-8 relative z-20">
                        <!-- Quick Stats -->
                        <div class="bg-white rounded-2xl shadow-2xl p-4 md:p-8 mb-8 md:mb-12 border border-gray-100">
                            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 md:gap-6">
                                <div class="relative group">
                                    <div
                                        class="absolute inset-0 bg-primary-blue rounded-xl opacity-0 group-hover:opacity-10 transition-opacity">
                                    </div>
                                    <div class="relative text-center p-4 md:p-6 rounded-xl">
                                        <div
                                            class="w-12 h-12 md:w-16 md:h-16 mx-auto mb-3 md:mb-4 bg-primary-blue rounded-2xl flex items-center justify-center shadow-lg group-hover:scale-110 transition-transform">
                                            <i class="fas fa-book text-white text-xl md:text-2xl"></i>
                                        </div>
                                        <div
                                            class="text-2xl md:text-4xl font-bold bg-primary-blue bg-clip-text text-transparent">
                                            ${not empty books ? books.size() : 0}</div>
                                        <div class="text-gray-600 text-xs md:text-sm font-semibold mt-2">Available Books</div>
                                    </div>
                                </div>
                                <div class="relative group">
                                    <div
                                        class="absolute inset-0 bg-primary-blue rounded-xl opacity-0 group-hover:opacity-10 transition-opacity">
                                    </div>
                                    <div class="relative text-center p-4 md:p-6 rounded-xl">
                                        <div
                                            class="w-12 h-12 md:w-16 md:h-16 mx-auto mb-3 md:mb-4 bg-primary-blue rounded-2xl flex items-center justify-center shadow-lg group-hover:scale-110 transition-transform">
                                            <i class="fas fa-bookmark text-white text-xl md:text-2xl"></i>
                                        </div>
                                        <div
                                            class="text-2xl md:text-4xl font-bold bg-primary-blue bg-clip-text text-transparent">
                                            ${borrowedCount}</div>
                                        <div class="text-gray-600 text-xs md:text-sm font-semibold mt-2">Books Borrowed</div>
                                    </div>
                                </div>
                                <div class="relative group">
                                    <div
                                        class="absolute inset-0 bg-primary-blue rounded-xl opacity-0 group-hover:opacity-10 transition-opacity">
                                    </div>
                                    <div class="relative text-center p-4 md:p-6 rounded-xl">
                                        <div
                                            class="w-12 h-12 md:w-16 md:h-16 mx-auto mb-3 md:mb-4 bg-primary-blue rounded-2xl flex items-center justify-center shadow-lg group-hover:scale-110 transition-transform">
                                            <i class="fas fa-heart text-white text-xl md:text-2xl"></i>
                                        </div>
                                        <div
                                            class="text-2xl md:text-4xl font-bold bg-primary-blue bg-clip-text text-transparent">
                                            ${5 - borrowedCount}</div>
                                        <div class="text-gray-600 text-xs md:text-sm font-semibold mt-2">Borrowing Limit Left</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Library Collection Section -->
                        <div class="mb-6 md:mb-8">
                            <div class="flex items-center gap-3 md:gap-4 mb-2">
                                <div class="h-1 w-8 md:w-12 bg-gradient-to-r from-[#0a2463] to-[#3b82f6] rounded-full"></div>
                                <h2 class="text-2xl md:text-3xl font-bold text-gray-900">
                                    ${not empty searchKeyword ? 'Search Results' : 'Library Collection'}
                                </h2>
                            </div>
                            <c:if test="${not empty searchKeyword}">
                                <p class="text-gray-600 mt-2 text-sm md:text-base">Showing results for: <strong>${searchKeyword}</strong></p>
                            </c:if>
                        </div>

                        <c:choose>
                            <c:when test="${not empty books}">
                                <div id="booksContainer" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                                    <c:forEach var="book" items="${books}">
                                        <div
                                            class="bg-white rounded-2xl overflow-hidden shadow-md hover:shadow-2xl hover:-translate-y-2 transition-all duration-300 flex flex-col border border-gray-100">
                                            <!-- Book Cover -->
                                            <div
                                                class="relative h-48 sm:h-56 md:h-64 bg-gradient-to-br from-[#0a2463] via-[#1e3a8a] to-[#3b82f6] overflow-hidden">
                                                <c:choose>
                                                    <c:when test="${not empty book.coverImage}">
                                                        <img src="${book.coverImage}" alt="${book.title}"
                                                            class="w-full h-full object-cover transition-transform duration-300 hover:scale-105"
                                                            onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                        <div
                                                            class="hidden absolute inset-0 items-center justify-center text-white text-4xl md:text-6xl">
                                                            <i class="fas fa-book-open"></i>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div
                                                            class="absolute inset-0 flex items-center justify-center text-white text-4xl md:text-6xl">
                                                            <i class="fas fa-book-open"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <span
                                                    class="absolute top-3 md:top-4 right-3 md:right-4 px-3 md:px-4 py-1.5 md:py-2 rounded-full text-xs md:text-sm font-semibold ${book.availableQuantity > 0 ? 'bg-gradient-to-r from-green-500 to-green-600' : 'bg-gradient-to-r from-red-500 to-red-600'} text-white">
                                                    ${book.availableQuantity > 0 ? 'Available' : 'Out of Stock'}
                                                </span>
                                            </div>

                                            <!-- Book Details -->
                                            <div class="p-4 md:p-5 flex flex-col flex-1">
                                                <h5 class="text-base md:text-lg font-bold text-gray-900 mb-2 line-clamp-2">${book.title}</h5>
                                                <p class="text-gray-600 text-xs md:text-sm mb-2 truncate">
                                                    <i class="fas fa-user mr-1"></i>by ${book.author}
                                                </p>
                                                <p class="text-gray-500 text-xs mb-2">
                                                    <i class="fas fa-tag mr-1"></i>${book.category}
                                                </p>

                                                <div class="mt-auto">
                                                    <div
                                                        class="flex justify-between items-center mb-3 text-xs text-gray-500">
                                                        <span class="truncate"><i class="fas fa-barcode mr-1"></i>${book.isbn}</span>
                                                        <span><i
                                                                class="fas fa-layer-group mr-1"></i>${book.availableQuantity}/${book.quantity}</span>
                                                    </div>

                                                    <c:choose>
                                                        <c:when
                                                            test="${book.availableQuantity > 0 && borrowedCount < 5}">
                                                            <button type="button" onclick="openBorrowModal('${book.bookId}', '${book.title}', '${book.author}', '${book.isbn}')" class="w-full bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white py-2 md:py-2.5 px-3 md:px-4 rounded-lg font-semibold hover:shadow-xl hover:scale-105 transition-all text-xs md:text-sm">
                                                                <i class="fas fa-hand-holding mr-1 md:mr-2"></i>Borrow Book
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${borrowedCount >= 5}">
                                                            <button
                                                                class="w-full bg-yellow-500 text-white py-2 md:py-2.5 px-3 md:px-4 rounded-lg font-semibold cursor-not-allowed opacity-70 text-xs md:text-sm"
                                                                disabled>
                                                                <i class="fas fa-exclamation-triangle mr-1 md:mr-2"></i>Limit
                                                                Reached
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button
                                                                class="w-full bg-gray-400 text-white py-2 md:py-2.5 px-3 md:px-4 rounded-lg font-semibold cursor-not-allowed opacity-70 text-xs md:text-sm"
                                                                disabled>
                                                                <i class="fas fa-times-circle mr-1 md:mr-2"></i>Out of Stock
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-12 md:py-16">
                                    <i class="fas fa-search text-5xl md:text-6xl text-gray-400 mb-4"></i>
                                    <h4 class="text-xl md:text-2xl text-gray-600 font-semibold mb-2">No books found</h4>
                                    <p class="text-gray-500 text-sm md:text-base">
                                        ${not empty searchKeyword ? 'Try a different search term' : 'No books available
                                        in the library'}
                                    </p>
                                    <c:if test="${not empty searchKeyword}">
                                        <a href="${pageContext.request.contextPath}/memberDashboard"
                                            class="inline-block mt-6 bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white py-3 px-8 rounded-xl font-semibold hover:shadow-xl hover:scale-105 transition-all">
                                            <i class="fas fa-redo mr-2"></i>Clear Search
                                        </a>
                                    </c:if>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Borrow Book Modal -->
                    <div id="borrowModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 hidden items-center justify-center p-4">
                        <div class="bg-white rounded-2xl shadow-2xl max-w-md w-full overflow-hidden transform transition-all">
                            <!-- Modal Header -->
                            <div class="bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] px-6 py-4 flex items-center justify-between">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-white/20 rounded-lg flex items-center justify-center">
                                        <i class="fas fa-book text-white text-lg"></i>
                                    </div>
                                    <h3 class="text-xl font-bold text-white">Borrow Book</h3>
                                </div>
                                <button onclick="closeBorrowModal()" class="text-white/80 hover:text-white transition-colors">
                                    <i class="fas fa-times text-2xl"></i>
                                </button>
                            </div>

                            <!-- Modal Body -->
                            <div class="p-6">
                                <!-- Book Details -->
                                <div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-xl p-4 mb-6">
                                    <div class="flex items-start gap-4">
                                        <div class="w-12 h-16 bg-gradient-to-br from-[#0a2463] to-[#3b82f6] rounded-lg flex items-center justify-center flex-shrink-0">
                                            <i class="fas fa-book-open text-white text-xl"></i>
                                        </div>
                                        <div class="flex-1">
                                            <h4 id="modalBookTitle" class="font-bold text-gray-900 text-lg mb-1"></h4>
                                            <p id="modalBookAuthor" class="text-gray-600 text-sm mb-1"></p>
                                            <p id="modalBookISBN" class="text-gray-500 text-xs"></p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Borrow Information -->
                                <div class="space-y-3 mb-6">
                                    <div class="flex items-center gap-3 text-sm">
                                        <div class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center">
                                            <i class="fas fa-calendar-check text-green-600"></i>
                                        </div>
                                        <div>
                                            <p class="text-gray-500 text-xs">Borrow Date</p>
                                            <p class="font-semibold text-gray-900" id="borrowDate"></p>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-3 text-sm">
                                        <div class="w-8 h-8 bg-orange-100 rounded-lg flex items-center justify-center">
                                            <i class="fas fa-calendar-times text-orange-600"></i>
                                        </div>
                                        <div>
                                            <p class="text-gray-500 text-xs">Due Date (7 days)</p>
                                            <p class="font-semibold text-gray-900" id="dueDate"></p>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-3 text-sm">
                                        <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                            <i class="fas fa-info-circle text-blue-600"></i>
                                        </div>
                                        <div>
                                            <p class="text-gray-700">Please return the book within 7 days</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Warning Message -->
                                <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4 rounded-r-lg mb-6">
                                    <div class="flex items-start gap-3">
                                        <i class="fas fa-exclamation-triangle text-yellow-600 mt-1"></i>
                                        <div>
                                            <p class="font-semibold text-yellow-800 text-sm">Important</p>
                                            <p class="text-yellow-700 text-xs mt-1">You can borrow up to 5 books at a time. Currently borrowed: <span class="font-bold">${borrowedCount}</span></p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <form id="borrowForm" method="post" action="${pageContext.request.contextPath}/member/borrow">
                                    <input type="hidden" name="bookId" id="modalBookId">
                                    <div class="flex gap-3">
                                        <button type="button" onclick="closeBorrowModal()" class="flex-1 px-6 py-3 border-2 border-gray-300 text-gray-700 rounded-lg font-semibold hover:bg-gray-50 transition-all">
                                            Cancel
                                        </button>
                                        <button type="submit" class="flex-1 px-6 py-3 bg-gradient-to-r from-[#0a2463] to-[#1e3a8a] text-white rounded-lg font-semibold hover:shadow-xl hover:scale-105 transition-all">
                                            <i class="fas fa-check mr-2"></i>Confirm Borrow
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <script>
                        // AJAX search without page refresh
                        document.getElementById('searchForm').addEventListener('submit', function(e) {
                            e.preventDefault();
                            const searchValue = document.getElementById('searchInput').value;
                            performSearch(searchValue);
                        });

                        function performSearch(searchKeyword) {
                            fetch('${pageContext.request.contextPath}/memberDashboard?search=' + encodeURIComponent(searchKeyword), {
                                headers: {
                                    'X-Requested-With': 'XMLHttpRequest'
                                }
                            })
                            .then(response => response.text())
                            .then(html => {
                                const parser = new DOMParser();
                                const doc = parser.parseFromString(html, 'text/html');
                                const newBooksContainer = doc.querySelector('#booksContainer') || doc.querySelector('.text-center.py-16');
                                const currentContainer = document.querySelector('#booksContainer') || document.querySelector('.text-center.py-16');
                                
                                if (newBooksContainer && currentContainer) {
                                    currentContainer.outerHTML = newBooksContainer.outerHTML;
                                }

                                // Update clear button visibility
                                const clearBtn = document.querySelector('button[onclick="clearSearch()"]');
                                if (searchKeyword && searchKeyword.trim() !== '') {
                                    if (!clearBtn) {
                                        const input = document.getElementById('searchInput');
                                        const btn = document.createElement('button');
                                        btn.type = 'button';
                                        btn.onclick = clearSearch;
                                        btn.className = 'text-gray-400 hover:text-gray-600 transition-colors px-2';
                                        btn.innerHTML = '<i class="fas fa-times"></i>';
                                        input.parentElement.insertBefore(btn, input.nextSibling);
                                    }
                                } else if (clearBtn) {
                                    clearBtn.remove();
                                }
                            })
                            .catch(error => console.error('Search error:', error));
                        }

                        // Clear search and show all books
                        function clearSearch() {
                            document.getElementById('searchInput').value = '';
                            performSearch('');
                        }

                        // Open borrow modal with book details
                        function openBorrowModal(bookId, title, author, isbn) {
                            document.getElementById('modalBookId').value = bookId;
                            document.getElementById('modalBookTitle').textContent = title;
                            document.getElementById('modalBookAuthor').textContent = 'by ' + author;
                            document.getElementById('modalBookISBN').textContent = 'ISBN: ' + isbn;
                            
                            // Set dates
                            const today = new Date();
                            const dueDate = new Date(today);
                            dueDate.setDate(dueDate.getDate() + 7);
                            
                            document.getElementById('borrowDate').textContent = formatDate(today);
                            document.getElementById('dueDate').textContent = formatDate(dueDate);
                            
                            // Show modal
                            const modal = document.getElementById('borrowModal');
                            modal.classList.remove('hidden');
                            modal.classList.add('flex');
                        }

                        // Close borrow modal
                        function closeBorrowModal() {
                            const modal = document.getElementById('borrowModal');
                            modal.classList.add('hidden');
                            modal.classList.remove('flex');
                        }

                        // Format date to readable string
                        function formatDate(date) {
                            const options = { year: 'numeric', month: 'long', day: 'numeric' };
                            return date.toLocaleDateString('en-US', options);
                        }

                        // Close modal when clicking outside
                        document.getElementById('borrowModal').addEventListener('click', function(e) {
                            if (e.target === this) {
                                closeBorrowModal();
                            }
                        });
                    </script>
        </body>

        </html>