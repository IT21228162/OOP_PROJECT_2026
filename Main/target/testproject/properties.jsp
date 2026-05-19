<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.usermgmt.model.Property" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>All Properties</title>
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
        <a href="PropertyServlet?action=list" class="px-3 py-1.5 rounded-md bg-accent text-white text-sm no-underline">All properties</a>
        <a href="search-property.jsp" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">Search property</a>
    </div>
</nav>

<main class="max-w-7xl mx-auto px-6 py-8">

    <!-- Page header -->
    <div class="flex items-end justify-between mb-5">
        <div>
            <h1 class="font-sora text-xl font-semibold text-slate-800 mb-0.5">Property listings</h1>
            <p class="text-sm text-slate-500">Manage all real estate properties.</p>
        </div>
        <a href="add-property.jsp" class="px-4 py-2 bg-accent text-white rounded-lg text-sm font-semibold no-underline hover:bg-blue-500 transition-colors">+ Add property</a>
    </div>

    <!-- Alerts -->
    <% String success=(String)request.getAttribute("success"); String error=(String)request.getAttribute("error");
        if(success!=null){ %>
    <div class="bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-lg px-4 py-3 text-sm mb-5"><%= success %></div>
    <% } else if(error!=null){ %>
    <div class="bg-red-50 border border-red-200 text-red-700 rounded-lg px-4 py-3 text-sm mb-5"><%= error %></div>
    <% } %>

    <%
        List<Property> properties = (List<Property>) request.getAttribute("properties");
        int total = properties != null ? properties.size() : 0;
        int available = 0, sold = 0;
        if (properties != null) for (Property p : properties) {
            if ("Available".equals(p.getStatus())) available++;
            if ("Sold".equals(p.getStatus())) sold++;
        }
    %>

    <!-- Stats -->
    <div class="grid grid-cols-3 gap-3 mb-5">
        <div class="bg-white border border-slate-200 rounded-lg px-5 py-4">
            <p class="text-xs text-slate-400 uppercase tracking-wide mb-1">Total</p>
            <p class="font-sora text-2xl font-semibold text-slate-800"><%= total %></p>
        </div>
        <div class="bg-white border border-slate-200 rounded-lg px-5 py-4">
            <p class="text-xs text-slate-400 uppercase tracking-wide mb-1">Available</p>
            <p class="font-sora text-2xl font-semibold text-slate-800"><%= available %></p>
        </div>
        <div class="bg-white border border-slate-200 rounded-lg px-5 py-4">
            <p class="text-xs text-slate-400 uppercase tracking-wide mb-1">Sold</p>
            <p class="font-sora text-2xl font-semibold text-slate-800"><%= sold %></p>
        </div>
    </div>

    <!-- Filters -->
    <div class="flex gap-3 mb-4 flex-wrap">
        <input type="text" id="searchInput" placeholder="Search by title, location, agent ID…" oninput="filterTable()"
               class="flex-1 min-w-48 px-3 py-2 border border-slate-200 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent"/>
        <select id="typeFilter" onchange="filterTable()"
                class="px-3 py-2 border border-slate-200 rounded-lg text-sm bg-white text-slate-700 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent">
            <option value="">All types</option>
            <option>House</option><option>Apartment</option><option>Villa</option><option>Land</option><option>Commercial</option>
        </select>
        <select id="statusFilter" onchange="filterTable()"
                class="px-3 py-2 border border-slate-200 rounded-lg text-sm bg-white text-slate-700 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent">
            <option value="">All status</option>
            <option>Available</option><option>Sold</option><option>Rented</option><option>Under Offer</option>
        </select>
    </div>

    <!-- Table -->
    <div class="bg-white border border-slate-200 rounded-xl overflow-hidden">
        <table id="propTable" class="w-full border-collapse">
            <thead class="bg-slate-50 border-b border-slate-200">
            <tr>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Property</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">ID</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Type</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Price</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Beds / Baths</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Area</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Agent</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Status</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (properties == null || properties.isEmpty()) { %>
            <tr>
                <td colspan="9" class="text-center py-12 text-slate-400 text-sm">
                    No properties found. <a href="add-property.jsp" class="text-accent">Add the first one.</a>
                </td>
            </tr>
            <% } else { for (Property p : properties) {
                String statusCls = "Available".equals(p.getStatus())   ? "bg-emerald-50 text-emerald-700"
                        : "Sold".equals(p.getStatus())        ? "bg-red-50 text-red-700"
                          : "Rented".equals(p.getStatus())      ? "bg-blue-50 text-blue-700"
                            : "bg-amber-50 text-amber-700";
            %>
            <tr class="border-b border-slate-100 hover:bg-slate-50 transition-colors"
                data-search="<%= (p.getTitle()+" "+p.getLocation()+" "+p.getAgentId()).toLowerCase() %>"
                data-type="<%= p.getType() %>"
                data-status="<%= p.getStatus() %>">

                <td class="px-4 py-3">
                    <p class="text-sm font-medium text-slate-800 leading-none mb-0.5"><%= p.getTitle() %></p>
                    <p class="text-xs text-slate-400"><%= p.getLocation() %></p>
                </td>

                <td class="px-4 py-3">
                    <code class="text-xs bg-slate-100 text-slate-600 px-2 py-0.5 rounded"><%= p.getPropertyId() %></code>
                </td>

                <td class="px-4 py-3">
                    <span class="inline-flex px-2.5 py-0.5 rounded-full text-xs font-semibold bg-violet-50 text-violet-700"><%= p.getType() %></span>
                </td>

                <td class="px-4 py-3">
                    <span class="font-sora text-sm font-semibold text-slate-800">LKR <%= p.getPrice() %></span>
                </td>

                <td class="px-4 py-3 text-sm text-slate-600">
                    <%= p.getBedrooms() %> bd / <%= p.getBathrooms() %> ba
                </td>

                <td class="px-4 py-3 text-sm text-slate-600"><%= p.getArea() %> sqft</td>

                <td class="px-4 py-3">
                    <code class="text-xs text-slate-500"><%= p.getAgentId()!=null ? p.getAgentId() : "—" %></code>
                </td>

                <td class="px-4 py-3">
                    <span class="inline-flex px-2.5 py-0.5 rounded-full text-xs font-semibold <%= statusCls %>"><%= p.getStatus() %></span>
                </td>

                <td class="px-4 py-3">
                    <div class="flex gap-2">
                        <a href="PropertyServlet?action=search&propertyId=<%= p.getPropertyId() %>"
                           class="px-3 py-1 rounded-md text-xs font-medium border border-slate-200 bg-white text-slate-700 no-underline hover:bg-slate-50 transition-colors">Edit</a>
                        <form action="PropertyServlet" method="post" class="inline" onsubmit="return confirm('Delete property <%= p.getPropertyId() %>?')">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="propertyId" value="<%= p.getPropertyId() %>"/>
                            <button type="submit" class="px-3 py-1 rounded-md text-xs font-medium border border-red-200 text-red-500 bg-transparent hover:bg-red-50 cursor-pointer transition-colors">Delete</button>
                        </form>
                    </div>
                </td>
            </tr>
            <% } } %>
            </tbody>
        </table>
    </div>

</main>

<script>
    function filterTable() {
        const q      = document.getElementById('searchInput').value.toLowerCase();
        const type   = document.getElementById('typeFilter').value;
        const status = document.getElementById('statusFilter').value;
        document.querySelectorAll('#propTable tbody tr[data-search]').forEach(row => {
            const ms  = !q      || row.dataset.search.includes(q);
            const mt  = !type   || row.dataset.type   === type;
            const mst = !status || row.dataset.status === status;
            row.style.display = ms && mt && mst ? '' : 'none';
        });
    }
</script>
</body>
</html>