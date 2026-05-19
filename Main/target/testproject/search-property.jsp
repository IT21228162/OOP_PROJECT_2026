<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.usermgmt.model.Property" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Search Property</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@500;600&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['DM Sans','sans-serif'], sora: ['Sora','sans-serif'] },
                    colors: { navy: '#0d1b3e', accent: '#4f8ef7' }
                }
            }
        }
    </script>
</head>
<body class="bg-slate-50 font-sans min-h-screen">

<!-- Navbar -->
<nav class="bg-navy h-14 flex items-center justify-between px-6 sticky top-0 z-10">
    <a href="index.jsp" class="flex items-center gap-2 no-underline">
        <span class="font-sora font-semibold text-white text-base">RealEstate</span>
    </a>
    <div class="flex gap-1">
        <a href="add-property.jsp" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">Add property</a>
        <a href="PropertyServlet?action=list" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">All properties</a>
        <a href="search-property.jsp" class="px-3 py-1.5 rounded-md bg-accent text-white text-sm no-underline">Search property</a>
    </div>
</nav>

<main class="max-w-5xl mx-auto px-6 py-8">

    <!-- Page header -->
    <div class="mb-6">
        <h1 class="font-sora text-xl font-semibold text-slate-800 mb-1">Search &amp; update property</h1>
        <p class="text-sm text-slate-500">Find a property by ID, then view or edit its details.</p>
    </div>

    <!-- Alerts -->
    <% String success=(String)request.getAttribute("success"); String error=(String)request.getAttribute("error");
        if(success!=null){ %>
    <div class="bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-lg px-4 py-3 text-sm mb-5"><%= success %></div>
    <% } else if(error!=null){ %>
    <div class="bg-red-50 border border-red-200 text-red-700 rounded-lg px-4 py-3 text-sm mb-5"><%= error %></div>
    <% } %>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-5">

        <!-- Search card -->
        <div class="bg-white border border-slate-200 rounded-xl p-6 shadow-sm h-fit">
            <p class="font-sora font-semibold text-slate-800 text-sm mb-4">Find property</p>
            <form action="PropertyServlet" method="get" class="space-y-4">
                <input type="hidden" name="action" value="search"/>
                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Property ID</label>
                    <input type="text" name="propertyId" placeholder="e.g. PROP001"
                           value="<%= request.getParameter("propertyId") != null ? request.getParameter("propertyId") : "" %>"
                           class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                </div>
                <button type="submit"
                        class="w-full py-2.5 bg-accent hover:bg-blue-500 text-white font-sora font-semibold text-sm rounded-lg transition-colors">
                    Search
                </button>
            </form>
        </div>

        <%
            Property found = (Property) request.getAttribute("foundProperty");
            boolean searched = request.getAttribute("searched") != null;
        %>

        <% if (found != null) { %>

        <!-- Edit card -->
        <div class="bg-white border border-slate-200 rounded-xl p-6 shadow-sm">
            <p class="font-sora font-semibold text-slate-800 text-sm mb-4">Edit property</p>

            <form action="PropertyServlet" method="post" class="space-y-4">
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="originalId" value="<%= found.getPropertyId() %>"/>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Type</label>
                        <select name="type"
                                class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-700 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition">
                            <option value="House"      <%= "House".equals(found.getType())      ?"selected":"" %>>House</option>
                            <option value="Apartment"  <%= "Apartment".equals(found.getType())  ?"selected":"" %>>Apartment</option>
                            <option value="Villa"      <%= "Villa".equals(found.getType())      ?"selected":"" %>>Villa</option>
                            <option value="Land"       <%= "Land".equals(found.getType())       ?"selected":"" %>>Land</option>
                            <option value="Commercial" <%= "Commercial".equals(found.getType()) ?"selected":"" %>>Commercial</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Status</label>
                        <select name="status"
                                class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-700 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition">
                            <option value="Available"   <%= "Available".equals(found.getStatus())   ?"selected":"" %>>Available</option>
                            <option value="Sold"        <%= "Sold".equals(found.getStatus())        ?"selected":"" %>>Sold</option>
                            <option value="Rented"      <%= "Rented".equals(found.getStatus())      ?"selected":"" %>>Rented</option>
                            <option value="Under Offer" <%= "Under Offer".equals(found.getStatus()) ?"selected":"" %>>Under Offer</option>
                        </select>
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Title</label>
                    <input type="text" name="title" value="<%= found.getTitle() %>" required
                           class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                </div>

                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Location</label>
                    <input type="text" name="location" value="<%= found.getLocation() %>" required
                           class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                </div>

                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Price (LKR)</label>
                    <input type="text" name="price" value="<%= found.getPrice() %>"
                           class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Bedrooms</label>
                        <input type="number" name="bedrooms" value="<%= found.getBedrooms() %>" min="0"
                               class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Bathrooms</label>
                        <input type="number" name="bathrooms" value="<%= found.getBathrooms() %>" min="0"
                               class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Area (sqft)</label>
                        <input type="text" name="area" value="<%= found.getArea() %>"
                               class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Agent ID</label>
                        <input type="text" name="agentId" value="<%= found.getAgentId() %>"
                               class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                    </div>
                </div>

                <button type="submit"
                        class="w-full py-2.5 bg-emerald-500 hover:bg-emerald-600 text-white font-sora font-semibold text-sm rounded-lg transition-colors">
                    Save changes
                </button>
            </form>
        </div>

        <!-- Property details (full width) -->
        <div class="lg:col-span-2 bg-white border border-slate-200 rounded-xl p-6 shadow-sm">
            <p class="font-sora font-semibold text-slate-800 text-sm mb-4">Property details</p>
            <div class="divide-y divide-slate-100">
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Property ID</span><span class="font-medium text-slate-800"><%= found.getPropertyId() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Title</span><span class="font-medium text-slate-800"><%= found.getTitle() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Type</span><span class="font-medium text-slate-800"><%= found.getType() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Location</span><span class="font-medium text-slate-800"><%= found.getLocation() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Price</span><span class="font-medium text-slate-800">LKR <%= found.getPrice() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Bedrooms</span><span class="font-medium text-slate-800"><%= found.getBedrooms() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Bathrooms</span><span class="font-medium text-slate-800"><%= found.getBathrooms() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Area</span><span class="font-medium text-slate-800"><%= found.getArea() %> sqft</span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Agent ID</span><span class="font-medium text-slate-800"><%= found.getAgentId() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Status</span><span class="font-medium text-slate-800"><%= found.getStatus() %></span></div>
            </div>
        </div>

        <% } else if (searched) { %>

        <div class="bg-white border border-slate-200 rounded-xl p-6 shadow-sm flex flex-col items-center justify-center text-center py-16">
            <p class="text-3xl mb-3">🔍</p>
            <p class="font-medium text-slate-700 mb-1">No property found</p>
            <p class="text-sm text-slate-400">Try a different Property ID.</p>
        </div>

        <% } else { %>

        <div class="bg-white border border-slate-200 rounded-xl p-6 shadow-sm flex flex-col items-center justify-center text-center py-16">
            <p class="text-3xl mb-3">👈</p>
            <p class="font-medium text-slate-700 mb-1">Search for a property</p>
            <p class="text-sm text-slate-400">Enter a Property ID on the left to get started.</p>
        </div>

        <% } %>

    </div>
</main>
</body>
</html>