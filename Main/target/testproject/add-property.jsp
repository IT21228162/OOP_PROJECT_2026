<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Add Property</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@500;600&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          fontFamily: { sans: ['DM Sans', 'sans-serif'], sora: ['Sora', 'sans-serif'] },
          colors: { navy: '#0d1b3e', accent: '#4f8ef7' }
        }
      }
    }
  </script>
</head>
<body class="bg-slate-50 font-sans min-h-screen flex flex-col">

<!-- Navbar -->
<nav class="bg-navy h-14 flex items-center justify-between px-6 sticky top-0 z-10">
  <a href="index.jsp" class="flex items-center gap-2 no-underline">
    <span class="font-sora font-semibold text-white text-base">RealEstate</span>
  </a>
  <div class="flex gap-1">
    <a href="add-property.jsp" class="px-3 py-1.5 rounded-md bg-accent text-white text-sm no-underline">Add property</a>
    <a href="PropertyServlet?action=list" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">All properties</a>
    <a href="search-property.jsp" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">Search</a>
  </div>
</nav>

<!-- Main -->
<main class="flex-1 flex justify-center px-4 py-10">
  <div class="bg-white border border-slate-200 rounded-xl p-8 w-full max-w-xl shadow-sm">

    <div class="mb-6">
      <h1 class="font-sora text-xl font-semibold text-slate-800 mb-1">Add new property</h1>
      <p class="text-sm text-slate-500">Fill in the details to list a new property.</p>
    </div>

    <% String success = (String) request.getAttribute("success");
      String error   = (String) request.getAttribute("error");
      if (success != null) { %>
    <div class="bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-lg px-4 py-3 text-sm mb-5"><%= success %></div>
    <% } else if (error != null) { %>
    <div class="bg-red-50 border border-red-200 text-red-700 rounded-lg px-4 py-3 text-sm mb-5"><%= error %></div>
    <% } %>

    <form action="PropertyServlet" method="post" class="space-y-4">
      <input type="hidden" name="action" value="create"/>

      <!-- Row 1 -->
      <div class="grid grid-cols-2 gap-4">
        <div>
          <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Property ID</label>
          <input type="text" name="propertyId" placeholder="e.g. PROP001" required
                 class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
        </div>
        <div>
          <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Type</label>
          <select name="type"
                  class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition">
            <option>House</option><option>Apartment</option><option>Villa</option><option>Land</option><option>Commercial</option>
          </select>
        </div>
      </div>

      <!-- Title -->
      <div>
        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Title</label>
        <input type="text" name="title" placeholder="e.g. Modern 3BR House in Colombo" required
               class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
      </div>

      <!-- Location -->
      <div>
        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Location</label>
        <input type="text" name="location" placeholder="e.g. Colombo 07, Sri Lanka" required
               class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
      </div>

      <!-- Price -->
      <div>
        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Price (LKR)</label>
        <input type="text" name="price" placeholder="e.g. 25,000,000"
               class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
      </div>

      <hr class="border-slate-100"/>

      <!-- Bedrooms / Bathrooms -->
      <div class="grid grid-cols-2 gap-4">
        <div>
          <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Bedrooms</label>
          <input type="number" name="bedrooms" placeholder="3" min="0"
                 class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
        </div>
        <div>
          <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Bathrooms</label>
          <input type="number" name="bathrooms" placeholder="2" min="0"
                 class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
        </div>
      </div>

      <!-- Area / Agent -->
      <div class="grid grid-cols-2 gap-4">
        <div>
          <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Area (sqft)</label>
          <input type="text" name="area" placeholder="e.g. 2500"
                 class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
        </div>
        <div>
          <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Agent ID</label>
          <input type="text" name="agentId" placeholder="e.g. AGT001"
                 class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
        </div>
      </div>

      <!-- Status -->
      <div>
        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Status</label>
        <select name="status"
                class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition">
          <option>Available</option><option>Sold</option><option>Rented</option><option>Under Offer</option>
        </select>
      </div>

      <button type="submit"
              class="w-full py-2.5 bg-accent hover:bg-blue-500 text-white font-sora font-semibold text-sm rounded-lg transition-colors">
        Add property
      </button>

    </form>
  </div>
</main>
</body>
</html>