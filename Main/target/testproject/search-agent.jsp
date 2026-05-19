<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.usermgmt.model.Agent" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Search Agent</title>
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

<nav class="bg-navy h-14 flex items-center justify-between px-6 sticky top-0 z-10">
    <a href="index.jsp" class="flex items-center gap-2 no-underline">
        <span class="font-sora font-semibold text-white text-base">RealEstate</span>
    </a>
    <div class="flex gap-1">
        <a href="register-agent.jsp" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">Register agent</a>
        <a href="AgentServlet?action=list" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">All agents</a>
        <a href="search-agent.jsp" class="px-3 py-1.5 rounded-md bg-accent text-white text-sm no-underline">Search agent</a>
    </div>
</nav>

<main class="max-w-5xl mx-auto px-6 py-8">

    <div class="mb-6">
        <h1 class="font-sora text-xl font-semibold text-slate-800 mb-1">Search &amp; update agent</h1>
        <p class="text-sm text-slate-500">Find an agent by ID, then view or edit their details.</p>
    </div>

    <% String success=(String)request.getAttribute("success"); String error=(String)request.getAttribute("error");
        if(success!=null){ %>
    <div class="bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-lg px-4 py-3 text-sm mb-5"><%= success %></div>
    <% } else if(error!=null){ %>
    <div class="bg-red-50 border border-red-200 text-red-700 rounded-lg px-4 py-3 text-sm mb-5"><%= error %></div>
    <% } %>

    <%
        Agent found = (Agent) request.getAttribute("foundAgent");
        boolean searched = request.getAttribute("searched") != null;
    %>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-5">

        <!-- Search card -->
        <div class="bg-white border border-slate-200 rounded-xl p-6 shadow-sm h-fit">
            <p class="font-sora font-semibold text-slate-800 text-sm mb-4">Find agent</p>
            <form action="AgentServlet" method="get" class="space-y-4">
                <input type="hidden" name="action" value="search"/>
                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Agent ID</label>
                    <input type="text" name="agentId" placeholder="e.g. AGT001"
                           value="<%= request.getParameter("agentId") != null ? request.getParameter("agentId") : "" %>"
                           class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                </div>
                <button type="submit"
                        class="w-full py-2.5 bg-accent hover:bg-blue-500 text-white font-sora font-semibold text-sm rounded-lg transition-colors">
                    Search
                </button>
            </form>
        </div>

        <% if (found != null) {
            String initials = "";
            if (found.getFirstName()!=null&&!found.getFirstName().isEmpty()) initials+=found.getFirstName().charAt(0);
            if (found.getLastName()!=null&&!found.getLastName().isEmpty())   initials+=found.getLastName().charAt(0);
        %>

        <!-- Edit card -->
        <div class="bg-white border border-slate-200 rounded-xl p-6 shadow-sm">
            <p class="font-sora font-semibold text-slate-800 text-sm mb-4">Edit agent</p>

            <div class="flex items-center gap-3 mb-5 pb-5 border-b border-slate-100">
                <div class="w-12 h-12 rounded-full bg-blue-100 text-blue-700 flex items-center justify-center font-sora font-semibold text-base flex-shrink-0">
                    <%= initials.toUpperCase() %>
                </div>
                <div>
                    <p class="font-semibold text-slate-800 text-sm leading-none mb-0.5"><%= found.getFirstName() %> <%= found.getLastName() %></p>
                    <p class="text-xs text-slate-400"><%= found.getEmail() %></p>
                </div>
            </div>

            <form action="AgentServlet" method="post" class="space-y-4">
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="originalId" value="<%= found.getAgentId() %>"/>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">First name</label>
                        <input type="text" name="firstName" value="<%= found.getFirstName() %>" required
                               class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Last name</label>
                        <input type="text" name="lastName" value="<%= found.getLastName() %>"
                               class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Email</label>
                    <input type="email" name="email" value="<%= found.getEmail() %>" required
                           class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                </div>

                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Phone</label>
                    <input type="tel" name="phone" value="<%= found.getPhone()!=null ? found.getPhone() : "" %>"
                           class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                </div>

                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Specialization</label>
                    <select name="specialization"
                            class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-700 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition">
                        <option value="Residential" <%= "Residential".equals(found.getSpecialization())?"selected":"" %>>Residential</option>
                        <option value="Commercial"  <%= "Commercial".equals(found.getSpecialization()) ?"selected":"" %>>Commercial</option>
                        <option value="Industrial"  <%= "Industrial".equals(found.getSpecialization()) ?"selected":"" %>>Industrial</option>
                        <option value="Land"        <%= "Land".equals(found.getSpecialization())       ?"selected":"" %>>Land</option>
                        <option value="Luxury"      <%= "Luxury".equals(found.getSpecialization())     ?"selected":"" %>>Luxury</option>
                    </select>
                </div>

                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Location</label>
                    <input type="text" name="location" value="<%= found.getLocation()!=null ? found.getLocation() : "" %>"
                           class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Experience (yrs)</label>
                        <input type="number" name="experience" value="<%= found.getExperience() %>" min="0"
                               class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Status</label>
                        <select name="status"
                                class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-700 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition">
                            <option value="Active"   <%= "Active".equals(found.getStatus())   ?"selected":"" %>>Active</option>
                            <option value="Inactive" <%= "Inactive".equals(found.getStatus()) ?"selected":"" %>>Inactive</option>
                            <option value="On Leave" <%= "On Leave".equals(found.getStatus()) ?"selected":"" %>>On Leave</option>
                        </select>
                    </div>
                </div>

                <button type="submit"
                        class="w-full py-2.5 bg-emerald-500 hover:bg-emerald-600 text-white font-sora font-semibold text-sm rounded-lg transition-colors">
                    Save changes
                </button>
            </form>
        </div>

        <!-- Agent details (full width) -->
        <div class="lg:col-span-2 bg-white border border-slate-200 rounded-xl p-6 shadow-sm">
            <p class="font-sora font-semibold text-slate-800 text-sm mb-4">Agent details</p>
            <div class="divide-y divide-slate-100">
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Agent ID</span><span class="font-medium text-slate-800"><%= found.getAgentId() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Full name</span><span class="font-medium text-slate-800"><%= found.getFirstName() %> <%= found.getLastName() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Email</span><span class="font-medium text-slate-800"><%= found.getEmail() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Phone</span><span class="font-medium text-slate-800"><%= found.getPhone()!=null ? found.getPhone() : "—" %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Specialization</span><span class="font-medium text-slate-800"><%= found.getSpecialization() %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Location</span><span class="font-medium text-slate-800"><%= found.getLocation()!=null ? found.getLocation() : "—" %></span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Experience</span><span class="font-medium text-slate-800"><%= found.getExperience() %> years</span></div>
                <div class="flex justify-between py-2.5 text-sm"><span class="text-slate-400">Status</span><span class="font-medium text-slate-800"><%= found.getStatus() %></span></div>
            </div>
        </div>

        <% } else if (searched) { %>

        <div class="bg-white border border-slate-200 rounded-xl p-6 shadow-sm flex flex-col items-center justify-center text-center py-16">
            <p class="text-3xl mb-3">🔍</p>
            <p class="font-medium text-slate-700 mb-1">No agent found</p>
            <p class="text-sm text-slate-400">Try a different Agent ID.</p>
        </div>

        <% } else { %>

        <div class="bg-white border border-slate-200 rounded-xl p-6 shadow-sm flex flex-col items-center justify-center text-center py-16">
            <p class="text-3xl mb-3">👈</p>
            <p class="font-medium text-slate-700 mb-1">Search for an agent</p>
            <p class="text-sm text-slate-400">Enter an Agent ID on the left to get started.</p>
        </div>

        <% } %>

    </div>
</main>
</body>
</html>